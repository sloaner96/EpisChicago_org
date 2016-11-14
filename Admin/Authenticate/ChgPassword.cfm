
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: User Password Modification</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Set User Password">
<br>

<font face="Arial" size="-1">
<p>Use this page to modify your current Security System password.<br>This change will take effect immediately so please make a note of it,</p>
</font>

<cfform name="UpdPswd" method="post" action="UpdPassword.cfm">


<table width="350" border="0" cellspacing="0" cellpadding="4">
<tr>
	<td colspan=2>&nbsp;</td>
</tr>

<tr valign=top>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Old Password:</b></font></td>
	<td width=200 align=left><cfinput type="text" name="OldPswd" value="" size=10 maxlength=20 required="yes" message="Your current Password must be provided"></td>
</tr>

<tr>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>New Password:</b></font></td>
	<td width=200 align=left><cfinput type="password" name="NewPswd" value="" size=10 maxlength=20 required="yes" message="Your New Password must be provided"></td>
</tr>

<tr>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>Confirm Password:</b></font></td>
	<td width=200 align=left><cfinput type="password" name="ConfirmPswd" value="" size=10 maxlength=20 required="yes" message="You must enter in your New Password again for confirmation"></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" name="Cmd" value="Change Password">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</cfform>

</CFMODULE>
</HTML>
