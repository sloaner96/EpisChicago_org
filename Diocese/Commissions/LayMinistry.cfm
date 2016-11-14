<cfquery name="ConfNfo" datasource="#Application.DSN#">
	SELECT c.*, d.ParishName, d.Address1, d.Address2, d.City, d.State, d.ZipCode, d.WebSite From Conferences c
		LEFT OUTER JOIN Directory d ON (d.OrgID = c.OrgID)
		WHERE ConfID = 2
</cfquery>
<cfquery name="Leaders" datasource="#Application.DSN#">
	SELECT LeaderName From WSLeaders
		WHERE ConfID = 2
</cfquery>
<cfquery name="Schedule" datasource="#Application.DSN#">
	SELECT *, Str(Month(ActivityDate))+'/'+Str(Day(ActivityDate))+'/'+Str(Year(ActivityDate)) as ActDate From ConfSchedule
		WHERE ConfID = 2
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
	<cfoutput><TITLE>Chicago Diocese -- #ConfNfo.ConfName#</TITLE></cfoutput>
</head>

<cfmodule template="#Application.header#" NavAlign="Center" Banner="No">

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
<!--- <cfif WebSite neq ""><a href="#WebSite#" target="_blank">#WebSite#</a><br></cfif> --->
</small>
</font>

</p><br clear=all>
</cfoutput>

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

<cfoutput query="ConfNfo">

<font face="Verdana,Arial" size="-1">
<p><i>Sponsored by #Replace(Sponsor, "#chr(13)##chr(10)#", "<br>", "ALL")#</i></p>

<p><font color="Navy" size="+1">Keynote Speaker:</font><br>
<b>#Replace(KeyNote, "#chr(13)##chr(10)#", "<br>", "ALL")#</b>
<hr width=90% align=left size=1>
<center>
<a href="Workshops.cfm">Workshop Descriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="/Directions.cfm">Map & Parking</a><br>
<cfif Leaders.RecordCount gt 0><a href="Leaders.cfm">Meet the Leaders</a>&nbsp;&nbsp;|&nbsp;&nbsp;</cfif>
<a href="Register.cfm">Register online!</a>
</center>
</p><br>

#Replace(Introduction, "#chr(13)##chr(10)#", "<br>", "ALL")#

</cfoutput>

<br clear=all>

</font>
</blockquote>
</cfmodule>

</HTML>
