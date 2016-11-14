<cfset url.groupid = "31">

<cfparam name="url.m" type="numeric" default="#Month(now())#">
<cfparam name="url.d" type="numeric" default="1">
<cfparam name="url.y" type="numeric" default="#Year(now())#">

<cfif Not IsNumeric(url.groupid)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfif Findnocase(";", url.groupid, 1)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfset groupid = url.groupid>
<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>


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
<TITLE>Chicago Diocese -- #GetGroupInfo.GroupName#</TITLE>
    </cfoutput>
</head>

<cfset SiteHeader = "#GetGroupInfo.GroupName# Events">

<cfset CalDate = CreateODbcDate(CreateDate(url.Y, url.m, url.d))>

<CFQUERY Name="Viewer" Datasource="#Application.dsn#">
	SELECT e.*,
	  (select CodeDesc 
	    From Lookups l 
		Where l.CodeValue = e.Category 
		AND l.CodeGroup = 'EVENT') as CategoryName 
	FROM Events e
	WHERE e.OwningGroupID = #GroupID# 
	AND e.Approved = True
	<cfif not IsDefined("Url.EventID")>
	 <cfif IsDefined("URL.M")>
	  AND Month(BeginDate) = #URL.M#
	 </cfif>
	 <cfif IsDefined("URL.D")>
	  AND Day(BeginDate) = #URL.D#
	 </cfif>
	 <cfif IsDefined("URL.Y")>
	   AND Year(BeginDate) = #URL.Y#
	 </cfif>
	 <cfelse>
		 <cfif IsDefined("Url.EventID")>
		  AND EventId = #Url.EventID#
		 </cfif>
	 </cfif>
</CFQUERY>
<cfmodule template="#Application.header#" PageTitle="#SiteHeader#">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td valign="top">
	    <table border="0" cellpadding="3" cellspacing="0" width="100%">
		 <cfif Viewer.recordcount GT 0>
			  <cfoutput query="Viewer">  
				<tr>
				   <td><font face="tahoma" color="003399" size="+1"><strong>#EventName#</strong></font></td>
				</tr>
				<tr>
				  <td><font face="verdana" size="-1">#DateFormat(BeginDate, 'MM/DD/YYYY')#<cfif beginDate NEQ EndDate> - #DateFormat(EndDate, 'MM/DD/YYYY')#</cfif></font></td>
				</tr>
				<cfif Location is not ""><tr><td><font face="verdana" size="-1">Location: #Location#</font></td></tr></cfif>
				<cfif DatePart("h", BeginDate) gt 0><tr><td><font face="verdana" size="-1">Time: #TimeFormat(BeginDate, 'hh:mm tt')#</font></td></tr></cfif>
				<cfif Contact is not ""><tr><td><font face="verdana" size="-1">Contact: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif></font></td></tr></cfif>
				<cfif URL is not ""><tr><td><font face="verdana" size="-1">Web: <a href="http://#reReplaceNoCase(URL, "https?://", "", "ALL")#" Target="_blank">#URL#</a></font></td></tr></cfif>
				<tr>
				  <td>&nbsp;</td>
				</tr>
				<tr>
				  <td><font face="verdana" size="-1">#Description#</font></td>
				</tr>
			  </cfoutput>
		  <cfelse>
		     <tr>
			   <td width="160" bgcolor="#f3f3f3">
					<table width=160 border=0>
					<tr valign=top bgcolor="Navy">
						<td align=center><font face="verdana" color="ffffff" size="-1"><b><cfoutput>#MonthAsString(month(now()))#</cfoutput></b></font></td>
					</tr>
					</table>
					<CFmodule template="#Application.CTMapping#/WebCal.cfm" EventCFM="ListEvents.cfm" GroupID="#GetGroupInfo.GroupID#" PastDayColor="666666" TitleBar="No" ShowPrev="no">
					<br>
					<table width=160 border=0>
					<tr valign=top bgcolor="Navy">
						<td align=center><font face="verdana" color="ffffff" size="-1"><b>Events by Keyword</b></font></td>
					</tr>
					<tr valign=middle>
						<td align=center>
						
							<cfform method="POST" name="Keyword" action="SiteContent.cfm?GroupID=#GetGroupInfo.groupid#&GCID=#GetGroupInfo.GrpContentID#">
							<cfinput type="text" name="Keyword" value="" size=15 maxlength=50 required="Yes" message="You must enter a term to search"><br>
							<input type="Submit" value="Search!">
							</cfform>
						
						</td>
					</tr>
					</table>
	           </td>
			   <td align="center"><font face="tahoma" color="maroon" size="-1">THERE ARE NO EVENTS FOR THIS DATE</font></td>
			 </tr>	  
		  </cfif>
		</table>
	 </td>
	<td width="225" valign="top" align="right">
		<cfoutput><cfmodule template="bsidenav.cfm" imgname="#GetGroupInfo.ImgName#" GroupName="#GetGroupInfo.GroupName#">  </cfoutput>
      </td>
  </tr>
</table>
</cfmodule>