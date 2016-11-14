<CFQUERY Name="Listing" Datasource="#Application.DSN#">
	SELECT * from Album
		ORDER By Showable, EventDate DESC, AlbName
</CFQUERY>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Album Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Photo Album Maintenance">
<font face="Verdana,Arial" size="-1">

<blockquote>
<div align=right><a href="AddAlbum.cfm">Add new Photo Album</a></div>

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
		<td><a href="UpdAlbum.cfm?AlbumID=#AlbumID#"><font size="-1">#AlbName#</font></a></td>
		<td align=center><font size="-1">#NumPhotos#<cfif Showable is False>*</cfif></font></td>
	</tr>
	</CFOUTPUT>

	</table>
	</center>

</CFIF>
</blockquote>

</FONT>
</CFmodule>

</HTML>
