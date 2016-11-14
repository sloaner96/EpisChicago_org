<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: News Headlines Listing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="News Headlines Listing">


<cfset ErrorList = ArrayNew(1)>

<CFIF #Form.DateSubmitted# is not "" AND NOT IsDate(Form.DateSubmitted)>
	<cfset x = ArrayAppend(ErrorList, "An invalid date has been specified.  Please enter dates in the format mm/dd/yyyy")>
</CFIF>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<CFQUERY Name="GetArticles" Datasource="#Application.DSN#">
		SELECT * from Articles
			WHERE 1=1
		<CFIF #Form.keywords# is not "">
			AND ((ArticleText LIKE '%#Form.keywords#%') OR
				 (Headline LIKE '%#Form.keywords#%') OR
				 (SubHeading LIKE '%#Form.keywords#%'))
		</CFIF>
		<CFIF #IsDate(Form.DateSubmitted)#>
			AND DateSubmitted >= #CreateODBCDateTime(Form.DateSubmitted)#
		</CFIF>
		ORDER BY DateSubmitted DESC
	</CFQUERY>

	<CFIF #GetArticles.RecordCount# gt 0>
	
		<br>
		<center>
		<table width=100% border=0 cellpadding=1 cellspacing=5>
		<tr bgcolor="#F3F3F3">
			<th width=130>Posting Date</th>
			<th width=*>Article Headline</th>
		</tr>

		<CFOUTPUT Query="GetArticles">
		<tr valign=top>
			<td width=130 align=center><font face="Verdana,Arial" size="-1">#DateFormat(DateSubmitted, "mmm d, yyyy")#</font></td>
			<td width=* align=left><a href="UpdArticle.cfm?ArticleID=#ArticleID#"><font face="Tahoma,Arial" size="-1">#Headline#</font></a></td>
		</tr>
		</CFOUTPUT>

		</table>
		</center>
		<br>

	<CFELSE>
		<h3 align=center>Sorry, no news items matched your criteria</h3>
		<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
	</CFIF>

</CFIF>

</CFMODULE>

</HTML>
