<CFIF Session.ULevel neq 1>
	<cflocation url="#CGI.HTTP_REFERER#">
</CFIF>

<cfquery name="Users" datasource="#Application.DSN#">
	SELECT * From AdminUsers
		WHERE SiteID = #Application.SiteNfo.SiteID#
		ORDER BY UserName
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Delete User</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Delete a User">
<br>

<font face="Arial" size="-1">
<p>Use this page to Remove a user from the Security System.<br>This change will take effect immediately.</p>
</font>

<cfform name="DelUser" method="Post" action="UserMaint.cfm">


<table width="350" border="0" cellspacing="0" cellpadding="4">
<tr>
	<td colspan=2>&nbsp;</td>
</tr>

<tr valign=top>
	<td width=150 align=left><font face="Arial" color="black" size="-1"><b>User Name:</b></font></td>
	<td width=200 align=left><cfselect name="UserID" query="Users" display="UserName" value="userID" SIZE="1" required="yes" message="A User must be selected"><option selected value="*">--- Select One ---</option></cfselect></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" name="Cmd" value="Delete User">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</cfform>

</CFMODULE>
</HTML>
