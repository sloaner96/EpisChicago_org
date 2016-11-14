<CFQUERY Name="FAQsites" Datasource="#Application.DSN#">
	SELECT * From Lookups
		WHERE CodeGroup = 'FAQSITES'
		ORDER BY CodeValue
</CFQUERY>
<cfquery name="Cats" datasource="#Application.DSN#">
	SELECT * From qFAQ
		ORDER BY CodeValue
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: FAQ Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="FAQ Maintenance Screen">

<blockquote>
<font face="Verdana,Arial">
<font size="-1">
<div align=right><a href="NewFAQ.cfm">Add new FAQ</a></div>
<p>Search the database for Frequently Asked Questions that you may want to modify or delete by searching by keyword/phrase or listing them by their category.</p>
</font>
</blockquote>

<cfform name="KwdFind" action="ListFAQs.cfm" method="POST">

<center>
<table cellspacing=10 cellpadding=1 border=0>
<table border="0" cellspacing="1" cellpadding="3">
<tr valign=top>
	<td align=left>
		<font size="-1"><b>List all FAQs pertaining to:</b></font><br>
		<cfselect name="Section" query="FAQsites" display="CodeDesc" value="CodeValue" size=1>
		<option value="*" selected>--- Select Site ---</option>
		</cfselect><br><br>

		<font size="-1"><b>Search for FAQs containing:</b></font><br>
		<cfinput type="text" name="keywords" value="" size=30 maxlength=40 required="No"><br><br>

		<font size="-1"><b>List all FAQs pertaining to:</b></font><br>
		<cfselect name="category" query="Cats" display="CodeDesc" value="CodeValue" size=1>
		<option value="*" selected>--- ALL ---</option>
		</cfselect><br>

		<br><input type="submit" value="Search FAQs!">
		</cfform>
	</td>
</tr>
</table>
</center>

</font>

</CFMODULE>
</HTML>
