<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: News Headlines Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="News Headlines Maintenance">


<blockquote>
<p>Use this form to search the news headlines displayed on the <b>Diocesan News</b> oage in order to modify or delete them.</p>
</blockquote>


<form action="ListArticles.cfm" method="POST">

<center><table border=0 cellspacing=4 cellpadding=1>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Keywords:</b></font></td>
	<td width=*><input type="text" name="keywords" value="" size=40 maxlength=40></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Postings since:</b></font></td>
	<td width=*><input name="DateSubmitted" value="" type="text" size=25 maxlength=25> <font size="-1"><i>(Format: mm/dd/yyyy)</i></font></td>
</tr>

<tr>
	<td colspan=2 align=center>
	<br><input type="submit" value="Search the News!">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</center>
</form>


</CFMODULE>

</HTML>
