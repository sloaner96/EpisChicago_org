
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Log File Transaction Report</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Activity Log Report">
<br>


<CFQUERY Name="Entries" Datasource="#Application.DSN#">
	SELECT * from Logs
		WHERE SiteID = #Application.SiteNfo.SiteID#
	<CFIF IsDate(Form.StartDate)>
		AND DateEntered >= #CreateODBCDate(Form.StartDate)#
	</CFIF>
	<CFIF IsDefined("Form.UserID")>
		<cfif #Form.UserID# is not "">
		AND (
		<cfset UserList = ListToArray(Form.UserID,",")>
		<cfloop index=i FROM="1" TO="#ArrayLen(UserList)#">
			<cfif i gt 1>OR </cfif>User = '#UserList[i]#'
		</cfloop>
			)
		</cfif>
	</CFIF>
	<CFIF #Form.Action# is not "*">
		AND UserAction = '#Form.Action#'
	</CFIF>
	<CFIF #Form.Status# is not "*">
		AND Status = '#Form.Status#'
	</CFIF>
	ORDER BY #Form.Sortfield#
</CFQUERY>

<CFIF #Entries.RecordCount# gt 0>

	<cfoutput><p>Total Log Entries retrieved: #Entries.RecordCount#</p></cfoutput>
	<table width="90%" cellpadding=4 cellspacing=0 border=1>
		<tr bgcolor="#BAE2E2">
			<th>Date</th>
			<th>User</th>
			<th>Action</th>
			<th>Status</th>
			<th>Message</th>
		</tr>
	
		<cfoutput query="Entries">
		<tr valign=top>
			<td align=center><font face="Verdana" size="-1">#DateFormat(DateEntered, "mm/d/yyyy")#<br>#TimeFormat(DateEntered, "hh:mm tt")#</font></td>
			<td align=center><font face="Verdana" size="-1">#UserID#</font></td>
			<td align=center><font face="Verdana" size="-1">#UserAction#</font></td>
			<td align=center><font face="Verdana" size="-1">#Status#</font></td>
			<td><font face="Verdana" size="-1">#Message#</font></td>
		</tr>
		</cfoutput>
	</table>

<CFELSE>

	<p align=center><font face="Verdana,Arial" color="Maroon"><b>Sorry, no log entries matched your selection criteria</b></font></p>

</CFIF>

<br>
</CFMODULE>
</HTML>

