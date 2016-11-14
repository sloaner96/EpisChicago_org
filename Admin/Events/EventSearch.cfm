
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Event Search Screen">

<blockquote>
<p>Search the Events calendar for a list of events that you may want to modify or delete by using the form below.</p>
</blockquote>


<form action="ListEvents.cfm" method="POST">

<center>
<table border=0 cellspacing=8 cellpadding=1>
<tr>
	<td width=120 align=left><font face="Verdana" size="-1"><b>Keywords:</b></font></td>
	<td width=*><input type="text" name="keywords" value="" size=40 maxlength=40></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana" size="-1"><b>Events since:</b></font></td>
	<td width=*><input name="EventDate" value="" type="text" size=25 maxlength=25> <font size="-1"><i>(Format: mm/dd/yyyy)</i></font></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" value="Search the Events">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</center>
</form>

</CFMODULE>

</HTML>
