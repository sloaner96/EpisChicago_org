<cfset BegPeriod = DateAdd("m", -2, now())>
<cfquery name="Articles" datasource="#Application.DSN#">
	SELECT * From Articles
		WHERE Approved = True
			<cfif IsDefined("Form.SrchTerm")>
				<cfif Form.SrchTerm is not "" OR IsDate(Form.SrchDate)>
					<cfif Form.SrchTerm is not "">
					AND (Headline LIKE '%#Form.SrchTerm#%' OR SubHeading LIKE '%#Form.SrchTerm#%' OR ArticleText LIKE '%#Form.SrchTerm#%')
					</cfif>
					<cfif IsDate(Form.SrchDate)>
					AND DateSubmitted >= #CreateODBCDate(Form.SrchDate)#
					</cfif>
				<cfelse>
					AND DateSubmitted >= #BegPeriod#
				</cfif>
			<cfelse>
				AND DateSubmitted >= #BegPeriod#
			</cfif>
		ORDER BY DateSubmitted DESC
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
	<TITLE>Chicago Diocese -- News Headlines from the Episcopal News Service</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Episcopal News Service"
	subtitle="Headlines across the Episcopal Church">

<blockquote>
<font face="Verdana" size="-1">

<SCRIPT language="javascript" src="http://www.episcopalchurch.org/javascript/13643_ENG_javascript.js"></SCRIPT>

</font>
</blockquote>

</cfmodule>
</HTML>
