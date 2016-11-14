<cfquery name="Staff" datasource="#Application.DSN#">
	SELECT G.GroupID, G.GroupName, G.IsActive, G.GroupType, GM.Ranking, M.Title, M.Prefix, M.Firstname, M.MI, M.Lastname, M.LastName, M.Suffix, M.Phone, M.Email
	From GroupNfo G, GrpMembers GM, Members M  
	Where G.GroupID = Gm.GroupID
	AND GM.MemberID = M.MemberID
	AND G.GroupType IN ('D', 'B')
	Order By G.GroupType, G.GroupName, GM.Ranking, M.Lastname, M.Firstname 
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
	<TITLE>Chicago Diocese -- Diocesan Center Staff Directory</TITLE>
</head>

<cfmodule template="#Application.header#" PageTitle="Meet the Diocese" SubTitle="Diocesan Center Staff Directory">

<blockquote>	
<font face="Verdana,Arial" size="-1">
<p>The main phone number for the Diocesan Center is <b>(312) 751-4200</b>.  This page contains a listing of departments and contact persons along with their phone and email addresses.</p>
<p>Other than our main FAX number (312) 787-4534, the center has two other FAX machines located on the third floor (312) 787-5872 and the fourth floor (312) 787-4534.</p>
<p><i>(Note: All phone numbers are in the 312 Area Code.)</i></p>
</font>
</blockquote>

<font face="Arial" size="-1">
<center>
<table width=580 border=0 cellspacing=0 cellpadding=0>
<cfoutput query="Staff" Group="GroupID">
	<tr valign=bottom>
		<td colspan=2><br><font face="Tahoma,Arial" size="+1" color="black">#Groupname#</font><hr></td>
		<td><cfif Staff.IsActive neq ""><small><cfif Staff.GroupType NEQ "D"><a href="/Bishop/">View website</a><cfelse><a href="/diocese/offices/index.cfm?GroupID=#Staff.GroupID#">View website</a></cfif></small></cfif><hr></td>
	</tr>
	<cfoutput>
		<tr valign=top>
			<td width=270><small>#Title#</a></small></td>
			<td width=230><small><cfif Email neq ""><a href="mailto:#EMail#">#Prefix# #FirstName# #MI# #LastName#</a><cfelse>#Prefix# #FirstName# #MI# #LastName#</cfif></small></td>
			<td width=80 align=right><small>#Phone#</small></td>
		</tr>
	</cfoutput>
</cfoutput>
</table>
</center>
</font>

<br>
</cfmodule>

</HTML>
