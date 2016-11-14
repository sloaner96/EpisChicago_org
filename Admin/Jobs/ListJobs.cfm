<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Jobs Listing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="MarketPlace Job Listings">

<cfset ErrorList = ArrayNew(1)>

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

	<CFQUERY Name="JobListing" Datasource="#Application.DSN#">
		SELECT * from MarketJobs
			WHERE 1=1
		<CFIF #Form.keywords# is not "">
			AND ((Title LIKE '%#Form.keywords#%') OR
				 (Description LIKE '%#Form.keywords#%'))
		</CFIF>
		ORDER BY DateCreated DESC
	</CFQUERY>

	<blockquote>
	<CFIF #JobListing.RecordCount# gt 0>

		<br>
		<center>
		<table width=90% border=0 cellpadding=1 cellspacing=5>
		<tr bgcolor="#F3F3F3">
			<th width=120>Date Entered</th>
			<th width=150>Contact</th>
			<th width=*>Title</th>
		</tr>

		<CFOUTPUT Query="JobListing">
		<tr valign=top>
			<td width=120 align=center><font face="Verdana,Arial" size="-1">#DateFormat(DateCreated, "mm/d/yyyy")#</font></td>
			<td width=150 align=left><font face="Verdana,Arial" size="-1">#Contact#</font></td>
			<td width=* align=left><a href="UpdJob.cfm?MarketID=#MarketID#"><font face="Tahoma,Arial" size="-1">#Title#</font></a></td>
		</tr>
		</CFOUTPUT>

		</table>
		</center>
		<br>

	<CFELSE>
		<h3 align=center>Sorry, no job openings matched your criteria</h3>
		<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
	</CFIF>
	</blockquote>

</CFIF>

</CFMODULE>

</HTML>
