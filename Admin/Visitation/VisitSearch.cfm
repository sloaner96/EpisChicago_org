<cfset Session.BishID = "">

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Maintain Visitation Schedule</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Maintain Bishop Visitation Schedule">
<font face="Verdana,Arial" size="-1">

<div align=right><a href="NewVisit.cfm">Add new Visitation</a></div>

<p align=center>Search the Visitation calendar for one of Chicago's Bishops using the form below.</p>

<form action="ListVisits.cfm" method="POST">

<center>
<table border=0 cellspacing=2 cellpadding=1>
<tr>
	<td align=left><font face="Verdana" size="-1"><b>Bishop:</b>&nbsp;&nbsp;</font></td>
	<td>
		<select name="BishID" size=1>
		<option selected value="*">--- Select One --</option>
		<option value="1">Bishop William Persell</option>
		<option value="2">Bishop Victor Scantlebury</option>
		</select>
	</td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" value="List upcoming Visitations">
	</td>
</tr>

</table>
</center>
</form>

</font>
</CFMODULE>

</HTML>
