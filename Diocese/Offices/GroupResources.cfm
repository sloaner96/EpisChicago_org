
<cfparam name="url.groupid" type="numeric" default="0">
<cfparam name="url.GCID" type="numeric" default="0">

<cfif Not IsNumeric(url.groupid)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfif Findnocase(";", url.groupid, 1)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfset groupid = url.groupid>
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Group Resource Directory</TITLE>
</head>
<cfmodule template="#Application.header#" PageTitle="Group Resource Directory">
<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>
<cfquery name="GetCats" datasource="#Application.dsn#">
   Select Codevalue, Codedesc as CatName 
	   From Lookups
	   where CodeGroup = 'RECCAT'
	   AND exists (Select Distinct R.Category From Resources R, GrpResources G where R.ResourceID = G.ResourceID AND G.GroupID = #GroupID# AND R.category = codevalue)
	   Order By CodeDesc
</cfquery>
<cfset NRows = Round(GetCats.RecordCount / 1)>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top">
	  <table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
	    <td colspan=2><font face="arial" color="#990000" size="+1"><strong>Group Resource Categories</strong></font></td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr valign=top align="center">
		 <td align=left width="50%">
			<table cellpadding=1 cellspacing=0 border=0>
				<CFOUTPUT Query="GetCats">
				   <cfquery name="GetSubs" datasource="#Application.dsn#">
				      Select Distinct R.Category, L.Codevalue, L.Codedesc as SubCatName  
					   From Resources R, lookups L, GrpResources G
					     where R.ResourceID = G.ResourceID 
						  AND G.GroupID = #GroupID# 
						  AND R.Category = '#Getcats.CodeValue#'
					      AND G.SubCatID = L.Codevalue
					      AND L.CodeGroup = 'RECSUBCAT'
					   Order By CodeDesc 
				    </cfquery>
					<tr>
						<td><a href="GroupResourcesDtl.cfm?GroupID=#GroupID#&CatID=#GetCats.Codevalue#" style="font-family:arial; font-size: 3;color:##000099;"><font face="arial" size="3"><strong>#GetCats.Catname#</strong></font></a></td>
					</tr>
	
				  <tr>
	                  <td>
					    <cfloop query="GetSubs">
						    <font face="verdana" size="-2"><a href="GroupResourcesDtl.cfm?GroupID=#GroupID#&CatID=#GetSubs.Category#&SubCatID=#GetSubs.Codevalue#">#GetSubs.SubCatName#</a><cfif getsubs.currentrow NEQ Getsubs.recordcount>,</cfif></font>
						    <cfif Getsubs.currentrow MOD(3) EQ 0><br></cfif>
						</cfloop>
					  </td>
			       </tr>
				   <tr>
				     <td>&nbsp;</td>
				   </tr>
			
				</CFOUTPUT>
		   </table>
         </td>
		</tr>
	 </table>	 
</td>
<cfoutput>
  <td width="225" valign="top" align="right">
	<cfmodule template="sidenav.cfm" groupID="#groupID#" navimg="#GetGroupInfo.ImgName#" GroupName="#GetGroupInfo.GroupName#" showMembers="#GetGroupInfo.ShowMembers#" groupType="#GetGroupInfo.GroupType#">  
  </td>
</cfoutput> 
</tr>
</table>


</cfmodule>
</HTML>
