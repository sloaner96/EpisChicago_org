
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: MarketPlace Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="MarketPlace Maintenance">

<blockquote>
<div align=right><font face="Tahoma,Arial"><a href="NewJob.cfm">Add Job Opening</a></font></div>
<font face="Verdana" size="-1">
<p>Use this screen to search for existing job posting that have been entered and displayed on the MarketPlace page at one time or another.  Entries that are retrieved from this search may be older posting that are no longer visible on the MarketPlace page.</p>
</font>

<form action="ListJobs.cfm" method="POST">

<center>
<table border=0 cellspacing=8 cellpadding=1>
<tr>
	<td width=120 align=left><font face="Verdana" size="-1"><b>Keywords:</b></font></td>
	<td width=*><input type="text" name="keywords" value="" size=40 maxlength=40></td>
</tr>

<tr>
	<td colspan=2 align=left>
	<br><input type="submit" value="Search for Jobs!">
	<input type="reset"  value="Clear Form">
	</td>
</tr>

</table>
</center>
</form>

</CFMODULE>

</HTML>
