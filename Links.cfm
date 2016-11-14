<cfquery name="LinkList" datasource="#Application.DSN#">
	SELECT l.*, c.CodeDesc From SiteLinks l, qLinkCat c
		WHERE c.CodeID = l.Category
		ORDER BY Category, SiteName
</cfquery>
<cfquery name="Parishes" datasource="#Application.DSN#">
	SELECT d.*, c.Prefix, c.FirstName, c.MiddleName, c.LastName, c.Suffix From Directory d
		LEFT OUTER JOIN Contacts c ON (d.ContactID = c.ContactID)
		WHERE d.WebSite <> '' AND d.WebSite is not NULL
			AND d.ParishType IN ('M','P')
		ORDER BY d.City, d.ParishName
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
	<TITLE>Chicago Diocese -- Christian Links</TITLE>
</head>

<CFMODULE Template="#Application.header#" PageTitle="Interesting Links">

<blockquote>
<font face="Verdana" size="-1">

<p><I>This page contains a listing of links to Episcopal, Anglican and Christian sites, including the official Episcopal Church site, Episcopal News Service, Episcopal seminaries and campus ministries, Illinois Episcopal parishes, and general Christian organizations.</I></p>

<table align=right width=150 border=0 cellpadding=3 cellspacing=2>
<tr valign="top" bgcolor="#F3E9DE">
	<td>
	<center><b>Parishes Online</b><hr></center>
	<font face="Arial" size="-2">
	<cfoutput query="Parishes">
	<p><a href="#WebSite#" target="_blank">#ParishName#</a><br>#City#</p>
	</cfoutput>
	</font>
	</td>
</tr>
</table>

<cfoutput query="LinkList" group="Category">

	<font face="Verdana,Arial" color="Navy" size="+1">#CodeDesc#</font><hr width=60% align=left><br>
	<ul type="circle">
	<cfoutput>
	<li><font face="Verdana,Tahoma,Arial" size="-1"><a href="#SiteURL#" target="_blank">#SiteName#</a><br><cfif Description is not "">#Description#<br></cfif></font>
	</cfoutput>
	</ul>
	
</cfoutput>

</font>
</blockquote>

</CFMODULE>
</HTML>
