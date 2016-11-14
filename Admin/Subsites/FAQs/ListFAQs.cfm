
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: FAQ Search Results</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin"  PageTitle="FAQ Search Results">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
<td valign="top">
<font face="Verdana,Arial" size="-1">

<cfset ErrorList = ArrayNew(1)>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>
	<CFQUERY Name="GetFAQ" Datasource="#Application.DSN#">
		SELECT * from FAQs f, qFAQ l
			WHERE l.CodeValue = f.Category
				<cfif Len(Trim(form.keywords)) GT 0>
				AND ((f.Question LIKE '%#Form.keywords#%') OR
					 (f.Response LIKE '%#Form.keywords#%'))
				</cfif>
				<cfif Form.Category neq "*">
				AND f.Category = '#Form.Category#'
				</cfif>
				AND GroupID = #form.GroupID#
				ORDER BY Ranking, Question
	</CFQUERY>

	<CFIF GetFAQ.RecordCount gt 0>

		<blockquote>	
		<div align=right><cfoutput><a href="NewFAQ.cfm?GroupID=#Form.GroupID#">Add new FAQ</a></cfoutput></div>
		<p><cfoutput>Total Found: <b>#GetFAQ.RecordCount#</b></p></cfoutput>

		<CFOUTPUT Query="GetFAQ">
		<p><b>#Question#</b>&nbsp;&nbsp;[<a href="UpdFAQ.cfm?ID=#FaqID#&GroupID=#Form.GroupID#">EDIT</a>]<br>
		#SpanExcluding(Response, '#chr(13)#')#</p>
		</CFOUTPUT>
		</blockquote>

	<CFELSE>
		<h3 align=center>Sorry, no FAQs matched your criteria</h3>
		<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
	</CFIF>

</CFIF>
</font>
</td>
</tr>
</table>
</CFMODULE>
</HTML>
