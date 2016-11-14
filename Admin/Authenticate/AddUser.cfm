<CFIF Session.ULevel neq 1>
	<cflocation url="#CGI.HTTP_REFERER#">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: New User</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Add a New User">
<br>

<font face="Arial" size="-1">
<p>Use this page to create a new user for the Security System.<br>This change will take effect immediately so please make a note of it.</p>
</font>

<cfform name="NewUser" method="Post" action="UserMaint.cfm">


<table width="350" border="0" cellspacing="0" cellpadding="4">
<tr>
	<td colspan=2>&nbsp;</td>
</tr>

<tr valign=top>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Login Name:</b></font></td>
	<td width=200 align=left><cfinput type="text" name="Username" value="" size=15 maxlength=15 required="yes" message="A Login Name must be provided"></td>
</tr>

<tr valign=top>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Full Name:</b></font></td>
	<td width=200 align=left><cfinput type="text" name="FullName" value="" size=30 maxlength=50 required="yes" message="The User's Full Name must be provided"></td>
</tr>

<tr>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Access Level:</b></font></td>
	<td width=200 align=left>
		<select name="UserLevel" size="1">
			<option selected value="1">Site Admin
			<option value="2">Communications Office Staff
			<option value="3">Youth Ministry Staff
			<option value="4">Congregational Development Staff
			<option value="5">Bishop's Office
			<option value="6">Management Team
		</select>
	</td>
</tr>

<tr>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Password:</b></font></td>
	<td width=200 align=left><cfinput type="password" name="Pswd" value="" size=10 maxlength=20 required="yes" message="A Password must be provided"></td>
</tr>

<tr>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Confirm Password:</b></font></td>
	<td width=200 align=left><cfinput type="password" name="ConfirmPswd" value="" size=10 maxlength=20 required="yes" message="You must enter the Password again for confirmation"></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" name="Cmd" value="Add New User">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</cfform>

</CFMODULE>
</HTML>
