<CFIF NOT IsDefined("Form.AlbName")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Create Album</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Create Photo Album">


<CFSET #ErrorsFound#	= FALSE>

<CFIF #Form.AlbName# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>Album Name</b> field</li>
</CFIF>

<CFIF #Form.PhotoPath# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>Photo Path</b> field</li>
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

	<CFQUERY Name="AddInfo" Datasource="#Application.DSN#">
		INSERT into Album
			(AlbName,
			 EventDate,
			 EventDesc,
			 PhotoPath,
			 Color,
			 <CFIF #Form.EventID# is not "*">
			 	EventID,
			 </CFIF>
			 NumPhotos
			)
		VALUES
			('#Form.AlbName#',
			 #DateOfEvent#,
			 '#Form.EventDesc#',
			 '/Albums/#Form.PhotoPath#',
			 'white',
			 <CFIF #Form.EventID# is not "*">
			 	#Form.EventID#,
			 </CFIF>
			 0
			)
	</CFQUERY>

	<CFIF NOT DirectoryExists("#Application.DirPath#\Albums\#Form.PhotoPath#")>
		<CFDIRECTORY Directory="#Application.DirPath#\Albums\#Form.PhotoPath#" Action="Create">
	</CFIF>

	<CFQUERY Name="Alb" Datasource="#Application.DSN#">
		SELECT AlbumID from Album
			WHERE AlbName = '#Form.AlbName#' AND EventDate = #DateOfEvent#
	</CFQUERY>
	<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Album" Status="OK" Message="#Session.FullName# created photo album #Alb.AlbumID#" User="#Session.UserID#">

	<CFLOCATION URL="AlbPopulate.cfm?AlbumID=#Alb.AlbumID#&AutoScan=Yes">

<CFELSE>
	</ul><br>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>
</CFIF>


</CFMODULE>
</HTML>
