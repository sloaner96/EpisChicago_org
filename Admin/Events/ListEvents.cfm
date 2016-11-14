<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Listing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Event Listing">


<cfset ErrorList = ArrayNew(1)>

<CFIF #Form.EventDate# is not "" AND NOT IsDate(Form.EventDate)>
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

	<CFQUERY Name="GetEvents" Datasource="#Application.DSN#">
		SELECT e.* from Events e
			WHERE Approved = True
		<CFIF #Form.keywords# is not "">
			AND ((Description LIKE '%#Form.keywords#%') OR
				 (EventName LIKE '%#Form.keywords#%') OR
				 (Contact LIKE '%#Form.keywords#%'))
		</CFIF>
		<CFIF #IsDate(Form.EventDate)#>
			AND BeginDate >= #CreateODBCDateTime(Form.EventDate)#
		</CFIF>
			AND e.EndDate >= #CreateODBCDateTime(now())#
		ORDER BY BeginDate, EndDate
	</CFQUERY>

	<CFIF #GetEvents.RecordCount# gt 0>
	
		<br>
		<center>
		<table border=0 cellpadding=1 cellspacing=5>
		<tr bgcolor="#F3F3F3">
			<th width=110>Event Date</th>
			<!--- <th width=150>Section</th> --->
			<th width=*>Event Name</th>
		</tr>

		<CFOUTPUT Query="GetEvents">
		<tr valign=top>
			<td width=110 align=center><font face="Verdana,Arial" size="-1">#DateFormat(BeginDate, "mmm d, yyyy")#</font></td>
			<!--- <td width=150 align=center><font face="Verdana,Arial" size="-1">#CodeDesc#</font></td> --->
			<td width=* align=left><a href="UpdEvent.cfm?EventID=#EventID#"><font face="Tahoma,Arial" size="-1">#EventName#</font></a></td>
		</tr>
		</CFOUTPUT>

		</table>
		</center>
		<br>

	<CFELSE>
		<h3 align=center>Sorry, no events matched your criteria</h3>
		<div align=center><form><input type="Button" name="" value="Search Again" align="ABSMIDDLE" onclick="history.back()"></form></div>
	</CFIF>

</CFIF>

</CFMODULE>

</HTML>
