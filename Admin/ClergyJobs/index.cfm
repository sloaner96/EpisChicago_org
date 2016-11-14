<CFQUERY Name="JobListing" Datasource="#Application.DSN#">
	SELECT c.*, d.ParishName, d.City, l.CodeDesc from ClergyJobs c, Lookups l, Directory d
		WHERE l.CodeGroup = 'CJOBTYPES' AND l.CodeValue = c.JobType
			AND d.OrgID = c.OrgID
		ORDER BY Filled, Receiving, JobType, ParishName
</CFQUERY>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Clergy Jobs Listing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Clergy Jobs Listing">

<blockquote>
<div align=right>
<font face="Verdana,Arial" size="-1"><a href="NewCJob.cfm">Add new Position</a></font>
</div>

<CFIF #JobListing.RecordCount# gt 0>

	<br>
	<center>
	<table width=580 border=0 cellpadding=1 cellspacing=5>
	<tr bgcolor="#F3F3F3">
		<th width=250>Parish</th>
		<th width=200>Opening</th>
		<th width=70>Receiving</th>
		<th width=60>Filled</th>
	</tr>

	<CFOUTPUT Query="JobListing">
	<tr valign=top>
		<td width=250 align=left><font face="Verdana,Arial" size="-1"><a href="UpdCJob.cfm?ClericalID=#ClericalID#">#ParishName#</a><br>#City#</font></td>
		<td width=200 align=left><font face="Verdana,Arial" size="-1">#CodeDesc#</font></td>
		<td width=70 align=center><font face="Verdana,Arial" size="-1">#YesNoFormat(Receiving)#</font></td>
		<td width=60 align=center><font face="Verdana,Arial" size="-1">#YesNoFormat(Filled)#</font></td>
	</tr>
	</CFOUTPUT>

	</table>
	</center>
	<br>

<CFELSE>
	<h3 align=center>Sorry, no clerical jobs have been entered</h3>
</CFIF>
</blockquote>

</CFMODULE>

</HTML>
