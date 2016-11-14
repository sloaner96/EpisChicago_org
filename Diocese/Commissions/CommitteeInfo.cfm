<cfquery name="CommList" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		<cfif IsDefined("URL.CMID") AND IsNumeric(URL.CMID)>
			WHERE GroupID = #URL.CMID#
		</cfif>
		ORDER BY GroupName
</cfquery>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Diocesan Committees and Commissions</TITLE>
</head>

<cfmodule template="#Application.header#" PageTitle="Meet the Diocese" SubTitle="Committees and Commissions of the Diocese">

<dir>

<cfloop query="CommList">
<br><H3><font face="Arial" color="Navy"><cfoutput>#GroupName#</cfoutput><br></font></h3>
<table width=95% cellspacing=5 cellpadding=3 border=0>
<tr valign=top>
	<td bgcolor="#D3EEEF"><font face="Verdana"><i>Purpose</i></font></td>
	<td width=100%><cfoutput><font face="Arial" size="-1">#Purpose#</font></cfoutput></td>
<tr valign=top>
	<td bgcolor="#D3EEEF"><font face="Verdana"><i>Meetings</i></font></td>
	<td width=100%><cfoutput><font face="Arial" size="-1">#Meetings#</font></cfoutput></td>
</tr>
<tr valign=top>
	<td bgcolor="#D3EEEF"><font face="Verdana"><i>Contacts</i></font></td>
	<td width=100%>
		<cfquery name="GetContacts" datasource="#Application.DSN#">
			SELECT m.*, l.CodeDesc as MType From GroupMbrs m, qMbrTypes l
				WHERE l.CodeValue = m.MbrType
					and m.GroupID = #GroupID# AND m.IsPrimary = True
				ORDER BY MbrType
		</cfquery>
		<font face="Arial" size="-1">
		<cfoutput query="GetContacts">
		#Prefix# #FirstName# #MI# #LastName#<cfif Suffix neq "">, #Suffix#</cfif><CFIF MbrType neq "MBR">, #MType#</cfif>, #Phone#<cfif FAX neq "">, FAX: #FAX#</cfif><cfif Email neq "">, <a href="mailto:#EMail#">#EMail#</a></cfif><br>
		</cfoutput>
		</font>
	</td>
</tr>
</table>
<br>
</cfloop>

</dir>

</cfmodule>
</HTML>
