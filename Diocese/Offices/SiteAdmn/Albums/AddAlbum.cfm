<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>
<CFSET CurDate	=	#DateAdd('m', -2, now())#>
<CFQUERY NAME="Events" DATASOURCE="#Application.dsn#">
	SELECT EventID, Left(Str(Month(BeginDate))+'/'+Str(Day(BeginDate))+'/'+Str(Year(BeginDate))+': '+EventName,50) as EventNfo from Events
		WHERE Approved = True
			AND BeginDate >= #CurDate#
			AND EndDate <= #now()#
			AND OwningGroupID = #Url.groupID#
		ORDER BY BeginDate DESC
</CFQUERY>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Create new Photo Album</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  PageTitle="Site Administration" SubTitle="Create new Photo Album">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
<td>
<font face="Verdana,Arial" size="-1">

<blockquote>
<p align=center>Use this screen to add a new albums to the database.</p>
</blockquote>

<center>

<cfform name="NewAlbum" Action="Album-Add.cfm">
<cfoutput><input type="hidden" name="groupID" value="#URL.GroupID#"></cfoutput>
<table width=550 cellpadding=2 cellspacing=2 border=0>
<tr valign=top>
	<td width=125 align=left><font size="-1"><b>Album Name</b>:</font></td>
	<td width=425 align=left><cfinput name="AlbName" type="text" size=45 maxlength=70 required="Yes" Message="A Name for this album is required"></td>
</tr>

<tr valign=top>
	<td width=125 align=left><font size="-1"><b>Event Date</b>:</font></td>
	<td width=425 align=left><cfinput name="EventDate" type="text" size=15 maxlength=15 required="Yes" Message="A Date for this Event is required"> <font size="-1"><i>(Format: mm/dd/yyyy)</i></font></td>
</tr>

<tr valign=top>
	<td width=125 align=left><font size="-1"><b>Image Folder</b>:</font></td>
	<td width=425 align=left><cfinput name="PhotoPath" type="text" size=15 maxlength=15 required="Yes" Message="A Directory for the images is required"></td>
</tr>

<tr valign=top>
	<td width=125 align=left><font size="-1"><b>Description</b>:</font></td>
	<td width=425 align=left><textarea name="EventDesc" cols="40" rows="8" wrap="VIRTUAL"></textarea></td>
</tr>

<tr valign=bottom>
	<td width=125 align=left><br><font size="-1"><b>Related Event</b>:</font></td>
	<td width=425 align=left><cfselect name="EventID" size=1 query="Events" Value="EventID" display="EventNfo"><option selected value="*">--- Select an associated Event ---</option></cfselect></td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="Submit" value="Save Album"> 
		<input type="reset" value="Clear Form"><br>&nbsp;
	</td>
</tr>

</table>
</cfform>

</center>
</font>
</td>
</tr>
</table>
</CFMODULE>

</HTML>
