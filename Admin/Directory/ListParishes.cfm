<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Parish Listing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Online Directory Listing">

<cfset ErrorList = ArrayNew(1)>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<CFQUERY Name="ParishList" Datasource="#Application.DSN#">
		SELECT * from Directory
			WHERE 1=1
		<CFIF #Form.keywords# is not "">
			AND ((ParishName LIKE '%#Form.keywords#%') OR
				 (City LIKE '%#Form.keywords#%'))
		</CFIF>
		ORDER BY ParishName
	</CFQUERY>

	<cfif #ParishList.RecordCount# is 1>
		<cflocation url="UpdParish.cfm?OrgID=#ParishList.OrgID#" addtoken="No">

	<cfelseif #ParishList.RecordCount# gt 1>

		<br>
		<center>
		<table width=380 border=0 cellpadding=1 cellspacing=5>
		<tr bgcolor="#F3F3F3">
			<th width=250>Parish</th>
			<th width=130>City</th>
		</tr>

		<CFOUTPUT Query="ParishList">
		<tr valign=top>
			<td width=250 align=left><font face="Verdana,Arial" size="-1"><a href="UpdParish.cfm?OrgID=#OrgID#">#ParishName#</a></font></td>
			<td width=130 align=left><font face="Verdana,Arial" size="-1">#City#</font></td>
		</tr>
		</CFOUTPUT>

		</table>
		</center>
		<br>

	<CFELSE>
		<h3 align=center>Sorry, no parishes matched your criteria</h3>
		<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
	</CFIF>

</CFIF>

</CFMODULE>

</HTML>
