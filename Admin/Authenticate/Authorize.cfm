<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Authentication Verification</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="User Confirmation">
<br>

<CFSET #ErrorsFound#	= FALSE>

<CFIF #Form.UserName# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>UserName</b> field</li>
</CFIF>

<CFIF #Form.Password# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>Invalid value specified for the <b>Password</b> field</li>
</CFIF>


<CFIF NOT #ErrorsFound#>

		<cfset ID = Application.SiteNfo.SiteID>
		<cfquery name="GetUser" Datasource="#Application.DSN#">
			SELECT * From AdminUsers
				WHERE SiteID = #ID# AND
					Username = '#Form.UserName#' AND
					Password = '#Form.Password#'
		</cfquery>

		<cfif GetUser.RecordCount eq 0>
			<CF_LogFile SiteID="#ID#" Action="Login" Status="FAILED" Message="#Form.UserName# Authentication failure">
			<br>
			<h2 align=center><font color="Red">Sorry, your Login was denied!</font></h2>
			<p align=center>Click on the button below to try again.</p>
			
			<div align=center><form><input type="Button" name="" value="Login Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
		<cfelse>
			<cfset Session.AdmActive= 1>
			<cfset Session.LoggedIn	= 1>
			<cfset Session.UserID	= #GetUser.UserID#>
			<cfset Session.FullName	= "#GetUser.FullName#">
			<cfset Session.Pswd		= "#GetUser.Password#">
			<cfset Session.Ulevel	= #GetUser.UserLevel#>
			<CF_LogFile SiteID="#ID#" Action="Login" Status="OK" Message="#Session.FullName# logged in" User="#Session.UserID#">

			<cflocation url="/Admin/" addtoken="No">
		</cfif>

<CFELSE>
	</ul><br>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>
</CFIF>


</CFMODULE>
</HTML>
