<cfquery name="Staff" datasource="#Application.DSN#">
	SELECT * From Staff
		WHERE Department = 'CONG'
		ORDER BY IsManager, LastName, FirstName
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
	<TITLE>Chicago Diocese -- Congregational Development Department</TITLE>
</head>

<cfmodule template="#Application.header#" PageTitle="Meet the Diocese" SubTitle="Congregational Development Department">

<blockquote>	
<font face="Verdana" size="-1">

<table width=90% border=0 cellspacing=0 cellpadding=8>
<tr valign=top>
	<td width=100%>
	<font size="-1">
	<P>The Department of Congregational Development is committed to enhancing and expanding the life and ministry of our congregations through guidance, training and assistance in evangelism, formation, leadership development, stewardship, planned giving, new member ministry, youth and young adult ministry, and church growth.</p>
	<p>The congregational development staff work in concert with other diocesan staff and the Congregational Development Commission in responding to the needs, concerns and hopes of our congregations.</P>
	</font>
	</td>
	<td width=110>
	<a href="http://www.link2lead.com"><img src="/images/Link2Lead.jpg" width=108 height=73 border=0 align="right" alt="Link2Lead.com is sponsored by Percept, the demographic information provider to religious organizations. The Diocese of Chicago’s account permits clergy and lay leaders of diocesan congregations to access the various demographic and analytical resources offered by Percept. Click here to access Link2Lead. Then go to Register and follow the prompts."></a><br clear=right>
	<a href="http://www.percept2.com/pn/login.asp"><img src="http://www.percept2.com/pn/Graphics/Logos/V2Klogo_wht_130.gif" border=1 width=110 height=83 align="right" alt="Access to the Percept Diocesan Demographic Information.  Contact Congregational Development for details on accessing this area"></a>
	</td>
</tr>
</table>

<!---
<center>
<table border=0 width=90% cellpadding=2>
<tr align="center" bgcolor="#F3F3F3">
<td>
<font color="Navy" face="Tahoma" size="+1">Workshop Event: "Gateways to Evangelism"</font>
<font size="-1">
&nbsp;&nbsp;(Click <a href="InvMinistry.cfm">here</a> for details)<br>
Saturday, April 29, 2000 Time: 9am-3pm at Trinity Episcopal Church<br>
</font>
</td>
</tr>
</table>
</center>
--->


<h3><font color="Navy" face="Tahoma">Congregational Development Commission</font></h3>

<table border=1 width=200 align=right cellpadding=2>
<tr align="left" bgcolor="#E1E1E1">
<td>
<h4 align=center><font color="Navy" face="Tahoma">Staff<hr align=center width=80% size=1></font></h4>
<font size="-2">
<cfoutput query="Staff">
<a href="mailto:#Email#">#Prefix# #FirstName# #MI# #LastName#</a><br><i>#Title#</i><br><br>
</cfoutput>
</font>
</td>
</tr>
</table>

<p>The mission of the Congregational Development Commission is to connect the congregations and other resources of the diocese by communicating, visioning, planning, training, and acting together to incarnate the bishop's vision statement: </p>
<p>As the Diocese of Chicago we are called to be a diverse and interactive community gathered around one table, seeking through continual conversion to have the mind and heart of Christ, and to serve the world in Christ's name.</p>
<p>The commission is made up of representatives from the 11 deaneries, the Diocesan Council, the Standing Committee, the Commission on Ministry, the Office of Deployment and Ministry Development, and special ministries which address racial and ethnic concerns, and campus ministries. </p>

<p>The commission's primary activities:</p>
<ol>
<li>Assist the congregational development team (congregational development staff, diocesan treasurer, diocesan deployment director and Congregational Development Commission chair) in building up ministries and congregations through programs such as Trustee Leadership Development, youth programs, stewardship mentoring, formation mentoring, and resource development.<br><br>
<li>Review transition plans for mission congregations, and witnessing congregations and ministries.<br><br>
<li>Implement an evaluation process for holding the Congregational Development Commission and the congregational development team mutually accountable.<br><br>
<li>Develop long-range strategies for ministries and congregations, both new and renewed.
</ol>

</font>
</blockquote>

</cfmodule>

</HTML>
