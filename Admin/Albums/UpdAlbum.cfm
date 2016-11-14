<CFQUERY Name="Alb" Datasource="#Application.DSN#">
	SELECT * from Album
		WHERE AlbumID = #URL.AlbumID#
</CFQUERY>

<CFSET CurDate	=	#DateAdd('m', -2, now())#>
<CFQUERY NAME="Events" DATASOURCE="#Application.DSN#">
	SELECT EventID, Left(Str(Month(BeginDate))+'/'+Str(Day(BeginDate))+'/'+Str(Year(BeginDate))+': '+EventName,50) as EventNfo from Events
		WHERE Approved = True
			AND (BeginDate >= #CurDate#	AND EndDate <= #now()#)
			<cfif Alb.EventID neq "" AND Alb.EventID gt 0>
			OR EventID = #Alb.EventID#
			</cfif>
		ORDER BY BeginDate DESC
</CFQUERY>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Photo Album Update</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Photo Album">
<font face="Verdana,Arial" size="-1">

<blockquote>

<CFOUTPUT Query="Alb">
<center>
<table width=90% border=0>
<tr valign=top>
	<td width=50% align=left><a href="index.cfm"><font face="Tahoma" color="Blue" size="-1">Return to List of Albums</font></a></td>
	<td width=50% align=right><a href="AlbPopulate.cfm?AlbumID=#AlbumID#"><font face="Tahoma" color="Blue" size="-1">Add/Update Photos in Album</font></a></td>
</tr>
</table>
</center>
</CFOUTPUT>

<center>

<CFLOOP Query="Alb">
<cfform name="ModAlbum" Action="Album-Update.cfm">
<CFOUTPUT><input type="hidden" name="AlbumID" value="#AlbumID#"></CFOUTPUT>

<table width=550 cellpadding=2 cellspacing=2 border=0>
<tr valign=top>
	<td width=125><font size="-1"><b>Album Name:</b></font></td>
	<td width=425 align=left><cfinput name="AlbName" type="text" value="#AlbName#" size=45 maxlength=70 required="Yes" Message="A Name for this album is required"></td>
</tr>

<tr valign=top>
	<td width=125><font size="-1"><b>Event Date:</b></font></td>
	<td width=425 align=left><cfinput name="EventDate" type="text" value="#DateFormat(EventDate, 'm/d/yyyy')#" size=15 maxlength=15 required="Yes" Message="A Date for this Event is required"> <font size="-1"><i>(Format: mm/dd/yyyy)</i></font></td>
</tr>

<tr valign=top>
	<td width=125><font size="-1"><b>Make Public?</b></font></td>
	<td width=425 align=left><input name="MakePublic" type="checkbox" <cfif #Showable#>Checked</cfif> ></td>
</tr>

<tr valign=top>
	<td width=125><font size="-1"><b>Description:</b></font></td>
	<td width=425 align=left><cfoutput><textarea name="EventDesc" cols="40" rows="8" wrap="VIRTUAL">#EventDesc#</textarea></cfoutput></td>
</tr>

<tr valign=bottom>
	<td width=125><br><font size="-1"><b>Related Event: </b></font></td>
	<td width=425 align=left>
		<CFIF #EventID# is "" OR EventID is 0>
			<cfselect name="EventID" size=1 query="Events" Value="EventID" display="EventNfo"><option selected value="*">--- Select an associated Event ---</option></cfselect>
		<CFELSE>
			<cfselect name="EventID" size=1 query="Events" selected="#EventID#" Value="EventID" display="EventNfo"><option value="*">--- No Event ---</option></cfselect>
		</CFIF>
	</td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="Submit" value="Update Album"> 
		<input type="reset" value="Reset Form"><br>&nbsp;
	</td>
</tr>

</table>
</cfform>
</cfloop>

</center>
</font>

</CFMODULE>

</HTML>
