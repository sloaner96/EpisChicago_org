<CFIF Session.ULevel gt 2>
	<cflocation url="#CGI.HTTP_REFERER#">
</CFIF>

<cfquery name="Users" datasource="#Application.DSN#">
	SELECT * From AdminUsers
		WHERE SiteID = #Application.SiteNfo.SiteID#
		ORDER BY UserLevel, UserName
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: LIst all Users</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="List all Users">
<br>

<center>
<table width=450 border=0 cellspacing=0 cellpadding=4>
<tr>
	<th width=100 align=left>Login</th>
	<th width=200 align=left>Full Name</th>
	<th width=150 align=left>Password</th>
</tr>

<cfoutput query="Users">
<tr valign=top>
	<td><font face="Verdana" size="-1">#UserName#</font></td>
	<td><font face="Verdana" size="-1">#FullName#</font></td>
	<td><font face="Verdana" size="-1">#Password#</font></td>
</tr>
</cfoutput>

</table>
</center>

</CFMODULE>

</HTML>
