
<cfquery name="ParishList" datasource="#Application.DSN#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		ORDER BY ParishName
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: New Marketplace Job Entry</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Add MarketPlace Opening">

<blockquote>
<font face="Verdana" size="-1">
<p>Use this screen to add a new job opening for a non-clergy position.  This posting will appear on the MarketPlace page.</p>
</font>

<CFFORM Name="AddJob" Action="JobProcess.cfm">
<input type="hidden" name="MarketID" value="*">

<table width="100%" border=0 cellspacing=1 cellpadding=3>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Title</b></font>:</td>
	<td width=* align=left><cfinput name="Title" type="text" size=40 maxlength=80 required="Yes" Message="The Title for this position is required"></td>
</tr>

<cfif ParishList.RecordCount eq 0>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Location</b></font>:</td>
	<td width=* align=left><cfinput name="Location" type="text" size=40 maxlength=80 required="Yes" Message="Please enter the parish for this opening"></td>
</tr>
<cfelse>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish</b></font>:</td>
	<td width=* align=left><cfselect name="Parish" size=1 query="ParishList" display="PName" value="OrgID" required="no"><option selected value="*">--- Select a Parish ---</option></cfselect></td>
</tr>
</cfif>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact</b></font>:</td>
	<td width=* align=left><cfinput name="Contact" type="text" size=30 maxlength=40 required="Yes" Message="A Contact person for this position is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Phone</b></font>:</td>
	<td width=* align=left><cfinput name="Phone" type="text" size=20 maxlength=20></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>EMail Address</b></font>:</td>
	<td width=* align=left><cfinput name="EMail" type="text" size=30 maxlength=130></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Expires on</b></font>:</td>
	<td width=* align=left><cfinput name="DateExpires" type="text" size=20 maxlength=20 validate="date"></td>
</tr>

<tr>
	<td colspan=2 align=left>
		<br><font face="Verdana,Arial" size="-1"><b>Description</b></font>:<br>
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

</CFFORM>
</blockquote>

</CFMODULE>

</HTML>
