
<CFIF NOT IsDefined("Form.OldPswd")>
	<CFLOCATION URL="#CGI.HTTP_REFERER#">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify User Password</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="User Password Update">
<br>


<!--- ****************************************************** --->
<!--- Perform Data Validations on the contents of the Form 	 --->

<CFSET #ErrorsFound#	= FALSE>

<CFIF #Form.OldPswd# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>Old Password</b> field</li>
</CFIF>

<CFIF #Form.OldPswd# neq #Session.Pswd#>
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>The value for the <b>Old Password</b> field does not match the current setting</li>
</CFIF>

<CFIF #Form.NewPswd# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>New Password</b> field</li>
</CFIF>

<CFIF #Form.ConfirmPswd# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>Invalid value specified for the <b>Confirm Password</b> field</li>
</CFIF>

<CFIF #Form.NewPswd# neq #Form.ConfirmPswd#>
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>The value for the <b>New Password</b> field does not match the <b>Confirm Password</b> field</li>
</CFIF>


<!--- ****************************************************** --->
<!--- If no errors keep going, else goto to the ERRORS section --->

<CFIF NOT #ErrorsFound#>

	<!--- ****************************************************** --->
	<!--- Set certain variables to values prior to the ADD --->



	<!--- ****************************************************** --->
	<!--- Add/Update/Delete the Record here 						 --->

		<CFQUERY Name="UpdRec" Datasource="SecureDB">
			UPDATE Users
			SET
				Password = '#Form.NewPswd#'
			WHERE UserID = #Session.UserID#
		</CFQUERY>
		<cfset Session.Pswd = '#Form.NewPswd#'>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="SetPassword" Status="OK" Message="#Session.FullName# changed password to '#Session.Pswd#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Arial Black" COLOR="Blue">Your new password has been recorded!</FONT></H3>


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
