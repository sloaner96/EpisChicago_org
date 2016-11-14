
<cfset url.groupid = "31">
<cfparam name="url.albumID" default="0">
<cfparam name="url.album" default="0">
<cfif Not IsNumeric(url.groupid)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfif Findnocase(";", url.groupid, 1)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfset groupid = url.groupid>

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>


<cfset Today = now()>
<cfset NextThirty = DateAdd('d', 30, today)>

<cfquery name="GroupEvents" datasource="#Application.DSN#">
	SELECT *
	From Events
	Where ((BeginDate >= #CreateODBCDate(Today)# AND BeginDate <= #CreateodbcDate(NextThirty)#)
	OR  EndDate >= #CreateODBCDate(Today)#)
	AND OwningGroupID = #GroupID#
	Order By GrpHighlight, Begindate desc
</cfquery>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<cfoutput>
	<TITLE>Chicago Diocese -- Episcopal Ministry</TITLE>
    </cfoutput>
</head>

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <table border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                <td>
				  <cfif url.albumID EQ 0>
					   <CFQUERY Name="Listing" Datasource="#Application.DSN#">
							SELECT * from Album
								WHERE GroupID = #GroupID#
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
								<td><font face="verdana" size="-1"><a href="PhotoAlbum.cfm?AlbumID=#AlbumID#&GroupID=#GroupID#&PNbr=1"><font face="tahoma" size="-1">#AlbName#</font></a><br><i>Photos in album: #NumPhotos#</i><br>#ParagraphFormat(EventDesc)#</font></td>
							</tr>
							</CFOUTPUT>
						
							</table>
							</center>
						
						</CFIF>
						
						</font>
						</blockquote>
				</cfif>
				<CFIF url.AlbumID NEQ 0>
					
					
					<CFIF NOT IsDefined("url.PNbr")>
						<CFSET PNbr = 1>
					<CFELSE>
						<CFSET PNbr = url.PNbr>
					</CFIF>
					
					
					<CFQUERY Name="Alb" Datasource="#Application.dsn#">
						SELECT * from Album
							WHERE AlbumID = #url.AlbumID#
							AND GroupID = #GroupID#
					</CFQUERY>
					
					<CFQUERY Name="Photo" Datasource="#Application.dsn#">
						SELECT * from AlbPhotos
							WHERE AlbumID = #url.AlbumID# AND Sequence = #PNbr#
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
								<CFIF Alb.EventID gt 0><a href="ListEvents.cfm?EventID=#Alb.EventID#&GroupID=#GroupID#&GCID=#attributes.GrpContentID#"><font size="-1">View Calendar Event</font></a><br></CFIF>
								<A HREF="photoalbum.cfm">View Photo Albums</A><br>
								</center>
					
								<p align=center>Picture #PNbr# of #Alb.NumPhotos#<br>
								<A HREF="photoalbum.cfm?AlbumID=#AlbumID#&PNbr=#PrevPix#"><IMG SRC="/images/PrevArrow.gif" WIDTH=31 HEIGHT=31 BORDER=0 ALT="Select Previous Photo"></A>&nbsp;&nbsp;&nbsp;
								<A HREF="photoalbum.cfm?AlbumID=#AlbumID#&PNbr=#NextPix#"><IMG SRC="/images/NextArrow.gif" WIDTH=31 HEIGHT=31 BORDER=0 ALT="Select Next Photo"></A></p>
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
				</td>
             </tr>
           </table>
		</td>
		<td width="225" valign="top" align="right">
		   <cf_bsidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#">
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>