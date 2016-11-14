<cfset url.groupid = "31">
<cfparam name="url.b" default="0">

<cfif Not IsNumeric(url.groupid)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfif Findnocase(";", url.groupid, 1)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfset groupid = url.groupid>

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>

<cfquery name="Visits" datasource="#Application.DSN#">
	SELECT v.*, d.ParishName, d.City, d.WebSite From Visitations v, Directory d, Bishops b
		WHERE v.VisitDate >= #CreateODBCDate(now())#
			AND d.OrgID = v.OrgID
			AND b.BishopID = v.BishopID
			<cfif Url.B NEQ 0>
			 AND B.BishopID = #url.B#
			</cfif>
		ORDER BY VisitDate, v.BishopID
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
	<TITLE>Chicago Diocese -- Episcopal Visitation Schedule</TITLE>
</head>


<cfmodule template="#Application.header#" pagetitle="Episcopal Visitation Schedule"
          subtitle='For church addresses and phone numbers see <a href="/Diocese/Directory.cfm">church directory</a>'>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td valign="top">
			<table border=0 cellspacing=4 cellpadding=1>
			<tr valign="bottom" bgcolor="#E6E6E6">
				<th width=100 align=left><font face="Verdana,Arial" size="-1">Visitation Date</i></b></font></th>
				<cfif Url.b EQ 0>
				<th width=250 align=left><font face="Verdana,Arial" size="-1">Bishop William D. Persell</font></th>
				<th width=250 align=left><font face="Verdana,Arial" size="-1">Bishop Victor Scantlebury</font></th>
				<cfelseif url.b EQ 1>
				 <th width=250 align=left><font face="Verdana,Arial" size="-1">Bishop William D. Persell</font></th>
				<cfelseif url.b EQ 2>
				 <th width=250 align=left><font face="Verdana,Arial" size="-1">Bishop Victor Scantlebury</font></th>
				</cfif>
				
			</tr>
			
			<cfoutput query="Visits" group="VisitDate">
			<cfif url.B EQ 0>
				<cfset BIDCOL = 1>
				<tr valign="top">
					<td align="center" valign=center bgcolor="##E3EAFD"><font face="Verdana,Arial" size="-1">#DateFormat(VisitDate, "mmm d, yyyy")#</font></td>
					<cfoutput>
					<cfif BishopID gt BIDCOL><td>&nbsp;</td></cfif>
					<td align=left><font face="Verdana,Arial" size="-1"><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse><a href="/Diocese/DirDirectory.cfm###City#">#ParishName#</a></cfif><br><i>#City#</i></font></td>
					<cfset BIDCOL = BIDCOL + 1>
					</cfoutput>
					<cfif BishopID lt BIDCOL><td>&nbsp;</td></cfif>
				</tr>
			<cfelse>
			   <tr valign="top">
					<td align="center" valign=center bgcolor="##E3EAFD"><font face="Verdana,Arial" size="-1">#DateFormat(VisitDate, "mmm d, yyyy")#</font></td>
					<td align=left><font face="Verdana,Arial" size="-1"><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse><a href="/Diocese/DirDirectory.cfm###City#">#ParishName#</a></cfif><br><i></i></font></td>
				</tr>
			</cfif>
			</cfoutput>
			</table>
		
		</td>
		<td width="225" valign="top" align="right">
		   <cf_bsidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#" b="#url.b#">
		</td>
	</tr>
</table>
</CFMODULE>
</HTML>
