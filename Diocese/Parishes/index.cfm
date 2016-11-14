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
	<TITLE>Chicago Diocese -- Parishes on the Web</TITLE>
</head>

<CFMODULE Template="#Application.header#" PageTitle="Parishes on the Web">

<blockquote>
<font face="Verdana,Arial" size="-1">

<cfoutput><p>This page contains a listing of <b>#Parishes.RecordCount#</b> parishes and missions within the Diocese of Chicago which have a site on the WOrld Wide Web.  This list is sorted by City to better help you locate a parish close to you.</p></cfoutput>

<cfoutput query="Parishes" GROUP="City">
	<font face="Tahoma,Arial" size="+1" color="Maroon">#City#</font><br>
	<cfoutput>
		<p>&nbsp;&nbsp;<b>#ParishName#</b><br>
		&nbsp;&nbsp;<small><a href="#WebSite#" target="_blank">#WebSite#</a></small></p>
	</cfoutput>
	<br>
</cfoutput>

</font>
</blockquote>

</CFMODULE>
</HTML>
