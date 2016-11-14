<cfquery name="Formlist" datasource="#Application.DSN#">
	SELECT * From Forms
		WHERE Section = 'PASTORAL'
		ORDER BY FormName
</cfquery>

<cfset EndPeriod = DateAdd("m", 6, now())>
<cfquery name="GetCal" datasource="#Application.DSN#">
	SELECT e.*, (select CodeDesc From Lookups l Where l.CodeValue = e.Category AND l.CodeGroup = 'EVENT') as CategoryName From Events e
		WHERE Approved = True
			AND EndDate >= #CreateODBCDateTime(now())#
			AND EndDate <= #EndPeriod#
			AND EventGroup = 'P'
		ORDER BY BeginDate
</cfquery>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Office of Pastoral Care</TITLE>
</head>

<cfmodule template="#Application.header#" PageTitle="Meet the Diocese" SubTitle="Office of Pastoral Care">

<blockquote>	
<font face="Verdana" size="-1">

<table border=1 width=180 align=right cellspacing=0 cellpadding=4>
<tr align="left" bgcolor="#E1E1E1">
<td>
<h4 align=center><font color="Navy" face="Tahoma">Staff<hr align=center width=80% size=1></font></h4>
<font size="-2">
<p><b>Director of Pastoral Care</b><br>
The Rev. Randall R. Warren, D.Min.<br>
(312) 751-4209<br>
<a href="mailto:rwarren@episcopalchicago.org">rwarren@episcopalchicago.org</a></p>

<p><b>Administrative Assistant</b><br>
Elizabeth Erickson<br>
(312) 751-4212<br>
<a href="mailto:eerickson@episcopalchicago.org">eerickson@episcopalchicago.org</a></p>
</font>

<h4 align=center><font color="Navy" face="Tahoma">Documents<hr align=center width=80% size=1></font></h4>
<cfoutput query="Formlist">
	<a href="/Forms#FileName#"><img src="/images/PDF.gif" width=28 height=31 alt="" border="0" hspace=10 align=left><small>#FormName#</small></a><br clear=right><br>
</cfoutput>
</td>
</tr>
</table>

<P>The Office of Pastoral Care is available upon request to our bishops, diocesan committees and entities, clergy and parishioners to discuss sensitive ministry issues. Assistance with referrals to a variety of helping professionals, consultants and agencies is also available. The Director of the Office of Pastoral Care oversees the background checks and psychological testing of persons wishing to enter the formation/ordination process and is the case manager for clergy misconduct. The Administrative Assistant for Pastoral Care coordinates our diocesan Child Sexual Abuse Prevention and Adult Sexual Harrassment Prevention training programs.</P>

<!---
<font face="Tahoma" size="+1" color="Blue">Resources and Events</font>
<ul>
<p><li><a href="LentenDiscipline.cfm">Lenten Disciplines</a></p>
<p><li><a href="http://www.epischicago.org/ViewEvent.cfm?EventID=19">Pastoral Care and Alcoholism</a></p>
</ul>
<br>
--->

<cfif GetCal.RecordCount gt 0>
	<p><font face="Tahoma" size="+1" color="Blue"><cfoutput>#Year(now())#</cfoutput> Child Sexual Abuse & Adult Sexual Harassment Prevention Trainings</font><hr align=left width=90%></p>
	<p>Check the schedule below for upcoming trainings.  To schedule a parish training call Elizabeth Erickson at (312) 751-4212 or email her at <a href="mailto:eerickson@episcopalchicago.org">eerickson@episcopalchicago.org</a>.  Given the limited number of trainers, the scheduling of training will be limited to one Child and one Adult session per deanery per quarter.</p>

	<cfoutput query="GetCal">
	<p><b>#DateFormat(BeginDate, "mmmm d, yyyy")# (#DayOfWeekAsString(DayOfWeek(BeginDate))#)</b><br>
	#EventName#<br>
	#TimeFormat(BeginDate, "h:mm TT")# to #TimeFormat(EndDate, "h:mm TT")#<br>
	#Location#<br>
	#Replace(Description, "#chr(13)##chr(10)#", "<br>", "ALL")#<br>
	Registration: #Phone# <cfif ContactEmail is not ""> or <a href="mailto:#ContactEmail#">#ContactEmail#</a></cfif><br>
	</cfoutput>

</cfif>

</font>
</blockquote>

</cfmodule>

</HTML>
