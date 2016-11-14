
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Online Directory Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Online Directory Maintenance">

<blockquote>
<p>Search the online Directory for parishes that you may want to modify or delete by using the form below.</p>
</blockquote>


<form action="ListParishes.cfm" method="POST">

<center>
<table border=0 cellspacing=8 cellpadding=1>
<tr>
	<td width=120 align=left><font face="Verdana" size="-1"><b>Keywords:</b></font></td>
	<td width=*><input type="text" name="keywords" value="" size=40 maxlength=40></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" value="Search the Directory!">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</center>
</form>

</CFMODULE>

</HTML>
