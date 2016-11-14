<cfquery name="JobListing" datasource="#Application.DSN#">
	SELECT * From MarketJobs m
		LEFT OUTER JOIN Directory d ON (d.OrgID = m.DirectID)
		WHERE m.ExpiresOn is NULL OR m.ExpiresOn >= #CreateODBCDate(now())#
		ORDER BY m.DateCreated DESC
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
	<TITLE>Chicago Diocese -- The MarketPlace</TITLE>
</head>

<cfmodule template="#Application.header#" 
	PageTitle="The MarketPlace of Anglican Advance" 
	SubTitle='<I><FONT SIZE="-1">An emporium of parish/agency wish lists, job openings, goods and services for donation, and notices on membership or fund drives for parish/diocesan activities and organizations.</FONT></I>'>


<blockquote>

<cfoutput query="JobListing">

<FONT SIZE="+1" FACE="Verdana" COLOR="Navy">POSITION OPENING</FONT><br>
<FONT SIZE="-1"><I>Web Posted on #DateFormat(DateCreated, "mmmm, yyyy")#</I></FONT><br><br>

<table border=0 cellpadding=1 cellspacing=0>
<tr>
	<td align=right><font face="Verdana" size="-1"><B>Position</B>:</font></td>
	<td><font face="Verdana" size="-1">#Title#</FONT></td>
</tr>
<tr>
	<td align=right><font face="Verdana" size="-1"><B>Location</B>:</font></td>
	<td><font face="Verdana" size="-1"><cfif DirectID is "">#Location#<cfelse>#ParishName#, #City#</cfif></FONT></td>
</tr>
<tr>
	<td align=right><font face="Verdana" size="-1"><B>Contact</B>:</font></td>
	<td>
		<font face="Verdana" size="-1">
		<cfif ContactEmail is not ""><a href="mailto:#ContactEMail#">#Contact#</a>
		<cfelse>#Contact#</cfif>
		<cfif ContactPhone is not "">&nbsp;&nbsp;#ContactPhone#</cfif>
		</FONT>
	</td>
</tr>
</table>

<font face="Verdana,Arial,Helvetica" size="-1">
<br>#Replace(Description, "#chr(10)#", "<br>", "ALL")#<br>
</font>
<hr align=left width=60% size=1>

</cfoutput>

<p align=center><font color="Navy" face="Tahoma" size="-1"><i>Announcements for congregational job openings and publications for Marketplace<br>may be sent to <a href="mailto:dskidmore@episcopalchicago.org">David Skidmore</a> or mailed to the<br>Office of Communications, 65 E. Huron St., Chicago, IL 60611.</i></font></p>

</blockquote>

</CFMODULE>

</HTML>
