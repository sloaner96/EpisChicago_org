<cfparam name="Attributes.keyword" default="">
<cfparam name="Attributes.GroupID" default="0">
<cfparam name="Attributes.GrpContentID" default="0">

<cfquery name="Months" datasource="#Application.DSN#">
	SELECT CodeValue, CodeDesc FROM Lookups
		WHERE CodeGroup = 'MONTH'
		ORDER BY CodeValue
</cfquery>


<cfset EndPeriod = DateAdd("m", 10, now())>
<cfquery name="GetCal" datasource="#Application.DSN#" DEBUG>
	SELECT * From Events
		WHERE Approved = True AND OwningGroupID = #Attributes.GroupID# 
			AND EndDate >= #CreateODBCDateTime(now())#
			<cfif QUERY_STRING is "" AND NOT IsDefined("Form.FieldNames")>
			AND EndDate <= #EndPeriod#
			</cfif>
			<cfif IsDefined("URL.M")>
			AND Month(BeginDate) = #URL.M#
			</cfif>
			<cfif IsDefined("URL.D")>
			AND Day(BeginDate) = #URL.D#
			</cfif>
			<cfif IsDefined("URL.Y")>
			AND Year(BeginDate) = #URL.Y#
			</cfif>
			<cfif Attributes.Keyword NEQ "">
			AND (EventName LIKE '%#Attributes.Keyword#%' OR Description LIKE '%#Attributes.Keyword#%')
			</cfif>
		ORDER BY GrpHighlight, BeginDate
</cfquery>



<cfset Today = now()>
<cfset NextThirty = DateAdd('m', 6, today)>
<CFQUERY Name="Viewer" Datasource="#Application.dsn#">
	SELECT e.*,
	  (select CodeDesc 
	    From Lookups l 
		Where l.CodeValue = e.Category 
		AND l.CodeGroup = 'EVENT') as CategoryName 
	FROM Events e
	WHERE e.OwningGroupID = #Attributes.GroupID# 
	AND e.Approved = True
	AND e.BeginDate >= #CreateODBCDate(Today)# 
	AND e.BeginDate <= #CreateodbcDate(NextThirty)#
    Order By e.GrpHighlight, e.BeginDate
</CFQUERY>
<blockquote>
<cfif Viewer.recordcount GT 0>


<table width="100%" border=0 cellpadding=3 cellspacing=2>
<cfif attributes.keywords NEQ ""><tr><td colspan=2 align="center"><cfoutput><font face="Verdana" size="-1"><strong>Search Results for Keywords:</strong> #Attributes.keywords#</font></td></tr></cfoutput></cfif>
<tr valign="top">
	<td width="160" bgcolor="#f3f3f3">
		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="verdana" color="ffffff" size="-1"><b><cfoutput>#MonthAsString(month(now()))#</cfoutput></b></font></td>
		</tr>
		</table>
		<CFmodule template="#Application.CTMapping#/WebCal.cfm" EventCFM="ListEvents.cfm" GroupID="#Attributes.GroupID#" ContentID="#Attributes.GrpContentID#" PastDayColor="Navy" TitleBar="No" ShowPrev="no">
		<br>
		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="verdana" color="ffffff" size="-1"><b>Events by Keyword</b></font></td>
		</tr>
		<tr valign=middle>
			<td align=center>
			
				<cfform method="POST" name="Keyword" action="SiteContent.cfm?GroupID=#attributes.groupid#&GCID=#Attributes.GrpContentID#">
				<cfinput type="text" name="Keyword" value="" size=15 maxlength=50 required="Yes" message="You must enter a term to search"><br>
				<input type="Submit" value="Search!">
				</cfform>
			
			</td>
		</tr>
		</table>
	</td>
	<td><br>
		<font face="Verdana" size="-1">
		<cfoutput query="GetCal">
			<p><strong>#DateFormat(BeginDate, 'mmmm d, yyyy')#</strong><br>
			<b><cfif Description is not ""><a href="ListEvents.cfm?EventID=#EventID#&GroupID=#Attributes.GroupID#">#EventName#</a><cfelse>#EventName#</cfif></b><br>  
			<cfif Location is not "">Location: #Location#<br>  </cfif>
			<cfif DatePart("h", BeginDate) gt 0>Time: #TimeFormat(BeginDate, 'hh:mm tt')#  <br></cfif>
			<cfif Contact is not "">Contact: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif></cfif>
			<cfif URL is not ""><br>  Web: <a href="http://#rereplacenocase(URL, "https?://", "", "ALL")#">#URL#</a><br></cfif>
			</p>
		</cfoutput>
		
		</font>
	</td>
</tr>
</table>
<br>

  <cfelse>
  <div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO EVENTS FOR THIS GROUP</strong></font></div> 
</cfif>

</blockquote>