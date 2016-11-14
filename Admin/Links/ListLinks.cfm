<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Links Listing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Site Links Listing">


<cfset ErrorList = ArrayNew(1)>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Maroon">#NErrors# problem(s) encountered with your Inquiry</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<CFQUERY Name="GetLinks" Datasource="#Application.DSN#">
		SELECT * from SiteLinks
			WHERE 1=1
		<CFIF #Form.keywords# is not "">
			AND ((SiteName LIKE '%#Form.keywords#%') OR
				 (SiteURL LIKE '%#Form.keywords#%') OR
				 (Description LIKE '%#Form.keywords#%'))
		</CFIF>
		ORDER BY SIteName
	</CFQUERY>

	<CFIF #GetLinks.RecordCount# gt 0>

		<div align=right><a href="NewLink.cfm">Add New HyperLink</a></div>
		
		<center>
		<table width=600 border=0 cellpadding=2 cellspacing=2>
		<tr>
			<td><cfoutput><p><font face="Verdana,Arial">Total Links retrieved: <b>#GetLinks.RecordCount#</b></font></p></cfoutput></td>
		</tr>

		<CFOUTPUT Query="GetLinks">
		<cfset Color = IIF((CurrentRow MOD 2) is 0, DE("White"),DE("F3F3F3"))>
		<tr valign=top bgcolor="#Color#">
			<td align=left><font face="Verdana,Arial" size="-1"><a href="UpdLink.cfm?LinkID=#LinkID#">#SiteName#</a><br>#SiteURL#</font></td>
		</tr>
		</CFOUTPUT>

		</table>
		</center>
		<br>

	<CFELSE>
		<h3 align=center>Sorry, no links matched your criteria</h3>
		<p align=center>Click <a href="NewLink.cfm">here</a> to add a new HyperLink to the Links page</p>
		<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
	</CFIF>

</CFIF>

</CFMODULE>

</HTML>
