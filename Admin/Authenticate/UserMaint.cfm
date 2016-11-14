
<CFIF Left(Form.Cmd, 3) is "Add" AND (NOT IsDefined("Form.Username"))>
	<CFLOCATION URL="#CGI.HTTP_REFERER#">
<CFELSEIF Left(Form.Cmd, 6) is "Delete" AND (NOT IsDefined("Form.UserID"))>
	<CFLOCATION URL="#CGI.HTTP_REFERER#">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: User Security Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="User Maintenance">
<br>

<!--- ****************************************************** --->
<!--- Perform Data Validations on the contents of the Form 	 --->

<CFSET #ErrorsFound#	= FALSE>

<CFIF IsDefined("Form.UserID")>

	<CFIF #Form.UserID# is "*">
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>No value specified for the <b>User Name</b> field</li>
	</CFIF>

<CFELSE>

	<CFIF #Form.Username# is "">
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>No value specified for the <b>Login Name</b> field</li>
	</CFIF>

	<CFQUERY Name="GetUser" Datasource="#Application.DSN#">
		SELECT FullName FROM AdminUsers
			WHERE UserName = '#Form.Username#' AND SiteID = #Application.SiteNfo.SiteID#
	</CFQUERY>

	<CFIF GetUser.RecordCount gt 0>
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>The User Name <cfoutput>'#Form.Username#'</cfoutput> already exists for this Application!
	</CFIF>

	<CFIF #Form.FullName# is "">
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>No value specified for the <b>Full Name</b> field</li>
	</CFIF>

	<CFIF #Form.UserLevel# is "*">
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>No value specified for the <b>Access Level</b> field</li>
	</CFIF>
	
	<CFIF #Form.Pswd# is "">
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>No value specified for the <b>Password</b> field</li>
	</CFIF>
	
	<CFIF #Form.ConfirmPswd# is "">
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>No value specified for the <b>Confirm Password</b> field</li>
	</CFIF>
	
	<CFIF #Form.Pswd# neq #Form.ConfirmPswd#>
		<CFIF NOT #ErrorsFound#>
			<h3 align=center>The following problems were found with your entry</h3>
			<ul type=disc>
			<CFSET #ErrorsFound# = TRUE>
		</CFIF>
		<li>The value for the <b>Password</b> field does not match the <b>Confirm Password</b> field</li>
	</CFIF>
</CFIF>


<!--- ****************************************************** --->
<!--- If no errors keep going, else goto to the ERRORS section --->

<CFIF NOT #ErrorsFound#>

	<!--- ****************************************************** --->
	<!--- Set certain variables to values prior to the ADD --->



	<!--- ****************************************************** --->
	<!--- Add/Update/Delete the Record here 						 --->

	<CFIF Left(Form.Cmd, 3) is "Add">
		<CFQUERY Name="GetUser" Datasource="#Application.DSN#">
			INSERT into AdminUsers
				(UserName,
				 Password,
				 SiteID,
				 FullName,
				 UserLevel
				)
			VALUES
				('#Form.UserName#',
				 '#Form.Pswd#',
				 #Application.SiteNfo.SiteID#,
				 '#Form.FullName#',
				 #Form.UserLevel#
				)
		</CFQUERY>

		<CFQUERY Name="GetUser" Datasource="#Application.DSN#" MAXROWS=1>
			SELECT FullName, UserID FROM AdminUsers
				WHERE SiteID = #Application.SiteNfo.SiteID#
				ORDER BY UserID DESC
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New User" Status="OK" Message="#Session.FullName# created User: '#Form.FullName#'" User="#Session.UserID#">

		<cfoutput>
		<H3 align=center><FONT FACE="Verdana" COLOR="Blue">User: '<font color="Navy">#Form.FullName#</font>' has been Created!</FONT></H3>
		</cfoutput>

	<CFELSEIF Left(Form.Cmd,6) is "Delete">
		<CFQUERY Name="GetUser" Datasource="#Application.DSN#">
			SELECT FullName FROM AdminUsers
				WHERE UserID = #Form.UserID#
		</CFQUERY>

		<CFQUERY Name="DelRec" Datasource="#Application.DSN#">
			DELETE FROM AdminUsers
				WHERE UserID = #Form.UserID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete User" Status="OK" Message="#Session.FullName# deleted User: #GetUser.FullName#" User="#Session.UserID#">

		<cfoutput>
		<H3 align=center><FONT FACE="Verdana" COLOR="Blue">User: '<font color="Navy">#GetUser.FullName#</font>' has been deleted!</FONT></H3>
		</cfoutput>
		<cfif Form.UserID is Session.UserID>
<!--- 			<CFSET StructClear(#session#)> --->
			<CFSET Session.LoggedIn = 0>
			<CFSET Session.UserID   = 0>
			<CFSET Session.FullName = "">
			<cflocation url="/Admin/" addtoken="No">
		</cfif>

	</CFIF>

<!--- ****************************************************** --->
<!--- ERRORS Section: close out the error message display --->

<CFELSE>
	</ul><br>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>
</CFIF>


<!--- ****************************************************** --->
<!--- END OF SCRIPT: Trailing footers and clean-up HTML tags --->


</CFMODULE>
</HTML>
