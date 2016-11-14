<cfquery name="Months" datasource="#Application.DSN#">
	SELECT CodeValue, CodeDesc FROM Lookups
		WHERE CodeGroup = 'MONTH'
		ORDER BY CodeValue
</cfquery>
<cfquery name="Cats" datasource="#Application.DSN#" DEBUG>
	SELECT distinct e.Category,
			(select CodeDesc from Lookups l WHERE l.CodeGroup = 'EVENT' AND l.CodeValue = e.Category) as CodeDesc
		From Events e
		WHERE (e.Category is not NULL and e.Category <> '')
			AND e.BeginDate >= #now()#
		ORDER BY e.Category
</cfquery>
<CFQUERY Name="Galleries" Datasource="#Application.DSN#">
	SELECT * from Album
		WHERE Showable = TRUE
			AND Year(EventDate) = #Year(now())#
		ORDER By EventDate DESC, AlbName
</CFQUERY>

<cfset EndPeriod = DateAdd("m", 3, now())>
<cfquery name="GetCal" datasource="#Application.DSN#" DEBUG>
	SELECT * From Events
		WHERE Approved = True AND DiocesanWide = True
			AND EndDate >= #CreateODBCDateTime(now())#
			<cfif QUERY_STRING is "" AND NOT IsDefined("Form.FieldNames")>
			AND EndDate <= #EndPeriod#
			</cfif>
			<cfif IsDefined("URL.M")>
			AND Month(BeginDate) = #URL.M#
			</cfif>
			<cfif IsDefined("URL.D")>
			AND Day(BeginDate) = #URL.D#
			</cfif>
			<cfif IsDefined("URL.Y")>
			AND Year(BeginDate) = #URL.Y#
			</cfif>
			<cfif IsDefined("Form.CatList")>
			AND Category IN ('#Replace(Form.CatList,",","','","ALL")#')
			</cfif>
			<cfif IsDefined("Form.Keyword")>
			AND (EventName LIKE '%#Form.Keyword#%' OR Description LIKE '%#Form.Keyword#%')
			</cfif>
		ORDER BY BeginDate
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
	<TITLE>Chicago Diocese -- Calendar</TITLE>
</head>

<CFMODULE Template="#Application.header#"
	PageTitle="Diocesan Calendar of Events"
	SubTitle="What's happening in the new Millenium?  Take a look!"
	BottomLink='<a href="http://www.episcopalchurch.org/calendar.htm">National Church Calendar</a>'>


<table width=100% border=0 cellpadding=3 cellspacing=2>
<tr valign=top>
	<cfif Session.Handheld is False>
	<td width="160" bgcolor="#f3f3f3">
		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="Arial" color="Yellow" size="-1"><b><cfoutput>#MonthAsString(month(now()))#</cfoutput></b></font></td>
		</tr>
		</table>
		<CF_WebCal EventCFM="Calendar.cfm" PastDayColor="Navy" TitleBar="No" ShowPrev="no">
		<br>

		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="Arial" color="Yellow" size="-1"><b><cfoutput>Events by Month</cfoutput></b></font></td>
		</tr>
		</table>
		<center>
		<form method="GET" name="MonList" action="Calendar.cfm">
		<select name="M" size=1>
		<cfoutput query="Months">
		<option value="#CodeValue#" <cfif CodeValue is Month(now())>selected</cfif> >#CodeDesc#</option></cfoutput>
		</select>
		<select name="Y" size=1>
		<cfloop index="IYr" from="#year(now())#" to="#Evaluate(Year(now()) + 2)#">
			<cfoutput><option value="#IYr#" <cfif IYr is Year(now())>selected</cfif> >#IYr#</option></cfoutput>
		</cfloop><br>
		<input name="Cmd" type="Submit" value="Search!">
		</form>
		</center>

		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="Arial" color="Yellow" size="-1"><b>Events by Type</b></font></td>
		</tr>
		<tr valign=top>
			<td>
				<form method="POST" name="CatList" action="Calendar.cfm">
				<cfoutput query="Cats">
				<input type="checkbox" name="CatList" value="#Category#"><font face="Arial" size="-1"><nobr>#CodeDesc#</nobr></font><br>
				</cfoutput>
				<input type="Submit" value="Search!">
				</form>
			</td>
		</tr>
		</table>

		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="Arial" color="Yellow" size="-1"><b>Events by Keyword</b></font></td>
		</tr>
		<tr valign=middle>
			<td align=center>
				<form method="POST" name="Keyword" action="Calendar.cfm">
				<input type="text" name="Keyword" value="" size=15 maxlength=50><br>
				<input type="Submit" value="Search!">
				</form>
			</td>
		</tr>
		</table>

		<table width=160 border=0>
		<tr valign=top bgcolor="Navy">
			<td align=center><font face="Arial" color="Yellow" size="-1"><cfoutput><b>#Year(now())# Photo Galleries</b></cfoutput></font></td>
		</tr>
		</table>
		<center>(<a href="/Albums/"><i>List all Photo Albums</i></a>)</center>
		<font face="Arial" size="-2">
		<cfoutput query="Galleries">
		<p><a href="Albums/album.cfm?AlbumID=#AlbumID#&PNbr=1">#AlbName#</a></p>
		</cfoutput>
		</font>
	</td>
	</cfif>

	<td width=100%>
		<font face="Verdana" size="-1">

		<cfif Session.Handheld is False>
		<div align=right>
		<b><font color="Blue">Click here</font>&nbsp;&nbsp;&nbsp;&nbsp;</b><br>
		<a href="/Bishop/VisitationSchedule.cfm"><img src="/images/VisitationSchedule.gif" width=100 height=152 alt="Click here for Bishop Persell's Visitation Schedule" align=right alt="" border="1"></a>
		</div>
		</cfif>

		<cfoutput query="GetCal">
		<p><u>#DateFormat(BeginDate, 'mmmm d, yyyy')#</u><br>
		<b><cfif Description is not ""><a href="ViewEvent.cfm?EventID=#EventID#">#EventName#</a><cfelse>#EventName#</cfif></b>.  
		<cfif Location is not "">Location: #Location#.  </cfif>
		<cfif DatePart("h", BeginDate) gt 0>Time: #TimeFormat(BeginDate, 'hh:mm tt')#.  </cfif>
		<cfif Contact is not "">Contact: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif></cfif>.
		<cfif URL is not "">  Web: <a href="#URL#">#URL#</a></cfif>
		</p>
		</cfoutput>
		
		</font>
	</td>
</tr>
</table>
<br>

</cfmodule>
</HTML>
