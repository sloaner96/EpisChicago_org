<cfquery name="FAQlist" datasource="#Application.DSN#">
	SELECT f.*, c.CodeDesc From FAQs f, qFAQ c
		WHERE c.CodeValue = f.Category
		ORDER BY Category, Ranking, Question
</cfquery>

<html>
<head>
	<title>Chicago Diocese - Frequently Asked Questions</title>
</head>

<cfmodule template="#Application.header#" PageTitle="Finance and Administration" SubTitle="Frequently Asked Questions">

<center>
<table width=580 border=0 cellspacing=0 cellpadding=0>
<tr valign=top>
	<td width=580>
		<font face="Verdana" size="-1">
		<p>This page contains a categorized list of frequently asked questions that might be helpful.  If you have a question not listed below, please feel free to send us an inquiry via our <a href="/Contact.cfm">Contact Us</a> page.</p>
		
		<cfoutput query="FAQlist" group="Category">
		
			<table width=100% border=0>
			<tr bgcolor="##E6E6E6"><td width=100%><font face="Verdana,Arial" color="Navy" size="+1">#CodeDesc#</font></td></tr>
			</table>
			<cfoutput>
			<p><font face="Tahoma,Arial" color="Maroon" size="+1"><i>#Question#</i></font><br>
			#Replace(Response,"#chr(13)##chr(10)#","<br>","ALL")#</p>
			</cfoutput>
		
		</cfoutput>
		
		</font>
	</td>
</tr>
</table>
</center>

</CFMODULE>
</HTML>
