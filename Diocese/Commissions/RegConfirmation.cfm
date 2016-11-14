<cfif NOT IsDefined("Form.Name")>
	<cflocation url="MinRegister.cfm">
</cfif>

<cfif Form.Parish is not "*">
	<cfquery name="Parishes" datasource="#Application.DSN#">
		SELECT OrgID, ParishName, City From Directory
			WHERE OrgID = #Form.Parish#
	</cfquery>
	<cfset ParishName = "#Parishes.ParishName# - #Parishes.City#">
<cfelse>
	<cfset ParishName = "None Specified">
</cfif>

<cfquery name="ConfNfo" datasource="#Application.DSN#">
	SELECT c.*, d.ParishName, d.Address1, d.Address2, d.City, d.State, d.ZipCode, d.WebSite From Conferences c
		LEFT OUTER JOIN Directory d ON (d.OrgID = c.OrgID)
		WHERE ConfID = #Form.ConfID#
</cfquery>
<cfquery name="Schedule" datasource="#Application.DSN#">
	SELECT *, Str(Month(ActivityDate))+'/'+Str(Day(ActivityDate))+'/'+Str(Year(ActivityDate)) as ActDate From ConfSchedule
		WHERE ConfID = #Form.ConfID#
		ORDER BY ActivityDate, Activity
</cfquery>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="workshops, conferences, seminars, episcopal, episcopal church, diocese, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<cfoutput><TITLE>Chicago Diocese -- #ConfNfo.ConfName# Workshop Registration Confirmation</TITLE></cfoutput>
</head>

<cfmodule template="#Application.header#" NavAlign="center" Banner="No">

<blockquote>	

<cfoutput query="ConfNfo">
<cfif LogoImage neq ""><a href="#HomeURL#"><img src="/images/#LogoImage#" alt="" border="0" align=right></a></cfif>
<p align=center>
<font color="Blue" face="Tahoma,Arial" size="+3">
#ConfName#
</font><br><br>

<cfif Theme neq "">
	<font color="Navy" face="Tahoma,Arial" size="+1">
	<i>#Theme#</i>
	</font><br><br>
</cfif>

<font face="Verdana,Arial" color="navy">
#DateFormat(StartDate, "mmmm d, yyyy")#<cfif DateCompare(StartDate, EndDate, "d") neq 0> - #DateFormat(EndDate, "mmmm d, yyyy")#</cfif><br>
<small>#TimeFormat(StartDate, "h:mm TT")# - #TimeFormat(EndDate, "h:mm TT")#</small><br><br>
<small>
<cfif ParishName neq "">
	#ParishName#<br>
	#Address1#<cfif Address2 neq "">, #Address2#</cfif>, #City#, #State#<br>
<cfelse>
	#Replace(Location, "#chr(13)##chr(10)#", "<br>", "ALL")#<br>
</cfif>
Contact: #ContactName# at #Phone#<br>
</small>
</font>

</p><br clear=all>
</cfoutput>

<FONT SIZE="-1" face="Verdana,Arial">

<cfset ErrorList = ArrayNew(1)>

<CFIF Form.Name is "">
	<cfset x = ArrayAppend(ErrorList, "You must supply your <b>Name</b> for your registration.")>
</CFIF>

<CFIF Form.Name neq "">
	<cfquery name="ChkDup" datasource="#Application.DSN#">
		SELECT AppID From Applicants
			WHERE ConfID = #Form.ConfID# AND Name = '#Form.Name#'
				AND (Phone = '#Form.Phone#' OR Email = '#Form.Email#')
	</cfquery>
	<cfif ChkDup.RecordCount gt 0>
		<cfset x = ArrayAppend(ErrorList, "We have already received your registration for this Event!")>
	</cfif>
</CFIF>

<cfif ConfNfo.MealOffered neq "" AND NOT IsDefined("Form.Meal")>
	<cfset x = ArrayAppend(ErrorList, "You must specify either a <b>Meat or Vegetarian</b> meal.")>
</CFIF>

<CFIF Form.Phone is "" AND Form.Email is "">
	<cfset x = ArrayAppend(ErrorList, "You must specify either a <b>Day Phone</b> or an <b>Email Address</b> in order for us to contact you if necessary.")>
