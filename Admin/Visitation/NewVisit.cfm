
<cfif IsDefined("URL.BishID")>
	<cfset BID = #URL.BishID#>
<cfelseif Session.BishID neq "">
	<cfset BID = #Session.BishID#>
<cfelse>
	<cfset BID = 0>
</cfif>

<cfquery name="ParishList" datasource="#Application.DSN#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		ORDER BY ParishName
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Add Visitation Entry</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Add Visitation">


<CFFORM Name="AddVisit" Action="VisitProcess.cfm">

<center>
<table border=0 cellspacing=1 cellpadding=3 bgcolor="#F3F3F3">
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Bishop:</b></font></td>
	<td width* align=left>
		<cfif BID neq 0>
			<cfoutput>
			<input type="hidden" name="BishID" value="#BID#">
			<font face="Verdana,Arial" size="-1">#Application.Bishops[BID]#</font>
			</cfoutput>
		<cfelse>
			<select name="BishID" size=1>
			<option selected value="*">--- Select One --</option>
			<cfloop index="ID" from="1" to="#ArrayLen(Application.Bishops)#">
			<cfoutput><option value="#ID#" <cfif BID is #ID#>selected</cfif> >#Application.Bishops[ID]#</option></cfoutput>
			</cfloop>
			</select>
		</cfif>
	</td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Visit Date:</b></font></td>
	<td width* align=left><cfinput name="VDate" type="text" size=15 maxlength=15 required="Yes" Message="The Date for this Visit is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish</b></font>:</td>
	<td width=* align=left><cfselect name="Parish" size=1 query="ParishList" display="PName" value="OrgID" required="no"><option selected value="*">--- Select a Parish ---</option></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Notes</b></font>:</td>
	<td width=* align=left>
		<textarea name="Notes" cols="40" rows="3" wrap="VIRTUAL"></textarea>
	</td>
</tr>

<tr valign=top>
	<td colspan=2 align=center><br>
		<input type="Submit" name="Cmd" value="Save Visit"> 
		<input type="reset"  name="Cmd" value="Clear Form">
	</td>
</tr>

</table>
</center>

</CFFORM>

</CFMODULE>

</HTML>
