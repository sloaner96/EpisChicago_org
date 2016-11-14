<cfquery name="Cats" datasource="#Application.DSN#">
	SELECT CodeGroup, count(CodeGroup) as NRecs From Lookups
	GROUP BY CodeGroup
	ORDER BY CodeGroup	
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Category Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Category Maintenance">

<blockquote>
<p>Search the online database for links that you may want to modify or delete by using the form below.</p>

<form action="ListCodes.cfm" method="GET">
<table border="1" cellspacing="0" cellpadding="3" align="right" bordercolor="Black" bgcolor="#F3F3F3">
<tr valign=center>
	<td align=center>
	<font face="Verdana" size="-1"><b>New Category:</b></font><br>
	<input type="text" name="CG" value="" size=15 maxlength=15><br>
	<input type="submit" value="Add it">
	</td>
</tr>
</table>
</form>

<cfif Cats.RecordCount gt 0>
	<font face="Tahoma,Arial" size="+1" color="Navy">Category Types<hr size=1 align=left width=60%></font><br>

	<font face="Verdana" size="-1">
	<table width=250 border=0 cellspacing=3>
	<cfoutput query="Cats">
	<tr>
		<td width=150 align=left><a href="ListCodes.cfm?CG=#CodeGroup#">#UCase(CodeGroup)#</a></td>
		<td width=100 align=center>#NRecs#</td>
	</tr>
	</cfoutput>
	</table>
	</font>

<cfelse>
	<font face="Tahoma,Arial" size="+1" color="Navy">No Categories currently defined</fpnt><br>

</cfif>

</blockquote>

</CFMODULE>

</HTML>
