<cfquery name="CommList" datasource="#Application.DSN#">
	SELECT * 
	From GroupNfo
	Where GroupType IN ('C', 'M')
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

<img src="/images/SecComm.jpg" width=168 height=200 alt="" border="0" align=left vspace=5>

<center>
<table width=430 border=0>
<cfloop index="IRec" from="1" to="#CommList.RecordCount#" step="2">
<tr valign=top>
	<td width=50%><font face="Arial" color="Navy" size="-1"><cfoutput><a href="/diocese/offices/index.cfm?GroupID=#CommList.GroupID[IRec]#">#CommList.GroupName[IRec]#</a></cfoutput><br></font></td>
	<td width=50%><cfif IRec lt CommList.RecordCount><font face="Arial" color="Navy" size="-1"><cfoutput><a href="/diocese/offices/index.cfm?GroupID=#CommList.GroupID[IRec+1]#">#CommList.GroupName[IRec+1]#</a></cfoutput><br></font></cfif></td>
</tr>
</cfloop>
</table>
</center>


</cfmodule>
</HTML>
