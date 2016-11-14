<cfquery name="Courses" datasource="#Application.DSN#">
	SELECT * From Workshops
		WHERE ConfID = 1
		ORDER BY CourseNbr
</cfquery>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="Congregational development, evangelism, workshops, conference, tim hall, episcopal, episcopal church, diocese, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Invitational Ministry Workshop Descriptions</TITLE>
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

<font face="Tahoma" color="Navy" size="+3">Workshop Descriptions</font><br>
<font face="Verdana" color="black"><a href="InvLeaders.cfm">Leader Biographies</a> | <a href="InvMinRegister.cfm">Register online!</a></font>
</p><br clear=all>

<FONT SIZE="-1" face="Verdana,Arial">

<cfoutput query="Courses">
<p>#CurrentRow#. <b>#WorkShop#</b></p>
<dir>
<p>#Description#<br>
<i>#Speaker#</i></p>
</dir>
</cfoutput>

</font>
</blockquote>
</cfmodule>

</HTML>
