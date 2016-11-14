<CF_NoCache>
<cfsetting enablecfoutputonly="Yes">

<cfif NOT IsDefined("URL.SiteID")>
	<cflocation url="index.cfm" addtoken="No">
</cfif>

<cfquery name="SiteNfo" datasource="PHosting">
	SELECT s.*, d.Denomination, d.Logo, d.NationalWeb, d.RevTitle, d.BoardName From SiteInfo s
		LEFT OUTER JOIN Denominations d ON (d.DenomID = s.Denomination)
		WHERE SiteID = #URL.SiteID# AND Active = True
</cfquery>

<cfquery name="SectionNfo" datasource="PHosting">
	SELECT * From Sections
		WHERE SiteID = #URL.SiteID# AND Section = 'HOME'
</cfquery>

<CFQUERY Name="Staff" Datasource="PHosting">
	SELECT s.*, l.CDesc From Staff s, Lookups l
		WHERE s.SiteID = #URL.SiteID#
			AND (l.CGroup = 'STAFF' AND l.CValue = s.StaffType AND (l.SiteID is NULL OR l.SiteID = #URL.SiteID#))
		ORDER BY StaffType
</CFQUERY>

<cfquery name="Vestry" datasource="PHosting">
	SELECT v.*, l.CDesc, l.RankOrder From Vestry v, Lookups l
		WHERE v.SiteID = #URL.SiteID#
			AND (l.SiteID = v.SiteID AND l.CGroup = 'BOARD' AND l.CValue = v.Position)
		ORDER BY RankOrder, LastName
</cfquery>

<cfquery name="Sched" datasource="PHosting">
	SELECT s.*, d.CDesc from Services s, qDays d
		WHERE s.SiteID = #URL.SiteID#
			AND d.CValue = s.ServiceDay
		ORDER BY ServiceDay, ServiceAP, ServiceHour, ServiceMin
</cfquery>

<cfquery name="Events" datasource="PHosting">
	SELECT TOP 4 * From Events
		WHERE SiteID = #URL.SiteID# AND Approved = True
			AND EndDate >= #CreateODBCDateTime(now())#
		ORDER BY BeginDate
</cfquery>

<cfsetting enablecfoutputonly="No">


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, apostolic, christianity, christian, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<cfoutput><TITLE>Chicago Diocese Parish -- #SiteNfo.SiteName#, #SiteNfo.City#, #SiteNfo.State#</TITLE></cfoutput>
</head>

<cfmodule template="#Application.header#" NavAlign="center" Banner="No">

<font face="Verdana,Arial" size="-1">

<cfoutput query="SiteNfo">
<a href="/"><img src="/images/Consecration/TinySeal.gif" width=35 height=51 alt="Return to Diocesan Home Page" border="0" align=right></a>
<center>
<font color="Blue" size="+3">#SiteName#</font><br>
<font color="Navy" size="+2">#City#, #State#</font>
<hr width=60% align=center size=2>
</center>
<br>

<cfif SectionNfo.ImgName neq ""><img src="http://www.parishhosting.com/images/SitePix/#NumberFormat(URL.SiteID, '000')#-#SectionNfo.ImgName#" alt="" border="#SectionNfo.ShowBorder#" align="#SectionNfo.Alignment#" hspace=20></cfif>
<p align=center>
#Address1#<br>
<cfif Address2 neq "">#Address2#<br></cfif>
#City#, #State#&nbsp;&nbsp;#ZipCode#<br><br>
Phone: #Phone#<br>
FAX: #FAX#<br>
<cfif EMail neq "">Email: <a href="mailto:#Email#">#Email#</a></cfif>
</p>
</cfoutput>

<center>
<cfif Staff.RecordCount gt 0 OR Vestry.RecordCount gt 0>
<b>Clergy and Staff</b><br>
</cfif>
<cfif Staff.RecordCount gt 0>
	<font size="-1">
	<cfoutput query="Staff">
	#Prefix# #FirstName# #MI# #LastName#<cfif Suffix neq "">, #Suffix#</cfif>, <i>#CDesc#</i><br>
	</cfoutput>
	</font>
</cfif>

<cfif Vestry.RecordCount gt 0>
	<font size="-1">
	<cfoutput query="Vestry">
	#FirstName# #LastName#, <i>#CDesc#</i><br>
	</cfoutput>
	</font>
</cfif>
</center>


<br clear=all><br>
<table width=100% border=0 cellspacing=8 cellpadding=0>
<tr valign="top" bgcolor="#FDEDD0">
	<th width=50%>Office Hours</th>
	<td align=left rowspan=6 width=50% bgcolor="#f8f8f8">
		<cfif SectionNfo.IntroText is "">
			<font face="Verdana,Arial" size="-1">
			<p><big><b>Events happening at the Parish</b></big></p>
			<cfif Events.RecordCount gt 0>
			<cfoutput query="Events">
			<p>#DateFormat(BeginDate, "mmmm d, yyyy")#<cfif DatePart("h", BeginDate) gt 0>&nbsp;&nbsp;#TimeFormat(BeginDate, "h:mm TT")#</cfif><br>
			<b>#EventName#</b><br>
			<small>#Replace(Description, "#chr(13)##chr(10)#", "<br>", "ALL")#</small></p>
			</cfoutput>
			<cfelse>No events posted.</cfif>
			</font>
		<cfelse>
			<font face="Verdana,Arial" size="-1">
			<cfoutput query="SectionNfo">
			#Replace(IntroText, "#chr(13)##chr(10)#", "<br>", "ALL")#
			</cfoutput>
			</font>
		</cfif>
	</td>
</tr>
<tr valign=top>
	<td align=left>
		<font size="-1">
		<cfoutput query="SiteNfo">
		#Replace(MissionStmt, "#chr(13)##chr(10)#", "<br>", "ALL")#
		</cfoutput>
		</font><br>&nbsp;
	</td>
</tr>

<tr valign=top bgcolor="#FDEDD0">
	<th>Worship Schedule</th>
</tr>
<tr valign=top>
	<td align=left>
		<cfoutput query="Sched" GROUP="ServiceDay">
			<table width=300 border=0 cellpadding=2 cellspacing=0>
			<tr valign=top><td bgcolor="##f0f0f0"><font face="Tahoma,Arial" size="-1"><b>#CDesc#</b></font></td></tr>
			<cfoutput>
			<tr valign=top>
				<td>
					<font color="Navy" size="-1">#ServiceHour#:#NumberFormat(ServiceMin,'00')# #ServiceAP# -- #ServiceName#</font><br>
					<font face="Arial" size="-1">
					#Replace(Description, '#chr(13)##chr(10)#', '<br>', 'ALL')#
					<cfif Music is 1><i>Choral Service.&nbsp;&nbsp;</i></cfif>
					<cfif Childcare is 1><i>Childcare is provided.</i></cfif>
					</font>
				</td>
			</tr>
			</cfoutput>
			</table>
			<br>
		</cfoutput>
	</td>
</tr>

<cfif SectionNfo.IntroText neq "">
<tr valign="top" bgcolor="#FDEDD0">
	<th>Events at the Parish</th>
</tr>	
<tr valign=top>
	<td>
		<font size="-1">
		<cfif Events.RecordCount gt 0>
		<cfoutput query="Events">
		<p>#DateFormat(BeginDate, "mmmm d, yyyy")#&nbsp;&nbsp;#TimeFormat(BeginDate, "h:mm TT")#<br>
		<b>#EventName#</b><br>
		<small>#Replace(Description, "#chr(13)##chr(10)#", "<br>", "ALL")#</small></p>
		</cfoutput>
		<cfelse>None posted.</cfif>
		</font><br>&nbsp;
	</td>
</tr>
</cfif>

</table>


</font>

</CFMODULE>
</HTML>
