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
	<TITLE>Chicago Diocese -- Anglican Advance News Briefs</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan News"
	subtitle="The latest news around the Diocese"
	BottomLink='<a href="/News/ensfeed.cfm">See latest ENS Headlines</a>'>

<div align=right>
<cfform name="NewSearch" action="index.cfm" method="POST">
<table border=0 cellspacing=0 cellpadding=0 bordercolor=gray>
<tr>
	<td align=right>
	<font face="Arial" color="Navy" size="-1">
	Search Archives for: <cfinput name="srchterm" value="" size=15 maxlength=30 required="No">
	dated since: <cfinput name="srchdate" value="" size=12 maxlength=12 validate="date" required="No">
	<input type="Submit" value="Search!"><hr>
	<i><cfoutput>#Articles.RecordCount#</cfoutput> Article(s) found</i>
	</td>
</tr>
</table>
</cfform>
</div>


<blockquote>
<font face="Verdana" size="-1">

<cfoutput query="Articles">

<FONT face="Tahoma" size="+1" COLOR="Navy">#Headline#</FONT>
<p>#SpanExcluding(ArticleText, '#chr(10)#')# <A HREF="ViewArticle.cfm?ArticleID=#ArticleID#"><img src="/images/Read.gif" width=50 height=15 alt="Read the full story" border="0"></A></p>

</cfoutput>

</font>
</blockquote>

</cfmodule>
</HTML>
