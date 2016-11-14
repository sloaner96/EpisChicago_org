<cfparam name="url.groupid" type="numeric" default="0">
<cfparam name="url.GCID" type="numeric" default="0">

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

<cfquery name="GetGroupContent" datasource="#Application.DSN#">
	SELECT C.*, L.CodeDesc 
	  FROM GroupContent C, Lookups L
		WHERE C.ContentCode = L.CodeValue
		AND L.CodeGroup = 'CONTENT'
		AND C.GroupID = #groupid#
		AND ContentCode = '#URL.GCID#'
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
	<TITLE>Chicago Diocese -- #GetGroupInfo.GroupName#</TITLE>
    </cfoutput>
</head>



<cfif GetGroupContent.MenuName EQ "">
  <cfset SiteHeader = GetGroupContent.CodeDesc>
<cfelse>
   <cfset SiteHeader = GetGroupContent.MenuName>
</cfif>
<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#" subtitle="#SiteHeader#">

<cfoutput>
<table border="0" cellpadding="2" cellspacing="0" width="100%">
  <tr>
      <td valign="top">
		<cfswitch expression="#GetGroupContent.ContentCode#">
		 <cfcase value="01">
			<cfparam name="form.keyword" default="">
		 	<cfmodule template="Events.cfm" GroupID="#GetGroupInfo.GroupID#" Keywords="#Form.Keyword#" GrpContentID="#GetGroupContent.ContentCode#">
		 </cfcase>
		 <cfcase value="02">
		 	<cfmodule template="MemberRoster.cfm" GroupID="#GetGroupInfo.GroupID#" GrpContentID="#GetGroupContent.ContentCode#">
		 </cfcase>
		 <cfcase value="03">
		 	<cfmodule template="FAQS.cfm" GroupID="#GetGroupInfo.GroupID#" GrpContentID="#GetGroupContent.ContentCode#">
		 </cfcase>
		 <cfcase value="04">
			<cflocation url="GroupResourcesDtl.cfm?GroupID=#GetGroupInfo.GroupID#&Type=F" addtoken="No">
		 </cfcase>
		 <cfcase value="05">
			<cflocation url="GroupResourcesDtl.cfm?GroupID=#GetGroupInfo.GroupID#&Type=S" addtoken="No">
		 </cfcase>
		 <cfcase value="06">
			<cflocation url="GroupResourcesDtl.cfm?GroupID=#GetGroupInfo.GroupID#&Type=P" addtoken="No">
		 </cfcase>
		 <cfcase value="07">
		    <cfif IsDefined("url.PID")>
			  <cfset programID = url.PID>
			<cfelse>
			  <cfset programID = 0>   
			</cfif>
			<cfmodule template="Programs.cfm" GroupID="#GetGroupInfo.GroupID#" ProgramID="#ProgramID#" GrpContentID="#GetGroupContent.ContentCode#">
		 </cfcase>
		 <cfcase value="08">
			<cflocation url="GroupResources.cfm?GroupID=#GetGroupInfo.GroupID#"  addtoken="No">
		 </cfcase>
		 <cfcase value="09">
		    <cfparam name="Url.AlbumID" default="0">
			<cfparam name="Url.PNbr" default="1">
			<cfmodule template="PhotoAlbums.cfm" GroupID="#GetGroupInfo.GroupID#" AlbumID="#Url.AlbumID#" PNbr="#Url.PNbr#" GrpContentID="#GetGroupContent.ContentCode#">
		 </cfcase>
		 <cfcase value="10">
			<cflocation url="GroupResourcesDtl.cfm?GroupID=#GetGroupInfo.GroupID#&Type=N" addtoken="No">
		 </cfcase>
		 <cfcase value="11">
			<cfmodule template="Meetings.cfm" GroupID="#GetGroupInfo.GroupID#" GrpContentID="#GetGroupContent.ContentCode#">
		 </cfcase>
		 <cfdefaultcase>
		    <br><br>
			<cflocation url="Index.cfm?GroupID=#Url.GroupID#" addtoken="No">
		 </cfdefaultcase>
		</cfswitch>
   </td>
      <td width="225" valign="top" align="right">
		<cfmodule template="sidenav.cfm" groupID="#groupID#" navimg="#GetGroupInfo.ImgName#" GroupName="#GetGroupInfo.GroupName#" showMembers="#GetGroupInfo.ShowMembers#" groupType="#GetGroupInfo.GroupType#">  
      </td>
    </tr>
  </table>
 </cfoutput>
</cfmodule>

</HTML>
