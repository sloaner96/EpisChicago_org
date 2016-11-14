
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Link Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Site Link Maintenance">

<blockquote>
<font face="Verdana,Arial" size="-1">
<p align=center>Search the online database for links that you may want to modify or delete<br>by using the form below.</p>
</font>
</blockquote>


<form action="ListLinks.cfm" method="POST">

<center>
<table border=0 cellspacing=8 cellpadding=1>
<tr>
	<td width=120 align=left><font face="Verdana" size="-1"><b>Keywords:</b></font></td>
	<td width=*><input type="text" name="keywords" value="" size=30 maxlength=40></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" value="Search!">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</center>
</form>

</CFMODULE>

</HTML>
