<CF_NoCache>

<CFIF NOT IsDefined("URL.EventID")>
	<CFLOCATION URL="/Calendar.cfm">
</CFIF>


<CFQUERY Name="Viewer" Datasource="#Application.DSN#">
	SELECT e.*, (select CodeDesc From Lookups l Where l.CodeValue = e.Category AND l.CodeGroup = 'EVENT') as CategoryName From Events e
		WHERE e.EventID = #URL.EventID# AND e.Approved = True
</CFQUERY>

<CFIF #Viewer.RecordCount# eq 0>
	<CFLOCATION URL="/Calendar.cfm">
</CFIF>


<HTML>
<HEAD>
	<CFOUTPUT Query="Viewer">
	<TITLE>Chicago Diocese -- #EventName#</TITLE>
	</CFOUTPUT>
</HEAD>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Event Calendar"
	subtitle="#Viewer.EventName#">

<blockquote>
<font face="Verdana" size="-1">

<CFOUTPUT Query="Viewer">
<cfif CategoryName is not "">
<div align=right><i>Category</i>: <font color="Navy"><b>#CategoryName#</b></font></div>
</cfif>

<table border=0 cellpadding=0>
<tr valing=top>
	<td><font size="-1" color=black><b>Event Date</b>:</font></td>
	<td><font size="-1" color=black>#DateFormat(BeginDate, "mmm d, yyyy")# <cfif DatePart("h", BeginDate) gt 0>#TimeFormat(BeginDate, "h:mm tt")#</cfif> <cfif EndDate is not ""> -  #DateFormat(EndDate, "mmm d, yyyy")# <cfif DatePart("h", EndDate) neq 23 AND DatePart("n", EndDate) neq 59>#TimeFormat(EndDate, "h:mm tt")#</cfif></cfif></font></td>
</tr>
<cfif Location is not "">
<tr valign=top>
	<td><font size="-1" color=black><b>Location</b>:</font></td>
	<td><font size="-1" color=black>#Location#</font></td>
</tr>
</cfif>
<cfif Contact is not "">
<tr valign=top>
	<td><font size="-1" color=black><b>Contact</b>:</font></td>
	<td><font size="-1" color=black><cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif></font></td>
</tr>
</cfif>
<cfif URL is not "">
<tr valign=top>
	<td><font size="-1" color=black><b>Web site</b>:</font></td>
	<td><font size="-1" color=black>Visit <a href="#URL#">#URL#</a> for more information</font></td>
</tr>
</cfif>
</table>

<br><br>
#ParagraphFormat(Description)#

</CFOUTPUT>

</font>
</blockquote>

</CFMODULE>

</HTML>
