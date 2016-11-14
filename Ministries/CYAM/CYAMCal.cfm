<cfquery name="GetCal" datasource="#Application.DSN#">
	SELECT e.*, (select CodeDesc From Lookups l Where l.CodeValue = e.Category AND l.CodeGroup = 'EVENT') as CategoryName From Events e
		WHERE Approved = True
			AND EndDate >= #CreateODBCDateTime(now())#
			AND EventGroup = 'YA'
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
	<TITLE>Chicago Diocese -- Campus / Young Adult Ministry Calendar</TITLE>
</head>

<cfmodule template="#Application.header#" Section="Ministry" PageTitle="Campus/Young Adult Ministries"
	SubTitle="Campus & Young Adult Events">

<center>
<table width=600 border=0 cellspacing=10 cellpadding=1>
<tr valign="top" bgcolor="#E6E6E6">
	<th width=200 align=left><font color="Blue" face="Verdana,Arial">Event Date</font></th>
	<th width=400 align=left><font color="Blue" face="Verdana,Arial">Event Description</font></th>
</tr>

<cfoutput query="GetCal">
<tr valign=top>
	<td width=200>
		<font face="Arial" size="-1">
		#DateFormat(BeginDate, "mmm d, yyyy")# <cfif DatePart("h", BeginDate) gt 0>#TimeFormat(BeginDate, "h:mm tt")#</cfif><cfif EndDate is not ""> - #DateFormat(EndDate, "mmm d, yyyy")#</cfif>
		</font>
		</td>
	<td width=400>
		<font face="Arial" size="-1">
		<b>#EventName#</b>.  
		<cfif Location is not "">Location: #Location#.</cfif>
		<cfif URL is not "">  Web: <a href="#URL#">#URL#</a></cfif>
		<cfif Description neq ""><br>#Description#</cfif>
		</font>
	</td>
</tr>
</cfoutput>
</table>
</center>

</cfmodule>
</HTML>
