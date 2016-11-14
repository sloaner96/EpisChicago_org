<CFIF NOT IsDefined("URL.VisitID")>
	<CFLOCATION URL="VisitSearch.cfm">
</CFIF>

<CFQUERY Name="GetSched" Datasource="#Application.DSN#">
	SELECT * from Visitations
		WHERE VisitID = #URL.VisitID#
</CFQUERY>
<cfquery name="ParishList" datasource="#Application.DSN#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		ORDER BY ParishName
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Visitation Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Visitation Information">
<font face="Verdana,Arial" size="-1">

<p align=center>Use this form to modify or delete the information displayed below.</p>


<CFLOOP Query="GetSched">
<CFFORM Name="ModVisit" Action="VisitProcess.cfm">
<CFOUTPUT>
<input name="VisitID" type="hidden" value="#URL.VisitID#">
<input name="BishID" type="hidden" value="#BishopID#">
</CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3 bgcolor="#F3F3F3">
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Bishop:</b></font></td>
	<td width* align=left><cfoutput><font face="Verdana,Arial" size="-1">#Application.Bishops[BishopID]#</font></cfoutput></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Visit Date:</b></font></td>
	<td width* align=left><cfinput name="VDate" type="text" value="#DateFormat(VisitDate,'m/d/yyyy')#" size=15 maxlength=15 required="Yes" Message="The Date for this Visit is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish</b></font>:</td>
	<td width=* align=left><cfselect name="Parish" size=1 query="ParishList" selected="#OrgID#" display="PName" value="OrgID" required="no"></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Notes</b></font>:</td>
	<td width=* align=left>
		<cfoutput><textarea name="Notes" cols="40" rows="3" wrap="VIRTUAL">#HTMLEditFormat(Notes)#</textarea></cfoutput>
	</td>
</tr>

<tr>
	<td colspan=2 align=center>
		<br><input type="submit" name="Cmd" value="Delete Visitation" onClick="return confirm('Are you sure you want to delete this?');">
		<input type="Submit" name="Cmd" value="Update Visitation"> 
		<input type="reset" value="Reset Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</CFLOOP>

</font>
</CFMODULE>

</HTML>
