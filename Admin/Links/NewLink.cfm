<cfquery name="Cats" datasource="#Application.DSN#">
	SELECT * From qLinkCat
		ORDER BY CodeValue
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: New Web Site Link</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE TEMPLATE="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Add a new Web Site Link">

<blockquote>
<font face="Verdana" size="-1">

<CFFORM Name="AddLink" Action="LinkProcess.cfm">
<input type="hidden" name="LinkID" value="*">

<table width="100%" border=0 cellspacing=1 cellpadding=3>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Web Site</b></font>:</td>
	<td width=* align=left><cfinput name="SiteName" type="text" size=30 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Web URL</b></font>:</td>
	<td width=* align=left><cfinput name="WebURL" type="text" size=40 maxlength=130></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Category</b></font>:</td>
	<td width=* align=left><cfselect name="Category" query="Cats" display="CodeDesc" value="CodeID" size=1><option selected value="*">--- Select Category ---</option></cfselect></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Description</b></font>:</td>
	<td width=* align=left><textarea cols=40 rows=3 name="Description" wrap="virtual"></textarea></td>
</tr>

<tr>
	<td colspan=2 align=left><br>
		<input type="Submit" name="Cmd" value="Save Link"> 
		<input type="reset"  name="Cmd" value="Clear Form">
	</td>
</tr>

</table>

</CFFORM>

</font>
</blockquote>

</CFMODULE>

</HTML>
