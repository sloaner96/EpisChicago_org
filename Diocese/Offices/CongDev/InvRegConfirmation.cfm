<cfif NOT IsDefined("Form.Name")>
	<cflocation url="InvMinRegister.cfm">
</cfif>

<cfif Form.Parish is not "*">
	<cfquery name="Parishes" datasource="#Application.DSN#">
		SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
			WHERE OrgID = #Form.Parish#
	</cfquery>
	<cfset ParishName = Parishes.PName>
<cfelse>
	<cfset ParishName = "None Specified">
</cfif>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="Congregational development, evangelism, workshops, conference, tim hall, episcopal, episcopal church, diocese, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Invitational Ministry Workshop Registration Confirmation</TITLE>
</head>

<cfmodule template="#Application.header#" NavAlign="center" Banner="No">

<blockquote>	

<a href="InvMinistry.cfm"><img src="/images/Cow.gif" width=133 height=169 alt="" border="0" align=left></a>
<p align=center>
<font color="Blue" face="Tahoma" size="+2">
"Leaving the Table"
</font><br><br>

<font color="Navy" face="Tahoma" size="+1">
<i>GATEWAYS TO EVANGELISM</i>
</font><br><br>

<font face="Verdana,Arial">
<b>Congregational Development Event</b><br>
April 29, 2000<br>
<font size="-1">
Trinity Episcopal Church<br>
Wheaton, Illinois<br>
9 AM to 3 PM
</font>
</font></p>
<br clear=all>

<FONT SIZE="-1" face="Verdana,Arial">

<cfset ErrorList = ArrayNew(1)>

<CFIF #Form.Name# is "">
	<cfset x = ArrayAppend(ErrorList, "You must supply your <b>Name</b> for your registration.")>
</CFIF>

<CFIF #Form.Phone# is "" AND Form.Email is "">
	<cfset x = ArrayAppend(ErrorList, "You must specify either a <b>Day Phone</b> or an <b>Email Address</b> in order for us to contact you if necessary.")>
</CFIF>

<CFIF #Form.MSession# is "*">
	<cfset x = ArrayAppend(ErrorList, "You have neglected to provide a selection for your <b>Morning Workshop Session</b> on the form!")>
</CFIF>

<CFIF #Form.ASession# is "*">
	<cfset x = ArrayAppend(ErrorList, "You have neglected to provide a selection for your <b>Afternoon Workshop Session</b> on the form!")>
</CFIF>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Black">#NErrors# problem(s) encountered with your Registration Form</font></h4>
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
			(DateEntered, ConfID, Name, OrgID, Address1, City, State, ZipCode, Phone, Email, Comments)
			Values
			(#CreateODBCDateTime(now())#, 1, '#Form.Name#', #Parishes.OrgID#, '#Form.Address#', '#Form.City#', '#Form.State#', '#Form.ZipCode#',
			 '#Form.Phone#', '#Form.Email#', 'Morning Workshop: #Form.MSession##LFeed#Afternoon Workshop: #Form.ASession##LFeed#')
	</cfquery>

	<cfmail to="congdevoffice@episcopalchicago.org" from="#Form.Email#" subject="Online Evangelism Registration from #Form.Name#" Server="mail.epischicago.org">
*** Message begins

A Registration for the Evangelism Workshop has been submitted via the Diocese of Chicago web site at #TimeFormat(now(), "hh:mm TT")# on #DateFormat(now(), "mmm d, yyyy")#

Name: #Form.Name#
#Form.Address#
#Form.City#, #Form.State# #Form.Zipcode#

Home Parish: #ParishName#
Day Phone: #Form.Phone#
Email: #Form.EMail#

Workshops Requested
Morning: #Form.MSession#
Afternoon: #Form.ASession#

