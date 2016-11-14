<cfif NOT IsDefined("Form.BishID") AND NOT IsDefined("URL.BishID")>
	<cflocation url="VisitSearch.cfm" addtoken="No">
</cfif>

<cfif IsDefined("URL.BishID")>
	<cfset BID = URL.BishID>
<cfelse>
	<cfset BID = Form.BishID>
</cfif>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Visitation Schedule</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Visitation Schedule for #Application.Bishops[BID]#">
<font face="Verdana,Arial" size="-1">

<blockquote>
<div align=right><cfoutput><a href="NewVisit.cfm?BishID=#BID#">Add new Visitation</a></cfoutput></div>

<CFQUERY Name="GetSched" Datasource="#Application.DSN#">
	SELECT * from Visitations v, Directory d
		WHERE BishopID = #BID#
			AND d.OrgID = v.OrgID
			AND VisitDate >= #CreateODBCDate(now())#
		ORDER BY VisitDate
</CFQUERY>

<CFIF #GetSched.RecordCount# gt 0>
	<cfset Session.BishID = #BID#>

	<br>
	<center>
	<table border=0 cellpadding=1 cellspacing=5>
	<tr bgcolor="#F3F3F3">
		<th width=130 align=left>Visitation Date</th>
		<th width=* align=left>Parish/Mission</th>
	</tr>

	<CFOUTPUT Query="GetSched">
	<tr valign=top>
		<td width=130><font face="Verdana,Arial" size="-1">#DateFormat(VisitDate, "mmm d, yyyy")#</font></td>
		<td width=* align=left><a href="UpdVisit.cfm?VisitID=#VisitID#"><font face="Tahoma,Arial" size="-1">#ParishName#</font></a></td>
	</tr>
	</CFOUTPUT>

	</table>
	</center>
	<br>

<CFELSE>
	<h3 align=center>Sorry, no events matched your criteria</h3>
	<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
</CFIF>

</blockquote>
</font>
</CFMODULE>

</HTML>
