
<cfquery name="Users" datasource="#Application.DSN#">
	SELECT FullName, UserID From AdminUsers
		WHERE SiteID = #Application.SiteNfo.SiteID#
		ORDER BY FullName
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: View Activity Logs</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="View Activity Log">
<br>

<cfform name="ViewLog" Action="ViewActivity.cfm">
<table width="100%" cellpadding=2 cellspacing=4 border=0>
<tr valign=top>
	<td width=125 align=left>User&nbsp;Name:</td>
	<td width=100%><cfselect name="UserID" size="4" query="Users" value="UserID" display="FullName" multiple="Yes"></cfselect></td>
</tr>
<tr>
	<td width=125 align=left>Entries&nbsp;since:</td>
	<td width=*><cfinput type="text" name="StartDate" size="20" maxlength="20" value="#DateFormat(now(), 'mm/yyyy')#"></td>
</tr>
<tr valign=top>
	<td width=125 align=left>Action:</td>
	<td width=*>
		<font face="Verdana,Arial" size="-2">
		<cfinput type="radio" name="Action" value="*" checked="Yes"> Any Actions<br>
		<cfinput type="radio" name="Action" value="Login"> Logins<br>
		<cfinput type="radio" name="Action" value="Delete User"> Removing User<br>
		<cfinput type="radio" name="Action" value="New User"> Adding new User
		</font>
	</td>
</tr>
<tr valign=top>
	<td width=125 align=left>Status:</td>
	<td width=*>
		<font face="Verdana,Arial" size="-2">
		<cfinput type="radio" name="Status" value="*" checked="Yes"> Any status<br>
		<cfinput type="radio" name="Status" value="OK"> Successful actions<br>
		<cfinput type="radio" name="Status" value="FAILED"> Failed actions<br>
		<cfinput type="radio" name="Status" value="INFO"> Informational Messages
		</font>
	</td>
</tr>
<tr>
	<td width=125 align=left>Sort by:</td>
	<td width=*>
		<font face="Verdana,Arial" size="-2">
		<cfinput type="radio" name="Sortfield" value="DateEntered DESC" checked="Yes"> Date<br>
		<cfinput type="radio" name="Sortfield" value="User, DateEntered DESC"> User
		</font>
	</td>
</tr>
<tr>
	<td colspan=2 align=left><br>
		<input type="Submit" value="View Log"> 
		<input type="reset" value="Clear Form"><br>&nbsp;
	</td>
</tr>
</table>
</cfform>

</CFMODULE>
</HTML>

