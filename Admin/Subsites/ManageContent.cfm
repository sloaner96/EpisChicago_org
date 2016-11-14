
<cfparam name="url.groupid" type="numeric" default="0">
<cfparam name="url.Ctype" type="numeric" default="0">

<cfset groupid = url.groupid>

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>

<cfquery name="GetGroupContent" datasource="#Application.DSN#">
	 SELECT C.*, L.CodeDesc 
	  FROM GroupContent C, Lookups L
		WHERE C.ContentCode = L.CodeValue
		AND L.CodeGroup = 'CONTENT'
		AND C.GroupID = #groupid#
		AND C.ContentCode = '#URL.Ctype#'
		ORDER BY C.RankOrder
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
	<TITLE>#Application.SiteNfo.AppName#: Site Administration -- #GetGroupInfo.GroupName#</TITLE>
    </cfoutput>
</head>

<cfif GetGroupContent.MenuName EQ "">
  <cfset SiteHeader = GetGroupContent.CodeDesc>
<cfelse>
   <cfset SiteHeader = GetGroupContent.MenuName>
</cfif>
<cfmodule Template="#Application.Header#" PageTitle="#SiteHeader# Admin">
<cfoutput>
<table border="0" cellpadding="2" cellspacing="0" width="100%">
  <tr>
      <td valign="top">
		<cfswitch expression="#GetGroupContent.ContentCode#">
		 <cfcase value="01">
		 	<cflocation url="events/EventSearch.cfm?GroupID=#GetGroupInfo.GroupID#" addtoken="No">
		 </cfcase>	
		 <cfcase value="02">
		 	<cflocation url="Rosters/index.cfm?GroupID=#GetGroupInfo.GroupID#" addtoken="No">
		 </cfcase>
		 <cfcase value="03">
		 	<cflocation url="FAQs/index.cfm?GroupID=#GetGroupInfo.GroupID#" addtoken="No">
		 </cfcase>
		 <cfcase value="04">
			<cflocation url="Resources/index.cfm?GroupID=#GetGroupInfo.GroupID#&Type=F" addtoken="No">
		 </cfcase>
		 <cfcase value="05">
			<cflocation url="Resources/index.cfm?GroupID=#GetGroupInfo.GroupID#&Type=S" addtoken="No">
		 </cfcase>
		 <cfcase value="06">
			<cflocation url="Resources/index.cfm?GroupID=#GetGroupInfo.GroupID#&Type=P" addtoken="No">
		 </cfcase>
		 <cfcase value="07">
			<cflocation url="programs/index.cfm?GroupID=#GetGroupInfo.GroupID#" addtoken="No">
		 </cfcase>
		 <cfcase value="08">
			<cflocation url="Resources/index.cfm?GroupID=#GetGroupInfo.GroupID#" addtoken="No">
		 </cfcase>
		 <cfcase value="09">
		    <cfparam name="Url.AlbumID" default="0">
			<cfparam name="Url.PNbr" default="1">
			<cflocation url="albums/index.cfm?GroupID=#GetGroupInfo.GroupID#">
		 </cfcase>
		 <cfcase value="10">
			<cflocation url="Resources/index.cfm?GroupID=#GetGroupInfo.GroupID#&Type=N" addtoken="No">
		 </cfcase>
		 <cfcase value="11">
			<cflocation url="Meetings.cfm?GroupID=#GetGroupInfo.GroupID#" addtoken="No">
		 </cfcase>
		 <cfdefaultcase>
		    <br><br>
			<cflocation url="index.cfm?GroupID=#Url.GroupID#" addtoken="No">
		 </cfdefaultcase>
		</cfswitch>
   </td>
    </tr>
  </table>
 </cfoutput>
</cfmodule>

</HTML>

