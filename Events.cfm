<cfset EndPeriod = DateAdd("m", 3, now())>
<cfquery name="GetCal" datasource="#Application.DSN#">
	SELECT e.*, (select CodeDesc From Lookups l Where l.CodeValue = e.Category AND l.CodeGroup = 'EVENT') as CategoryName From Events e
		WHERE e.Approved = True AND e.Description <> ''
			AND e.EndDate >= #CreateODBCDateTime(now())#
			AND e.EndDate <= #EndPeriod#
			AND e.EventGroup = 'D'
			AND e.DiocesanWide = True
		ORDER BY BeginDate
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
	<TITLE>Chicago Diocese -- Events</TITLE>
</head>

<CFMODULE Template="#Application.header#"
	PageTitle="Diocesan Events"
	SubTitle="Events happenings across the Diocese">

<blockquote>
<font face="Verdana" size="-1">

<cfoutput query="GetCal">
<font face="Tahoma" size="+1" color="Navy">#EventName#</font><br>
<font color=black size="-2">
<b>Event Date</b>: #DateFormat(BeginDate, "mmm d, yyyy")# <cfif DatePart("h", BeginDate) gt 0>#TimeFormat(BeginDate, "h:mm tt")#</cfif>
<cfif EndDate is not ""> - #DateFormat(EndDate, "mmm d, yyyy")# <cfif DatePart("h", EndDate) neq 23 AND DatePart("n", EndDate) neq 59>#TimeFormat(EndDate, "h:mm tt")#</cfif></cfif><br>
<cfif CategoryName is not ""><b>Event Type</b>: #CategoryName#<br></cfif>
<cfif Location is not ""><b>Location</b>: #Location#<br></cfif>
<cfif Contact is not ""><b>Contact</b>: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif><br></cfif>
<cfif URL is not "">Visit <a href="#URL#">#URL#</a> for more information<br></cfif>
</font>

<br>
#ParagraphFormat(Description)#
<br>
</cfoutput>

</font>
</blockquote>

</CFMODULE>
</HTML>
