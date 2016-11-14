
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
	<TITLE>#Application.SiteNfo.AppName#: New Clerical Job Entry</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Add Clerical Opening">

<blockquote>
<font face="Verdana" size="-1">
<p align=center>Use this screen to add a new job opening for a clergy position.<br>
This posting will appear on the Clergy Openings page.</p><br>
</font>

<CFFORM Name="AddJob" Action="CJobProcess.cfm">
<input type="hidden" name="ClericalID" value="*">

<center>
<table border=0 cellspacing=1 cellpadding=3>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish</b></font>:</td>
	<td width=* align=left><cfselect name="Parish" size=1 query="ParishList" display="PName" value="OrgID" required="no"><option selected value="*">--- Select a Parish ---</option></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Position Open</b></font>:</td>
	<td width=* align=left><cfselect name="JobOpen" size=1 query="JobTypes" display="CodeDesc" value="CodeValue" required="yes"><option selected value="*">--- Select Position ---</option></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Position Filled</b></font>?</td>
	<td width=* align=left><cfinput name="Filled" type="checkbox" value="1"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish&nbsp;Receiving</b></font>?</td>
	<td width=* align=left><cfinput name="Receiving" type="checkbox" value="1" checked></td>
</tr>

<tr>
	<td colspan=2 align=left>
		<br><font face="Verdana,Arial" size="-1"><b>Job Description</b></font>:<br>
		<textarea name="JobDesc" cols="50" rows="6" wrap="VIRTUAL"></textarea>
	</td>
</tr>

<tr>
	<td colspan=2 align=left><br>
		<input type="Submit" name="Cmd" value="Save Job Opening"> 
		<input type="reset"  name="Cmd" value="Clear Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</blockquote>

</CFMODULE>

</HTML>