</CFIF>

<cfif Form.Email neq "">
	<cfx_checkemail email="#form.email#">
	<cfif Check_Email_Level gt 0>
		<cfset x = ArrayAppend(ErrorList, "#Check_Email_Message#")>
	</cfif>
</cfif>

<cfset CourseList = "">
<cfset ChkList = QueryNew("CourseNbr, WorkShop")>
<CFLOOP index="Nbr" from="1" to="#ConfNfo.NSessions#">
	<CFSET QField = Evaluate('Form.Session'&'#Nbr#')>
	<cfif QField is "*">
		<cfset x = ArrayAppend(ErrorList, "You have neglected to provide a selection for your <b>Workshop Choice ###Nbr#</b> on the form!")>
	<cfelse>
		<cfquery name="WSInfo" datasource="#Application.DSN#">
			SELECT * From Workshops
				WHERE ConfID = #Form.ConfID# AND CourseNbr = #QField#
		</cfquery>
		<cfset CourseList = ListAppend(CourseList, "#QField#")>
		<cfset x = QueryAddRow(ChkList)>
		<cfset x = QuerySetCell(ChkList, "CourseNbr", #QField#)>
		<cfset x = QuerySetCell(ChkList, "WorkShop", "#WSInfo.WorkShop#")>
	</CFIF>
</cfloop>

<CFIF ChkList.RecordCount neq ConfNfo.NSessions>
	<cfset x = ArrayAppend(ErrorList, "You must specify #ConfNfo.NSessions# <b>unique</b> workshop choices.")>
</CFIF>


<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="Arial" color="Black">#NErrors# problem(s) encountered with your Registration Form</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<cfset LFeed = '#chr(13)##chr(10)#'>
	<cfquery name="AddReg" datasource="#Application.DSN#">
		INSERT INTO Applicants
			(DateEntered, ConfID, Name, OrgID, 
			 Address1, City, State, ZipCode, Phone, Email, Comments,
			 WS1, WS2, WS3, WS4, MealChoice, DayCare)
		Values
			(#CreateODBCDateTime(now())#,
			 #Form.ConfID#,
			 '#Form.Name#',
			 <cfif Form.Parish neq "*">#Form.Parish#<cfelse>NULL</cfif>,
			 '#Form.Address#',
			 '#Form.City#',
			 '#Form.State#',
			 '#Form.ZipCode#',
			 '#Form.Phone#',
			 '#Form.Email#',
			 <cfif Form.Interest neq "">'#Form.Interest#'<cfelse>NULL</cfif>,
			<CFLOOP index="Nbr" from="1" to="4">
				<cfif IsDefined("Form.Session#Nbr#")><CFSET QField = Evaluate('Form.Session'&'#Nbr#')>#QField#<cfelse>NULL</cfif>,
			</cfloop>
			<cfif ConfNfo.MealOffered neq "">'#Form.Meal#'<cfelse>NULL</cfif>,
			<cfif ConfNfo.DayCare is True>'Infants: #Form.Infant# | Toddlers: #Form.Toddler# | Ages 3-5: #Form.Age3to5# | Ages 6-8: #Form.Age6to8# | Age 9 & up: #Form.Age9up#'<cfelse>NULL</cfif>)
	</cfquery>

	<cfmail query="ChkList" to="robertkohl@usa.net" cc="webmaster@episcopalchicago.org" from="#Form.Email#" subject="Online Registration for #ConfNfo.ConfName# from #Form.Name#" Server="mail.epischicago.org">
*** Message begins

A Registration for the #ConfNfo.ConfName# has been submitted via the Diocese of Chicago web site at #TimeFormat(now(), "hh:mm TT")# on #DateFormat(now(), "mmm d, yyyy")#

Name: #Form.Name#
#Form.Address#
#Form.City#, #Form.State# #Form.Zipcode#
Day Phone: #Form.Phone#
Email: #Form.EMail#

Home Parish: #ParishName#

Workshops Requested
<cfoutput>Choice ###CurrentRow#: #WorkShop#
</cfoutput>

<cfif ConfNfo.MealOffered neq "">#Form.Meal# Lunch requested</cfif>

<cfif ConfNfo.DayCare is True>
<cfif Form.Infant is not "" OR Form.Toddler is not "" OR Form.Age3to5 is not "" OR Form.Age6to8 is not "" OR Form.Age9up is not "">
Childcare requested for:
<cfif Form.Infant is not "">#Form.Infant# infants</cfif>
<cfif Form.Toddler is not "">#Form.Toddler# toddlers</cfif>
<cfif Form.Age3to5 is not "">#Form.Age3to5# 3-5 year olds</cfif>
<cfif Form.Age6to8 is not "">#Form.Age6to8# 6-8 year olds</cfif>
<cfif Form.Age9up is not "">#Form.Age9up# 9 & up</cfif>
</cfif></cfif>

*** Message ends
	</cfmail>

	<font face="Arial">
	<table width=275 border=0 cellpadding=1 cellspacing=3 align=right bgcolor="#f6f6f6">
	<cfoutput query="Schedule" group="ActDate">
		<tr valign="top" bgcolor="##F3E9DE">
			<td colspan=2>
				<font face="Tahoma,Verdana,Arial" size="+1" color="Maroon">#DayofWeekAsString(DayofWeek(ActivityDate))# Schedule</font>
			</td>
		</tr>
		<cfoutput>
		<cfif ActLength neq "">
			<cfset EndDate = DateAdd("n", ActLength, ActivityDate)>
		</cfif>
		<tr valign=top>
			<td width=80><small><nobr>#TimeFormat(ActivityDate, "h:mmTT")#</nobr></small></td>
			<td width=100%><small><b>#Activity#</b><br>#Replace(ActivityText,"#chr(13)##chr(10)#","<br>","ALL")#</small></td>
		</tr>
		</cfoutput>
	</cfoutput>
	</table>
	</font>

	<cfoutput>
	<p>Dear <b>#Form.Name#</b>:</p>

	<p>Thank you for registering for the upcoming <b>#ConfNfo.ConfName#</b>.  Your registration information has been processed.  Please print and bring this confirmation page to the workshop with you.</p>

	<br>
	<p><b>Registration Summary</b><hr align=left width=70% size=1>
	Name: #Form.Name#<br>
	#Form.Address#<br>
	#Form.City#, #Form.State# #Form.Zipcode#<br>
	Day Phone: #Form.Phone#<br>
	Email: #Form.EMail#<br>
	Parish: #ParishName#<br>
	</cfoutput>

	<p>Workshops Requested:<br>
	<cfoutput query="ChkList">###CurrentRow#: #WorkShop#<br></cfoutput>

	<br>
	<cfoutput>
	<cfif IsDefined("Form.Meal")><i>#Form.Meal# Lunch requested</i><br></cfif>
	<cfif ConfNfo.DayCare is True>
		<cfif Form.Infant is not "" OR Form.Toddler is not "" OR Form.Age3to5 is not "" OR Form.Age6to8 is not "" OR Form.Age9up is not "">
		<i>Childcare requested for: 
		<cfif Form.Infant is not ""> #Form.Infant# infants -</cfif>
		<cfif Form.Toddler is not ""> #Form.Toddler# toddlers -</cfif>
		<cfif Form.Age3to5 is not ""> #Form.Age3to5# 3-5 year olds -</cfif>
		<cfif Form.Age6to8 is not ""> #Form.Age6to8# 6-8 year olds -</cfif>
		<cfif Form.Age9up is not ""> #Form.Age9up# 9 & up</cfif>
		</i><br>
		</cfif>
	</cfif>

	<p><font color="red">Please mail in your #DollarFormat(ConfNfo.Charge)# payment before the #DateFormat(ConfNfo.RegDeadline, "mmmm d, yyyy")# deadline.</font></p>
	</cfoutput>

	<cfoutput query="ConfNfo">
	<p>Sponsored by #Replace(Sponsor, "#chr(13)##chr(10)#", "<br>", "ALL")#</p>
	<p>Questions about the workshops can be directed to <a href="mailto:#EMail#">#ContactName#</a> at #Phone#.  Checks should be mailed to "Diocese of Chicago, 65 E. Huron, Chicago, IL 60611, Attention: #ContactName#".</p>
	</cfoutput>

</cfif>

</font>
</blockquote>
</cfmodule>

</HTML>