<cfif IsDefined("Form.Meal")>#Form.Meal# Lunch requested</cfif>
<cfif Form.Infant is not "" OR Form.Toddler is not "" OR Form.Age3to5 is not "" OR Form.Age6to8 is not "" OR Form.Age9up is not "">
Childcare requested for:
<cfif Form.Infant is not "">#Form.Infant# infants</cfif>
<cfif Form.Toddler is not "">#Form.Toddler# toddlers</cfif>
<cfif Form.Age3to5 is not "">#Form.Age3to5# 3-5 year olds</cfif>
<cfif Form.Age6to8 is not "">#Form.Age6to8# 6-8 year olds</cfif>
<cfif Form.Age9up is not "">#Form.Age9up# 9 & up</cfif>
</cfif>

*** Message ends
	</cfmail>

	<center><font face="Tahoma" color="Maroon" size="+1">Congratulations!  You are registered!</font></center><br>

	<table width="260" bordercolor=black cellpadding=4 cellspacing=0 border=1 align=right>
	<tr valign="top" bgcolor="#F3E9DE"><th>Workshop Schedule</th></tr>
	<tr valign="top" bgcolor="#F3F3F3"><td><font face="Tahoma,Arial" size="+1" color=Navy>Morning</font></td></tr>
	<tr valign=top>
		<td>
		<font face="Verdana" size="-1">
		8:30&nbsp;&nbsp;Registration & Refreshments<br>
		9:00&nbsp;&nbsp;Opening & Plenary Session<br>
		9:45&nbsp;&nbsp;Workshops Begin<br>
		11:30&nbsp;&nbsp;Lunch<br>
		</font>
		</td>
	</tr>
	<tr valign=top bgcolor="#F3F3F3"><td><font face="Tahoma,Arial" size="+1" color=Navy>Afternoon</font></td></tr>
	<tr valign=top>
		<td>
			<font face="Verdana" size="-1">
			12:30&nbsp;&nbsp;Workshops Continue<br>
			2:15&nbsp;&nbsp;Closing<br>
			3:00&nbsp;&nbsp;Dismissal<br>
			</font>
		</td>
	</tr>
	</table>

	<cfoutput>
	<p>Dear <b>#Form.Name#</b>:</p>

	<p>Thank you for yout interest in the upcoming Invitational Ministry workshop.  Your registration information has been processed.  Please print and bring this confirmation page to the workshop with you.</p>

	<p><b>Registration Summary</b></p>
	<p>Name: #Form.Name#<br>
	#Form.Address#<br>
	#Form.City#, #Form.State# #Form.Zipcode#<br><br>
	Home Parish: #ParishName#<br>
	Day Phone: #Form.Phone#<br>
	Email: #Form.EMail#</p>

	<p>Workshops Requested:<br>
	Morning: <b>#Form.MSession#</b><br>Afternoon: <b>#Form.ASession#</b></p>

	<cfif IsDefined("Form.Meal")><i>#Form.Meal# Lunch requested (please bring your $10 payment with you)</i><br></cfif>
	<cfif Form.Infant is not "" OR Form.Toddler is not "" OR Form.Age3to5 is not "" OR Form.Age6to8 is not "" OR Form.Age9up is not "">
	<i>Childcare requested for: 
	<cfif Form.Infant is not ""> #Form.Infant# infants -</cfif>
	<cfif Form.Toddler is not ""> #Form.Toddler# toddlers -</cfif>
	<cfif Form.Age3to5 is not ""> #Form.Age3to5# 3-5 year olds -</cfif>
	<cfif Form.Age6to8 is not ""> #Form.Age6to8# 6-8 year olds -</cfif>
	<cfif Form.Age9up is not ""> #Form.Age9up# 9 & up</cfif>
	</i><br>
	</cfif>
	<br>
	</cfoutput>

	<p align=center><i>Sponsored by:</i><br>
	<b>The Diocese of Chicago Congregational Development Commission</b><br>
	Direct questions about the workshops to <a href="mailto:sferguson@episcopalchicago.org">Sheila Ferguson</a> or <a href="mailto:thall@episcopalchicago.org">Tim Hall</a><br>
	at the Diocesan Center 312-751-4200 or 1-800-426-3894</p>

</cfif>

</font>
</blockquote>
</cfmodule>

</HTML>
