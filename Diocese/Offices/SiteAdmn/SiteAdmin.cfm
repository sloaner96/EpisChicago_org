<cfif Not IsDefined("session.subuserID")>
  <cflocation url="index.cfm?GroupID=#url.groupID#">
</cfif>

<cfquery name="GetMySites" datasource="#Application.dsn#">
  Select G.*, L.*
  From GrpMembers M, GroupNfo G, Lookups L
  Where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE'
  AND G.GroupID = M.GroupID 
  AND M.MemberID = #Session.subUserID#
  AND M.IsAdmin = True
  order By G.GroupType, G.GroupName
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
	<TITLE>Chicago Diocese -- Subsite Admin</TITLE>
    </cfoutput>
</head>

<cfmodule template="#application.header#" PageTitle="SubSite Admin"> 
<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td><font face="arial" size="-1">Welcome, <strong>#Session.subUserFullname#</strong></font></td>
	<td align="right"><font face="verdana" size="-1"><a href="logout.cfm">[Logout]</a></font></td>
  </tr>
</table>

</cfoutput><br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td><font face="arial" size="-1">The subsites that you can currently administer are listed below, click the name to make changes to these sites.</font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <cfoutput query="GetMySites" group="GroupType">
   <tr>
      <td><h3><font face="tahoma" color="##000080">#CodeDesc#</font></h3></td>
   </tr>
   <cfoutput>
     <tr>
	   <td><font face="verdana" size="-1"><a href="EditSite.cfm?GroupID=#GroupID#">#GroupName#</a></font></td>
	 </tr>
   </cfoutput>
   <tr><td>&nbsp;</td></tr>
  </cfoutput>
</table>

</cfmodule>

</HTML>
