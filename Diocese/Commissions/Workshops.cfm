<cfquery name="ConfNfo" datasource="#Application.DSN#">
	SELECT * From Conferences
		WHERE ConfID = 2
</cfquery>
<cfquery name="Courses" datasource="#Application.DSN#">
	SELECT * From Workshops
		WHERE ConfID = 2
		ORDER BY CourseNbr
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
	<cfoutput><TITLE>Chicago Diocese -- #ConfNfo.ConfName# Workshop Descriptions</TITLE></cfoutput>
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

<font face="Tahoma" color="Maroon" size="+2">Workshop Descriptions</font><br>
<font face="Verdana" color="black" size="-1">
<a href="#HomeURL#">Home</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="Workshops.cfm">Workshop Descriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="Register.cfm">Register online!</a>
</font>
</p><br clear=all>

</cfoutput>

<FONT SIZE="-1" face="Verdana,Arial">

<cfoutput query="Courses">
<table width="90%" border="0" cellspacing="0" cellpadding="1">
<tr valign=top bgcolor="##f3f3f3">
	<td width=4%><FONT FACE="Arial" color="Navy" size="+1">#CurrentRow#.</font></td>
	<td width=96%><FONT FACE="Arial" color="Navy" size="+1">#Workshop#</FONT></td>
</tr>
</table>
<dir>
<p>#Replace(Description, "#chr(13)##chr(10)#", "<br>", "ALL")#</p>
Presenters:<ul><i><li>#Replace(Speaker, "#chr(13)##chr(10)#", "<br><li>", "ALL")#</i></ul>
</dir>
</cfoutput>

</font>
</blockquote>
</cfmodule>

</HTML>
