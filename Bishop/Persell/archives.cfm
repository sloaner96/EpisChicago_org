<cfquery name="SermonNfo" datasource="#Application.DSN#">
	SELECT SermonID, SermonDate, SermonTitle From Sermons s, Bishops b
		WHERE s.BishopID = 1 AND b.BishopID = s.BishopID
			AND SermonType IN ('MESG','SERMON')
		ORDER BY SermonDate DESC
</cfquery>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop donovan, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Bishop Message Archives</TITLE>
</head>

<CFMODULE Template="#Application.header#"
	PageTitle="Bishop Message Archives" SubTitle="The Rt. Rev. William D. Persell">

<center>
<table width=90% border=0 cellspacing=1 cellpadding=3>
<tr valign=top bgcolor="#f3f3f3">
	<th align=left width=110>Date</th>
	<th align=left wdith=100%>Title</th>
</tr>

<cfoutput query="SermonNfo">
	<tr valign=top>
		<td width=100><font face="Arial" size="-1" color="black">#DateFormat(SermonDate, "m/d/yyyy")#</td>
		<td width=100%><FONT face="Verdana,Arial" color=Navy size="-1"><a href="index.cfm?SID=#SermonID#">#SermonTitle#</a></FONT></td>
	</tr>
</cfoutput>
</table>
</center>

</CFMODULE>
</HTML>
