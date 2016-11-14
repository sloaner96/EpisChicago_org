<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Administration Login Page</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Administrative User Login">
<br>

<cfform name="GetUser" method="Post" action="Authenticate/Authorize.cfm">

<center>
<table border="0" cellspacing="0" cellpadding="4" bgcolor="#EEEEEE">
<tr>
	<td colspan=2>&nbsp;</td>
</tr>

<tr valign=top>
	<td width=125 align=right><b><font face="Verdana,Arial" color="Navy">UserName:</font></b></td>
	<td width=* align=left><cfinput type="text" name="UserName" value="" size=15 maxlength=15 required="yes" message="Your UserName must be provided to access this system"></td>
</tr>

<tr>
	<td width=125 align=right><b><font face="Verdana,Arial" color="Navy">Password:</font></b></td>
	<td width=* align=left><cfinput type="password" name="Password" value="" size=10 maxlength=20 required="yes" message="Your Password must be provided to access this system"></td>
</tr>

<tr>
	<td colspan=2 align=center>
	<br><input type="submit" name="Cmd" value="Login!">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table></center>
</cfform>

</CFMODULE>
</HTML>
