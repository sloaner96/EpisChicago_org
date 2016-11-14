
<CFQUERY Name="Listing" Datasource="#Application.dsn#">
	SELECT * from Album
	  Where GroupID = #url.groupID#
		ORDER By Showable, EventDate DESC, AlbName
</CFQUERY>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Album Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" PageTitle="Site Administration" Section="Admin" SubTitle="Photo Album Maintenance">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
    <td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
	<td valign="top">
		<font face="Verdana,Arial" size="-1">
		
		<blockquote>
		<div align=right><cfoutput><a href="AddAlbum.cfm?GroupID=#Url.GroupID#">Add new Photo Album</a></cfoutput></div>
		
		<CFIF Listing.RecordCount eq 0>
			<h3 align=center>Sorry, no albums have been created</h3>
		<CFELSE>
			<p>Here is a listing of the photo albums currently defined.  Please click on a highlighted Event Name to view the photos for that event.  An asterisk (*) next to the Number of Photos indicates an album that has not yet been made visible on the public site.</p>
			
			<center>
			<table width=500 border=0 cellpadding=2 cellspacing=5>
			<tr bgcolor="#E6E6E6">
				<th align=left>Event Date</th>
				<th align=left>Event Name</th>
				<th># Photos</th>
			</tr>
		
			<CFOUTPUT Query="Listing">
			<tr>
				<td><font size="-1">#DateFormat(EventDate, "mmm d, yyyy")#</font></td>
				<td><a href="UpdAlbum.cfm?AlbumID=#AlbumID#&GroupID=#Url.GroupID#"><font size="-1">#AlbName#</font></a></td>
				<td align=center><font size="-1">#NumPhotos#<cfif Showable is False>*</cfif></font></td>
			</tr>
			</CFOUTPUT>
		
			</table>
			</center>
		
		</CFIF>
		</blockquote>
		
		</FONT>
	</td>
</tr>
</table>
</CFmodule>

</HTML>
