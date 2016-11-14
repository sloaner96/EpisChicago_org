<CFIF NOT IsDefined("Form.AlbumID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Album Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Photo Album Maintenance">
<font face="Verdana,Arial" size="-1">

<CFSET #ErrorsFound#	= FALSE>

<CFIF #Form.AlbName# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>Album Name</b> field</li>
</CFIF>

<CFIF #Form.EventDate# is not "" and NOT #IsDate(Form.EventDate)#>
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>Invalid value specified for the <b>Event Date</b> field</li>
</CFIF>

<CFIF #Form.EventDesc# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No information specified for the <b>Event Description</b> field</li>
</CFIF>

<CFIF NOT #ErrorsFound#>

	<CFSET DateOfEvent	=	#CreateODBCDateTime(Form.EventDate)#>

	<CFQUERY Name="UpdInfo" Datasource="#Application.DSN#">
		UPDATE Album
			SET
				AlbName		= '#Form.AlbName#',
				EventDate	= #DateOfEvent#,
				<CFIF #Form.EventID# is not "*">
			 		EventID	= #Form.EventID#,
				<CFELSE>
			 		EventID	= NULL,
				</CFIF>
				<CFIF IsDefined("Form.MakePublic")>
					Showable = TRUE,
				</CFIF>
				EventDesc	= '#Form.EventDesc#'
			WHERE AlbumID = #Form.AlbumID#
	</CFQUERY>
	<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Album" Status="OK" Message="#Session.FullName# updated photo album #Form.AlbumID#" User="#Session.UserID#">

	<CFLOCATION URL="AlbPopulate.cfm?AlbumID=#Form.AlbumID#">

<CFELSE>
	</ul><br>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>
</CFIF>

</font>
</CFMODULE>

</HTML>
