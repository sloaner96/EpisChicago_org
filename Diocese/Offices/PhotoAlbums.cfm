<cfif attributes.albumID EQ 0>
	<CFQUERY Name="Listing" Datasource="#Application.DSN#">
		SELECT * from Album
			WHERE GroupID = #Attributes.GroupID#
			ORDER By EventDate DESC, AlbName
	</CFQUERY>
	
	
	<blockquote>
	<font face="Verdana" size="-1">
	
	
	<CFIF Listing.RecordCount eq 0>
		<div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO ALBUMS FOR THIS GROUP</strong></font></div> 
	<CFELSE>
		<blockquote>
		<p>Here is a listing of the photo albums currently available online.  Please click on a highlighted Event Name to view the photos for that event.</p>
		</blockquote>
		
		<center>
		<table border=0 cellpadding=1 cellspacing=3>
		<tr bgcolor="#330066">
			<th width=120 align=left><font face="arial" color="ffffff" size="-1">Event Date</font></th>
			<th align=left><font face="arial" color="ffffff" size="-1">Event Name & Description</font></th>
		</tr>
	
		<CFOUTPUT Query="Listing">
		<tr valign=top>
			<td><font face="verdana" size="-1">#DateFormat(EventDate, "mmm d, yyyy")#</font></td>
			<td><font face="verdana" size="-1"><a href="SiteContent.cfm?AlbumID=#AlbumID#&GroupID=#Attributes.GroupID#&GCID=#attributes.GrpContentID#&PNbr=1"><font face="tahoma" size="-1">#AlbName#</font></a><br><i>Photos in album: #NumPhotos#</i><br>#ParagraphFormat(EventDesc)#</font></td>
		</tr>
		</CFOUTPUT>
	
		</table>
		</center>
	
	</CFIF>
	
	</font>
	</blockquote>

<CFELSEIF attributes.AlbumID NEQ 0>
	
	
	<CFIF NOT IsDefined("attributes.PNbr")>
		<CFSET PNbr = 1>
	<CFELSE>
		<CFSET PNbr = #attributes.PNbr#>
	</CFIF>
	
	
	<CFQUERY Name="Alb" Datasource="#Application.dsn#">
		SELECT * from Album
			WHERE AlbumID = #attributes.AlbumID#
			AND GroupID = #attributes.GroupID#
	</CFQUERY>
	
	<CFQUERY Name="Photo" Datasource="#Application.dsn#">
		SELECT * from AlbPhotos
			WHERE AlbumID = #attributes.AlbumID# AND Sequence = #PNbr#
	</CFQUERY>
	
	
	<font face="Verdana,Arial" size="-1">
	
	
	<CFIF Alb.RecordCount eq 0>
	
		<h3 align=center>Sorry, this Album no longer exists!</h3>
	
	<CFELSE>
	
		<CFSET #NextPix# = #IIF( PNbr GTE Alb.NumPhotos, 1, PNbr+1 )#>
		<CFSET #PrevPix# = #IIF( PNbr LTE 1, Alb.NumPhotos, PNbr-1 )#>
	
		<center>
		<table cellpadding=5 cellspacing=0 border=0>
		<tr valign=top>
			<td width=175>
				<font size="-1">
				<cfoutput>
				<center>
				<CFIF Alb.EventID gt 0><a href="ListEvents.cfm?EventID=#Alb.EventID#&GroupID=#Attributes.GroupID#&GCID=#attributes.GrpContentID#"><font size="-1">View Calendar Event</font></a><br></CFIF>
				<A HREF="SiteContent.cfm?GroupID=#Attributes.GroupID#&GCID=#Attributes.GrpContentID#">View Photo Albums</A><br>
				</center>
	
				<p align=center>Picture #PNbr# of #Alb.NumPhotos#<br>
				<A HREF="SiteContent.cfm?AlbumID=#AlbumID#&GroupID=#Attributes.GroupID#&GCID=#attributes.GrpContentID#&PNbr=#PrevPix#"><IMG SRC="/images/PrevArrow.gif" WIDTH=31 HEIGHT=31 BORDER=0 ALT="Select Previous Photo"></A>&nbsp;&nbsp;&nbsp;
				<A HREF="SiteContent.cfm?AlbumID=#AlbumID#&GroupID=#Attributes.GroupID#&GCID=#attributes.GrpContentID#&PNbr=#NextPix#"><IMG SRC="/images/NextArrow.gif" WIDTH=31 HEIGHT=31 BORDER=0 ALT="Select Next Photo"></A></p>
				</cfoutput>
				</font>
			</td>
	
			<td width=415>
				<CFOUTPUT>
				<font face="Tahoma,Arial" size="-1">#Replace(Alb.EventDesc,"#chr(13)##chr(10)#","<br>","ALL")#</font><hr>
				</CFOUTPUT>
			</td>
		</tr>
		</table>
	
		<CFOUTPUT Query="Photo">
		<blockquote><p align=center><font color=blue face="Verdana,Arial" size="+1">#Caption#</font></p></blockquote>
		<center>
		<CFIF #Width# gt 0 AND #Height# gt 0>
			<IMG SRC="#Alb.PhotoPath#/#Filename#" WIDTH="#Width#" HEIGHT="#Height#" BORDER=1 ALT="#AltText#">
		<CFELSE>
			<IMG SRC="#Alb.PhotoPath#/#Filename#" BORDER=1 ALT="#AltText#">
		</CFIF>
		</center>
		</CFOUTPUT>
	
	</CFIF>
	
	</font>
</cfif>