<cfset EndPeriod = DateAdd("m", 3, now())>
<cfquery name="GetCal" datasource="#Application.DSN#">
	SELECT TOP 3 e.EventName, e.EventID From Events e
		WHERE e.Approved = 1
			AND e.EventGroup = 'D'
			AND (e.HighLight = 1 OR e.EndDate <= #EndPeriod#)
			AND e.EndDate >= #CreateODBCDateTime(now())#
		ORDER BY e.Highlight, e.BeginDate
</cfquery>

<cfset BegPeriod = DateAdd("m", -2, now())>
<cfquery name="Articles" datasource="#Application.DSN#">
	SELECT TOP 3 Headline, ArticleID From Articles
		WHERE Approved = 1 AND HighLight = 1
		ORDER BY DateSubmitted DESC, ArticleID DESC
</cfquery>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Anglican community in Northern Illinois, called by God to new and abundant life in Christ, we celebrate and share our Christian faith and tradition through worship, study, fellowship, social witness and service.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>The Episcopal Diocese of Chicago, Illinois</TITLE>
</head>

<CFMODULE Template="#Application.header#" IsHome="Yes" NavAlign="center" TabWidth="600">


<font face="Verdana,Arial" size="-1">
<div align="center">
   	<center>
   		<table border="0" cellpadding="0" cellspacing="0" width="600">
   			<tr>
   				<td colspan="2" valign=middle align=center>
					<font face="Garamond,'News Gothic MT',Arial" size="+3" color="navy"><b>The <i>Episcopal</i><br>Diocese</b></font>
   				</td>
   				<td rowspan="2" align=center valign=middle>
					<small>
					<a href="http://www.saintjamescathedral.org" target="_blank"><img src="/images/OurCathedral.jpg" width=82 height=100 alt="" border="0"></a><br clear=left><b>Our Cathedral</b>
					</small>
   				</td>
   				<td colspan="2" align=right>
					<form name="SiteSrch" method="POST" action="/SiteSearch.cfm">
					<nobr><font face="Tahoma,Arial" size="-1" color="Purple"><b>Site Search</b>: </font><input type="text" name="Term" size=10 maxlength=60></nobr>
					</form>
					<form name="FindKwd" method="POST" action="/Diocese/ParishLocator.cfm">
					<nobr><font face="Tahoma,Arial" size="-1" color="Purple"><b>Find a church</b>: </font><input type="text" name="Keyword" size=10 maxlength=60></nobr>
					</form>
   				</td>
   			</tr>
   			<tr>
   				<td rowspan="2" valign=middle align=center>
					<small>
					<a href="/Bishop/"><img src="/images/OurBishops.jpg" width=124 height=88 alt="" border="0"></a><br clear=left><b>Our Bishops</b>
					</small>
   				</td>
   				<td align=center>
					<font face="Garamond" size="+3" color="navy"><b>of</b></font>
   				</td>
   				<td>&nbsp;
					
   				</td>
   				<td valign="top" rowspan="3" valign=middle align=center>
					<small>
					<br><br><br>
					<a href="/Faith/"><img src="/images/OurFaith.jpg" width=95 height=139 alt="" border="0"></a><br clear=left><b>Our Faith</b><br><br><br><br>
					<a href="/Ministries/"><img src="/images/OurMinistry.jpg" width=117 height=95 alt="" border="0"></a><br clear=left><b>Our Ministry</b><br><br><br><br>
					<a href="/Diocese/"><img src="/images/OurOrder.jpg" width=100 height=120 alt="" border="0"></a><br clear=left><b>Our Order</b><br>
					</small>
   				</td>
   			</tr>
   			<tr>
   				<td colspan="3" align=center>
					<img src="/images/Chicago.gif" width=210 height=80 alt="" border="0"><br clear=left>
   				</td>
   			</tr>
   			<tr>
   				<td colspan="2" valign="top" bgcolor="#FFEDCA">
					<table border="0" cellpadding="4" cellspacing="0" width="100%">
   						<tr>
   							<td width="100%">
								<font face="Arial" color="Purple" size="+1">Newswatch</font><hr align=left width=85% size=1>
								<table width=100% border=0 cellspacing=2 cellpadding=0>
								<cfoutput query="Articles">
								<tr valign=top>
									<td><li type="circle"></li></td>
									<td><small><a href="/News/ViewArticle.cfm?ArticleID=#ArticleID#">#Headline#</a></small></td>
								</tr>
								</cfoutput>
								</table>

								<br><br>
								<font face="Arial" color="Purple" size="+1">Datewatch</font><hr align=left width=85% size=1>
								<table width=100% border=0 cellspacing=2 cellpadding=0>
								<cfoutput query="GetCal">
								<tr valign=top>
									<td><li type="circle"></li></td>
									<td><small><a href="ViewEvent.cfm?EventID=#EventID#">#EventName#</a></small></td>
								</tr>
								</cfoutput>
								</table>

								<br><br>
								<font face="Arial" color="Purple" size="+1">Resource Center</font><hr align=left width=85% size=1>
								<table width=100% border=0 cellspacing=2 cellpadding=0>
								<tr valign=top>
									<td><li type="circle"></li></td>
									<td><small><a href="/Diocese/Convention/">Diocesan Convention 2003</a></small></td>
								</tr>
								<tr valign=top>
									<td><li type="circle"></li></td>
									<td><small><a href="/Diocese/Offices/Finance/parochialreports.cfm">Parochial Reports</a></small></td>
								</tr>
								<tr valign=top>
									<td><li type="circle"></li></td>
									<td><small><a href="/Forms/Docs/2004BudgetGuidelines.pdf" target="_blank">2004 Budget Guidelines</a></small></td>
								</tr>
								</table>
   							</td>
   						</tr>
   					</table>
				</td>
   				<td valign=top align=center>
   					<table border="0" cellpadding="4" cellspacing="0">
   						<tr valign=top>
   							<td align=center><br>
								<font face="Arial" size="-1" color="Navy"><B>DEMO SITE</B><br><i>The Episcopal Church<br>in Northern Illinois</i></font>
								<br><br><br><small>
								Episcopal&nbsp;Church&nbsp;Center<br>
								65 E. Huron St.<br>
								Chicago, IL 60611<br>
								(312)751-4200<br>
								fax (312) 787-4534<br>
								<a href="/Directions.cfm"><i>Map & Directions</i></a><br>
								</small>
   							</td>
   						</tr>
   						<tr valign=middle>
   							<td height=103>
								<small><br><br><a target="_blank" href="/Diocese/Convention/Repository/Reports/2002-StrategicPlan.pdf"><IMG src="/images/CrossComposition-sm.jpg" width="40" height="43" alt="" border=0 align=middle></a><B>Strategic Plan</B>
								</small><br><br>&nbsp;
   							</td>
   						</tr>
   					</table>
					<small><center><br><a href="/Faith/Heritage/"><img src="/images/photos/OurHeritage.jpg" width=103 height=120 alt="" border="0"></a><br clear=left><b>Our Heritage</b></small></center><br>
   				</td>
   				<td>&nbsp;
					
   				</td>
   			</tr>
   			<tr>
   				<td colspan="2" valign=bottom>
					<br>
					<small>
					<a href="/Diocese/DiocesanLogo.cfm"><img src="/images/DioLogo.jpg" width=60 height=60 alt="" border="0" align=left></a><br><br><br><b>Our Diocesan Logo</b>
					</small>
   				</td>
   				<td colspan="3" valign=bottom align=right>
					<br>
					<small>
					<a href="/Faith/AboutEpisShield.cfm"><img src="/images/3dShield.gif" width=52 height=60 alt="" border="0" align=right></a><br><br><br><b>Episcopal Church Shield</b>
					</small>
   				</td>
   			</tr>
   		</table>
	</center>
</div>
</font>

</CFMODULE>
</HTML>
