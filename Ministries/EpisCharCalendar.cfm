<cfset url.groupid = "32">

<cfparam name="Attributes.keywords" default="">
<cfparam name="Attributes.GroupID" default="32">

<cfset groupid = url.groupid>

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>


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
			<cfif Attributes.Keywords NEQ "">
			AND (EventName LIKE '%#Attributes.Keywords#%' OR Description LIKE '%#Attributes.Keywords#%')
			</cfif>
		ORDER BY GrpHighlight, BeginDate
</cfquery>



<cfset Today = now()>
<cfset NextThirty = DateAdd('d',90, today)>
<CFQUERY Name="Viewer" Datasource="#Application.dsn#">
	SELECT e.*
	FROM Events e
	WHERE e.OwningGroupID = #Attributes.GroupID# 
	AND e.BeginDate >= #CreateODBCDate(Today)# 
	AND e.BeginDate <= #CreateodbcDate(NextThirty)#
    Order By e.GrpHighlight, e.BeginDate
</CFQUERY>
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<cfoutput>
	<TITLE>Chicago Diocese -- Episcopal Charities and Community Services</TITLE>
    </cfoutput>
</head>

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#" subtitle="Calendar of Events"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		  
				
				
				<table width="100%" border=0 cellpadding=3 cellspacing=2>
				<cfif attributes.keywords NEQ ""><tr><td colspan=2 align="center"><cfoutput><font face="Verdana" size="-1"><strong>Search Results for Keywords:</strong> #Attributes.keywords#</font></td></tr></cfoutput></cfif>
				<tr valign="top">
					<td width="160" bgcolor="#f3f3f3">
						<table width=160 border=0>
						<tr valign=top bgcolor="Navy">
							<td align=center><font face="verdana" color="ffffff" size="-1"><b><cfoutput>#MonthAsString(month(now()))#</cfoutput></b></font></td>
						</tr>
						</table>
						<cfoutput><CFmodule template="#Application.CTMapping#/WebCal.cfm" EventCFM="ListEvents.cfm" GroupID="#Attributes.GroupID#" PastDayColor="Navy" TitleBar="No" ShowPrev="no"></cfoutput>
						<br>
						<table width=160 border=0>
						<tr valign=top bgcolor="Navy">
							<td align=center><font face="verdana" color="ffffff" size="-1"><b>Events by Keyword</b></font></td>
						</tr>
						<tr valign=middle>
							<td align=center>
							
								<cfform method="POST" name="Keyword" action="EpisCharClandar.cfm">
								<cfinput type="text" name="Keyword" value="" size=15 maxlength=50 required="Yes" message="You must enter a term to search"><br>
								<input type="Submit" value="Search!">
								</cfform>
							
							</td>
						</tr>
						</table>
					</td>
					<td>&nbsp;</td>
					<cfif Viewer.recordcount GT 0>
					<td width="75%"><br>
						<font face="Verdana" size="-1">
						<cfoutput query="GetCal">
							<b><font face="verdana" size="+1"><cfif Description is not ""><a href="ListEvents.cfm?EventID=#EventID#&GroupID=#Attributes.GroupID#">#EventName#</a><cfelse>#EventName#</cfif></font></b>
							<p><strong>#DateFormat(BeginDate, 'mmmm d, yyyy')#</strong><br>
							<cfif Location is not "">Location: #Location#<br>  </cfif>
							<cfif DatePart("h", BeginDate) gt 0>Time: #TimeFormat(BeginDate, 'hh:mm tt')#.  <br></cfif>
							<cfif Contact is not "">Contact: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif></cfif>
							<cfif URL is not "">  Web: <a href="http://#rereplacenocase(URL, "https?://", "", "ALL")#">#URL#</a><br></cfif>
							<br>  

							</p>
						</cfoutput>
						
						</font>
					</td>
					<cfelse>
					<td align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO EVENTS FOR THIS GROUP</strong></font></td>
				    </cfif>
				</tr>
				</table>
				<br>
				
				
				  
		</td>
		<td width="225" valign="top" align="right">
		   <cf_esidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#" showmembers ="1">
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>


<blockquote>


</blockquote>