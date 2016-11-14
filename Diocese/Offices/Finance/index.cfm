<cfquery name="Staff" datasource="#Application.DSN#">
	SELECT * From Staff s
		WHERE s.Department = 'FIN'
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
	<TITLE>Chicago Diocese -- Finance and Administration</TITLE>
</head>

<cfmodule template="#Application.header#" PageTitle="Finance and Administration">

<blockquote>	
<font face="Verdana" size="-1">

<table border=1 width=150 align=right cellpadding=2 cellspacing=0>
<tr align="left" bgcolor="#E1E1E1">
<td>

<table width=100% border=0>
<tr bgcolor="white"><td width=100% align=center><font face="Tahoma,Arial" color="Navy" size="+1">Staff</font></td></tr>
</table>

<br>
<font size="-2">
<cfoutput query="Staff">
<a href="mailto:#Email#">#Prefix# #FirstName# #MI# #LastName#</a><br><i>#Title#</i><br><br>
</cfoutput>
</font><br>

<table width=100% border=0>
<tr bgcolor="white"><td width=100% align=center><font face="Tahoma,Arial" color="Navy" size="+1">Site Contents</font></td></tr>
</table>

<center><font size="-1">
<!---<p><a href="enrollment.cfm">Open Enrollment</a></p>
<p><a href="FAQ.cfm">Open Enrollment FAQs</a></p> --->
<p><a href="Contacts.cfm">Church Administration Contacts</a></p>
<p><a href="Forms.cfm">Forms/Resources</a></p>
<p><a href="parochialreports.cfm">Parochial Reports</a></p><hr size=2 noshade>
<a target="_blank" href="/Forms/Docs/2004AetnaNationalHMO.pdf"><img src="/images/PDF.gif" width=28 height=31 alt="" border="0" hspace=10 align=left><small>2004 Aetna National HMO</small></a><br clear=left>
<a target="_blank" href="/Forms/Docs/2004AetnaPOS.pdf"><img src="/images/PDF.gif" width=28 height=31 alt="" border="0" hspace=10 align=left><small>2004 Aetna POS</small></a><br clear=left>
<a target="_blank" href="/Forms/Docs/2004BudgetGuidelines.pdf"><img src="/images/PDF.gif" width=28 height=31 alt="" border="0" hspace=10 align=left><small>2004 Budget Guidelines</small></a><br clear=left>
<a target="_blank" href="/Forms/Docs/clergyhousingtips.pdf"><img src="/images/PDF.gif" width=28 height=31 alt="" border="0" hspace=10 align=left><small>Tips on Clergy Housing Allowances</small></a><br clear=left>
<a target="_blank" href="/Forms/Docs/CompanionDioceseDonations.pdf"><img src="/images/PDF.gif" width=28 height=31 alt="" border="0" hspace=10 align=left><small>Companion Diocese Donations</small></a><br clear=left>
</font></center>

</td>
</tr>
</table>

<p><i>"Grant us grace that we may honor thee with our substance, and, remembering the account which we must one day give, may be faithful stewards of thy bounty"</i></p>

<p>Welcome to the web page for the office of Finance and Administration of the Diocese of Chicago.  This site has been designed to provide another medium for assistance and support to Episcopalians in northern Illinois.  The content will be developed and, when appropriate, revised to communicate financial, administrative, insurance and property issues.</p>
<p>Located at the diocesan center, a staff of four people is responsible for the financial administration of the diocesan operating budget (Administrative and Program Fund) and six corporations, including</p>

<ul>
<li>Bishop and Trustees (the diocesan real estate corporation)
<li>Diocesan Foundation (the diocesan mutual fund)
<li>Episcopal Charities and Community Services
<li>The Endowment Fund
<li>The Bishop's Funds (a corporation Sole)
<li>The Clergy Relief Society
</ul>

<p>Finance and Administration has oversight of investments and banking, budgeting and audits, risk management, real estate, information systems, health insurance and other projects.</p>
<p>We hope that this web site will provide you with information and resources, which will strengthen our churches and enable us to be good stewards of our bounty.</p>

</font>
</blockquote>

</cfmodule>

</HTML>
