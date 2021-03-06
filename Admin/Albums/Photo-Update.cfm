
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Photos Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Photo Album Maintenance">
<font face="Verdana,Arial" size="-1">

<CFIF IsDefined("Form.UpdAlbum.RowStatus.Action")>

	<h2 align=center>List of Updated Album Entries</h2>
	
	<CFLOOP INDEX="Rec" FROM="1" TO="#ArrayLen(Form.UpdAlbum.RowStatus.Action)#">

		<CFOUTPUT>
		Record #Rec# -- Seq ## #Form.UpdAlbum.Sequence[Rec]#: #Form.UpdAlbum.FileName[Rec]# (Action: #Form.UpdAlbum.RowStatus.Action[Rec]#)<br>
		</CFOUTPUT>

 		<CFIF Form.UpdAlbum.RowStatus.Action[Rec] eq "U">
			<cfset Caption	= '#Form.UpdAlbum.Caption[Rec]#'>
			<cfset AltText	= '#Form.UpdAlbum.AltText[Rec]#'>
			<CFQUERY Name="UpdPhoto" Datasource="#Application.DSN#">
				UPDATE AlbPhotos
					SET
						Caption	= '#Caption#',
						AltText = '#AltText#',
						Sequence = #Form.UpdAlbum.Sequence[Rec]#
					WHERE
						PhotoID	= #Form.UpdAlbum.Original.PhotoID[Rec]#
			</CFQUERY>
			<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Photo" Status="OK" Message="#Session.FullName# updated photograph '#Caption#' in Album #Form.AlbumID#" User="#Session.UserID#">

 		<CFELSEIF Form.UpdAlbum.RowStatus.Action[Rec] eq "D">
			<CFQUERY Name="Alb" Datasource="#Application.DSN#">
				SELECT a.AlbumID, NumPhotos, PhotoPath, FileName from Album a, AlbPhotos p
					WHERE a.AlbumID = #Form.AlbumID#
						AND (p.AlbumID = a.AlbumID AND p.PhotoID = #Form.UpdAlbum.Original.PhotoID[Rec]#)
			</CFQUERY>

			<CFSET Location = "#Application.DirPath##Alb.PhotoPath#\#Alb.FileName#">
			<cfif FileExists("#Location#") is "YES">
				<cffile action="DELETE" file="#Location#">
			</cfif>
			<CFQUERY Name="DelPhoto" Datasource="#Application.DSN#">
				DELETE from AlbPhotos
					WHERE
						PhotoID	= #Form.UpdAlbum.Original.PhotoID[Rec]#
			</CFQUERY>

			<CFSET NewValue = #Alb.NumPhotos# - 1>
			<CFQUERY Name="UpdAlb" Datasource="#Application.DSN#">
				UPDATE Album
					SET
						NumPhotos = #NewValue#
					WHERE AlbumID = #Form.AlbumID#
			</CFQUERY>
			<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Photo" Status="OK" Message="#Session.FullName# deleted photograph '#Form.UpdAlbum.Original.Caption[Rec]#' in Album #Form.AlbumID#" User="#Session.UserID#">
		</CFIF>

	</CFLOOP>

</CFIF>

<br>
<CFOUTPUT>
<div align=center><form action="AlbPopulate.cfm?AlbumID=#Form.AlbumID#" method="GET"><input type="hidden" name="AlbumID" value="#Form.AlbumID#"><input type="Submit" value="Return to Album Maintenance"></form></div>
</CFOUTPUT>

</font>

</CFMODULE>

</HTML>
