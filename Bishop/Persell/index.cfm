<cfquery name="SermonNfo" datasource="#Application.DSN#">
	SELECT TOP 1 * From Sermons s, Bishops b
		WHERE s.BishopID = 1 AND b.BishopID = s.BishopID
			<cfif IsDefined("URL.SID")>
			AND SermonID = #URL.SID#
			<cfelse>
			AND SermonType IN ('MESG','SERMON')
			</cfif>
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
	<TITLE>Chicago Diocese -- Message from the Bishop</TITLE>
</head>

<CFMODULE Template="#Application.header#"
	PageTitle="The Bishop's Corner" SubTitle="The Rt. Rev. William D. Persell">

<blockquote>
<cfoutput query="SermonNfo">
<P><FONT color=Navy SIZE="+3">#SermonTitle#</FONT><br>

<cfif ImgName neq "">
	<img src="#ImgName#" align=right alt="" border="0">
<cfelse>
	<img src="#BishopImage#" align=right alt="" border="0">
</cfif>
#DateFormat(SermonDate, 'mmmm d, yyyy')#</P><br>

<font face="Verdana,Arial" color=black size="-1">

<p>#Replace(SermonText, "#chr(13)##chr(10)#","<br>","ALL")#</p>

<p><b>#BishopName#</b><br>
<i>Bishop of Chicago</i></p>
</font>
</cfoutput>
</blockquote>

</CFMODULE>
</HTML>
