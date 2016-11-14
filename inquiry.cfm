<cfif NOT IsDefined("Form.Name")>
	<cflocation url="/Contact.cfm">
</cfif>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Contact the Diocese</TITLE>
</head>


<CFMODULE Template="#Application.header#"
	PageTitle="Contact your Diocese">

<blockquote>
<font face="Verdana" size="-1">


<cfset ErrorList = ArrayNew(1)>

<CFIF #Form.Subject# is "">
	<cfset x = ArrayAppend(ErrorList, "You must supply a <b>Subject</b> for your inquiry.")>
</CFIF>

<CFIF #Form.Phone# is "" AND Form.Email is "">
	<cfset x = ArrayAppend(ErrorList, "You must specify either a <b>Day Phone</b> or an <b>Email Address</b> in order for us to respond back to you.")>
</CFIF>

<cfif Form.EMail is not "">
	<cfx_checkemail email="#form.email#">
	<cfif Check_Email_Level gt 0>
		<cfset x = ArrayAppend(ErrorList, "#Check_Email_Message#")>
	</cfif>
</cfif>

<CFIF #Form.Message# is "">
	<cfset x = ArrayAppend(ErrorList, "You have neglected to provide the text of your message on the form!")>
</CFIF>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Black">#NErrors# problem(s) encountered with your Inquiry</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<cfquery name="AddInquiry" datasource="#Application.DSN#">
		INSERT INTO Inquiries
			(DateCreated, Name, Company, Address1, City, State, ZipCode, Phone, Email, Comments, InqType)
			Values
			(#CreateODBCDateTime(now())#, '#Form.Name#', 'Parish: #Form.Parish#', '#Form.Address#', '#Form.City#', '#Form.State#', '#Form.ZipCode#',
			 '#Form.Phone#', '#Form.Email#', '#Form.Message#', '#Form.Subject#')
	</cfquery>

	<cfset ToAddr = "dskidmore@episcopalchicago.org">
	<cfif Subject is "Re-Development">
		<cfset ToAddr = "diocese@episcopalchicago.org">
	</cfif>

	<cfmail to="#ToAddr#" cc="webmaster@episcopalchicago.org" from="#Form.Email#" subject="Diocesan Web Site Inquiry from #Form.Name#" Server="mail.epischicago.org">
*** Message begins

A message from the Diocesan web site has been generated by:
#Form.Name# at #TimeFormat(now(), "hh:mm TT")# on #DateFormat(now(), "mmm d, yyyy")#
from Parish: #Form.Parish#
Day Phone: #Form.Phone#
Email: mailto:#Form.Email#

Subject: #Subject#

#Form.Message#

*** Message ends
	</cfmail>

	<h3><font color="Blue">Thank you for your Inquiry!</font></h3>

	<cfoutput>
	<p><b>#Form.Name#</b>, someone from the Diocese will respond back to you within the next day or two to confirm that we received your message.  If you have not heard from us within that timeframe, please feel free to call us at (312) 751-4200 during the day.</p>
	</cfoutput>

</cfif>

<br>
</CFMODULE>

</html>