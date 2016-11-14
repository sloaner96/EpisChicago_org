<CFIF NOT IsDefined("URL.ClericalID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<CFQUERY Name="GetJob" Datasource="#Application.DSN#">
	SELECT * from ClergyJobs
		WHERE ClericalID = #URL.CLericalID#
</CFQUERY>

<cfquery name="ParishList" datasource="#Application.DSN#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		ORDER BY ParishName
</cfquery>
<cfquery name="JobTypes" datasource="#Application.DSN#">
	SELECT * From Lookups
		WHERE CodeGroup = 'CJOBTYPES'
		ORDER BY CodeValue
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify Clerical Job Record</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify CLerical Job">

<blockquote>
<font face="Verdana" size="-1">
<p align=center>Use this form to modify or delete the clerical job opening displayed below.</p>
</font>

<CFLOOP Query="GetJob">

<CFFORM Name="UpdJob" Action="CJobProcess.cfm">
<CFOUTPUT><input name="ClericalID" type="hidden" value="#URL.ClericalID#"></CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish</b></font>:</td>
	<td width=* align=left><cfselect name="Parish" size=1 query="ParishList" display="PName" value="OrgID" selected="#OrgID#" required="yes"></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Position Open</b></font>:</td>
	<td width=* align=left><cfselect name="JobOpen" size=1 query="JobTypes" display="CodeDesc" value="CodeValue" selected="#JobType#" required="yes"></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Position Filled</b></font>?</td>
	<td width=* align=left><input name="Filled" type="checkbox" value="1" <cfif Filled is True>checked</cfif> ></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish&nbsp;Receiving</b></font>?</td>
	<td width=* align=left><input name="Receiving" type="checkbox" value="1" <cfif Receiving is True>checked</cfif> ></td>
</tr>

<tr>
	<td colspan=2 align=left>
		<br><font face="Verdana,Arial" size="-1"><b>Job Description</b></font>:<br>
		<cfoutput><textarea name="JobDesc" cols="50" rows="6" wrap="VIRTUAL">#HTMLEditFormat(Description)#</textarea></cfoutput>
	</td>
</tr>

<tr>
	<td colspan=2 align=left><br>
		<input type="submit" name="Cmd" value="Delete Job">
		<input type="Submit" name="Cmd" value="Update Job"> 
		<input type="reset"  name="Cmd" value="Reset Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</CFLOOP>

</blockquote>

</CFMODULE>

</HTML>
