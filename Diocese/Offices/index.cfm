<cfparam name="url.groupid" type="numeric" default="0">


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
<cfset NextThirty = DateAdd('d', 90, today)>

<cfquery name="GroupEvents" datasource="#Application.DSN#">
	SELECT *
	From Events
	Where OwningGroupID = #GroupID#
	AND BeginDate >= #CreateODBCDate(Today)# 
	AND BeginDate <= #CreateodbcDate(NextThirty)#
	Order By Begindate, GrpHighlight
</cfquery>

<cfquery name="GroupPrograms" datasource="#Application.DSN#">
	SELECT P.*
	From GrpPrograms G, Programs P
	Where G.ProgramID = P.ProgramID
	AND G.GroupID = #groupID#
	AND G.Highlight = true 
	AND P.Approved = true
	AND P.EndDate >= #Createodbcdatetime(now())#
	Order by P.BeginDate, P.EndDate, P.Title
</cfquery>

<cfquery name="GroupResources" datasource="#Application.DSN#">
	SELECT G.SubCatID, 
	  (Select Codedesc 
	     From Lookups
	     where CodeGroup = 'RECCAT'
	     AND CodeValue = R.Category) as CatName,
	  (Select Codedesc 
	     From Lookups
	     where CodeGroup = 'RECSUBCAT'
	     AND CodeValue = G.SubCatID) as SubCatName,
	   R.*
	From GrpResources G, Resources R
	Where G.ResourceID = R.ResourceID
	AND G.GroupID = #GroupID#
	AND G.Highlight = True
	Order By 2, 3, R.ResourceLabel
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

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <table border="0" cellpadding="2" cellspacing="0" width="100%">
			<cfoutput>
			 <tr>
			   <td colspan=2><font face="verdana" size="-1">#replacenocase(GetGroupInfo.Purpose, "#chr(13)#", "<br>", "All")#</font></td>
			 </tr>
			 </cfoutput>
			 <tr>
			   <td colspan=2>&nbsp;</td>
			 </tr>
			 <cfif groupEvents.recordcount GT 0>
				 <tr>
				   <td>
				     <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                   <tr>
				         <td width=72><img src="/images/eventsheader.gif" width="63" height="19" border=0></td>
				         <td width="90%" background="/images/eventsheaderBG.gif"></td>
				       </tr> 
	                 </table>
				   </td>
				 </tr>
				 <tr>
				   <td>&nbsp;</td>
				 </tr>
				 <cfoutput query="GroupEvents" group="BeginDate">
				   <tr>
				     <td><font face="arial" color="##000099" size="3"><strong>#DateFormat(BeginDate, "mmm d, yyyy")#<cfif EndDate is not "" AND DateCompare(BeginDate, EndDate, "d") neq 0> - #DateFormat(EndDate, "mmm d, yyyy")#</cfif></strong></font></td>
				   </tr>
				   <cfoutput>
					  <tr>
					    <td><font face="verdana" size="-1">
			                 <b><cfif Description is not ""><a href="ListEvents.cfm?EventID=#EventID#&GroupID=#groupID#">#EventName#</a><cfelse>#EventName#</cfif></b><br>  
			                 <cfif Description is not ""><font face="verdana" size="-2">#SpanExcluding(Description, "#chr(13)#")#</font><br><br></cfif>
							 <cfif Location is not ""><strong>Location:</strong> #Location#<br>  </cfif>
			                 <cfif DatePart("h", BeginDate) gt 0><strong>Time:</strong> #TimeFormat(BeginDate, 'hh:mm tt')#.  <br></cfif>
			                 <cfif Contact is not ""><strong>Contact:</strong> <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif><br></cfif>
			                 <cfif URL is not ""><strong>Web: </strong><a href="#URL#">#URL#</a><br></cfif></font>
						</td>
					  </tr>
					  <tr>
					    <td><img Src="/images/blank.gif" width="1" height="15" border="0"></td>
					  </tr>
				  </cfoutput>
				   <tr>
				     <td>&nbsp;</td>
				   </tr>
				 </cfoutput>
			</cfif> 
			<cfif GroupPrograms.recordcount GT 0> 
				 <tr>
				   <td>
				     <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                   <tr>
				         <td width=72><img src="/images/upcomingheader.gif" border=0></td>
				         <td width="90%" background="/images/eventsheaderBG.gif"></td>
				       </tr> 
	                 </table>
				   </td>
				 </tr>
				 <tr>
				   <td>&nbsp;</td>
				 </tr>
				 <cfoutput query="GroupPrograms">
		          <tr>
				    <td><font face="arial" size="+1"><a href="SiteContent.cfm?GroupID=#GroupID#&GCID=07&PID=#GroupPrograms.ProgramID#">#Title#</a></font>&nbsp;&nbsp;&nbsp;&nbsp;<font face="arial" size="-1"><strong>#DateFormat(GroupPrograms.BeginDate, 'DDDD,  MMM DD, YYYY')# - #DateFormat(GroupPrograms.EndDate, 'DDDD, MMM DD, YYYY')#</strong></font> </td>
				  </tr>
				  <tr>
				    <td><font face="verdana" size="-2">#ShortDesc#</font></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
			     </cfoutput>
			</cfif> 
			<cfif groupResources.recordcount GT 0> 
				 <tr>
				   <td>
				     <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                   <tr>
				         <td width=72><img src="/images/resourceheader.gif" border=0></td>
				         <td width="90%" background="/images/eventsheaderBG.gif"></td>
				       </tr> 
	                 </table>
				   </td>
				 </tr>
				 <tr>
				   <td>&nbsp;</td>
				 </tr>
				 <cfoutput query="GroupResources" group="CatName">
			   <tr>
	               <td><font face="arial" color="##993300" size="3"><strong>#GroupResources.CatName#</strong></font></td>
	           </tr>
				 <cfoutput>
				   <tr>
				     <td><font face="verdana" size="-1"><strong><a href="GroupResourcesDtl.cfm?GroupID=#GroupID#&CatID=#GroupResources.Category#<cfif GroupResources.SubCatID NEQ "">&SubCatID=#GroupResources.SubCatID#</cfif>&RecID=#GroupResources.ResourceID#">#GroupResources.ResourceLabel#</a></strong></font></td>
				   </tr>
				 </cfoutput>  
			 </cfoutput>
			</cfif> 
		   </table>
		</td>
		<td width="225" valign="top" align="right">
		 <cfoutput>
		    <cfmodule template="sidenav.cfm" showadmin="1" groupID="#groupID#" navimg="#GetGroupInfo.ImgName#" GroupName="#GetGroupInfo.GroupName#" showMembers="#GetGroupInfo.ShowMembers#" groupType="#GetGroupInfo.GroupType#">  
		 </cfoutput>
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>