<cfset url.groupid = "32">


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


<cfset Today = now()>
<cfset NextThirty = DateAdd('d', 60, today)>

<cfquery name="GroupEvents" datasource="#Application.DSN#">
	SELECT *
	From Events
	Where ((BeginDate >= #CreateODBCDate(Today)# AND BeginDate <= #CreateodbcDate(NextThirty)#)
	OR  EndDate >= #CreateODBCDate(Today)#)
	AND OwningGroupID = #GroupID#
	Order By GrpHighlight, Begindate desc
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
	<cfoutput>
	<TITLE>Chicago Diocese -- Episcopal Charities and Community Services</TITLE>
    </cfoutput>
</head>

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#" subtitle="Frequently Asked Questions"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <cfquery name="GetFAQ" datasource="#Application.dsn#">
				  SELECT F.*, L.CodeDesc
				  FROM FAQs F, Lookups L
				  WHERE F.GroupID = #GroupID#
				  AND F.Category = L.CodeValue
				  AND L.CodeGroup = 'FAQ'
				  Order By L.CodeDesc, F.Ranking
				</cfquery>
				
				<blockquote>
				<cfif GetFAQ.recordcount GT 0>
				 <br>
				
				<table width="80%" border=0 cellspacing=0 cellpadding=0>
				<tr valign=top>
					<td>
						<font face="Verdana" size="-1">
						
						<p>This page contains a categorized list of frequently asked questions that might be helpful.</p>
						
						<cfoutput query="getfaq" group="Category">
						
							<table width="100%" border=0>
							<tr bgcolor="##eeeeee"><td width="100%"><font face="tahoma" color="Navy" size="-1"><strong>#CodeDesc#</strong></font></td></tr>
							</table>
							<cfoutput>
							<p><font face="Verdana" size="-1"><b>#Question#</b><br>#Replace(Response,"#chr(13)##chr(10)#","<br>","ALL")#</font></p>
							</cfoutput>
						
						</cfoutput>
						
						</font>
					</td>
				</tr>
				</table>
				<cfelse>
				  <div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO FAQS FOR THIS GROUP</strong></font></div> 
				</cfif>
				
				</blockquote>
		</td>
		<td width="225" valign="top" align="right">
		   <cf_esidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#" showmembers ="1">
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>