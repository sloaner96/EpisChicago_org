<cfparam name="url.catid" default="0">
<cfparam name="url.subcatid" default="0">
<cfparam name="url.recid" default="0">
<cfparam name="url.Type" default="0">
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
	<TITLE>Chicago Diocese -- Resource Directory</TITLE>
</head>
<cfmodule template="#Application.header#" PageTitle="Group Resource Directory">


<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>






<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="150" bgcolor="#f7f8da" valign="top"><cf_GrpResourceNav groupID="#URL.GROUPID#"></td>
	<td width="5">&nbsp;</td>
	<td valign="top"> 
		 <!---  <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#000099">
				<tr>
		           <td bgcolor="eeeeee">
				      <table border="0" cellpadding="0" cellspacing="0" width="100%">
		                 <cfoutput>
						   <tr>
		                      <td><a href="ResourceDetail.cfm?CatID=#GetCats.Codevalue#" style="font-family:tahoma; font-size: +1;color:000099;"><font face="tahoma" size="+1"><strong>#GetCats.CatName#</strong></font></a></td>
		                   </tr>
						   <tr>
						      <td>
						    <cfloop query="GetSubs">
							    <font face="verdana" size="-1"><a href="ResourceDetail.cfm?CatID=#GetCats.Codevalue#&SubCatID=#GetSubs.Codevalue#">#GetSubs.SubCatName#</a><cfif getsubs.currentrow NEQ Getsubs.recordcount>,</cfif></font>
							</cfloop>
						  </td>
						   </tr>
						 </cfoutput>
		               </table>
				   </td>
		        </tr>
	      </table>
		  <br> --->
		 
		  <cfquery name="GetRecs" datasource="#Application.dsn#">
		    Select R.ResourceID, R.ResourceLabel, R.ResourceType, R.ContentID, R.Category, R.SubCategory, R.ContactName, R.ContactEmail, R.ContactPhone, R.Desc, 
			  (Select Codedesc 
	             From Lookups
	             where CodeGroup = 'RECSUBCAT'
	             AND CodeValue = G.SubCatID) as SubCatName
			From Resources R, GrpResources G
			Where R.ResourceID = G.ResourceID 
			<cfif Url.CatId NEQ 0>
			AND R.Category = '#url.CatID#' 
			</cfif>
			AND G.GroupID = #GroupID#
			<cfif url.subcatID NEQ 0>
			 AND G.SubCatID = '#url.subcatid#'
			</cfif>
			<cfif url.RecID NEQ 0>
			  AND R.ResourceID = #url.RecID# 
			</cfif>
			<cfif url.type NEQ 0>
			  AND R.ResourceType = '#URL.Type#'
			</cfif>
			order By 11, R.ResourceLabel
		  </cfquery>
		  <cfif url.CatID NEQ 0>
		  <cfquery name="GetCats" datasource="#Application.dsn#">
			   Select Codevalue, Codedesc as CatName  
				   From Lookups
				   where CodeGroup = 'RECCAT'
				   
				   AND CodeValue = '#url.CatID#'
				   
				   Order By CodeDesc
			</cfquery>
			<cfquery name="GetSubs" datasource="#Application.dsn#">
				  Select L.Codevalue, L.Codedesc as SubCatName  
				  From Resources R, lookups L, GrpResources G
				  where R.ResourceID = G.ResourceID 
				  AND G.GroupID = #GroupID# 
				  AND G.subcatID = L.Codevalue
				  AND G.SubCatID = '#Url.SubCatid#'
				  AND L.CodeGroup = 'RECSUBCAT'
				 Order By CodeDesc 
			 </cfquery>
			 <cfset NRows = Round(GetCats.RecordCount / 1)>
			</cfif>
		   <table border="0" cellpadding="3" cellspacing="0" width="100%">
	         <cfoutput query="GetRecs" group="SubCatname">
			    <cfif url.CatID EQ 0>
				  <cfquery name="GetCats" datasource="#Application.dsn#">
					   Select Codevalue, Codedesc as CatName  
						   From Lookups
						   where CodeGroup = 'RECCAT'
						   
						   AND CodeValue = '#GetRecs.Category#'
						   
						   Order By CodeDesc
					</cfquery>
					<cfquery name="GetSubs" datasource="#Application.dsn#">
						  Select L.Codevalue, L.Codedesc as SubCatName  
						  From Resources R, lookups L, GrpResources G
						  where R.ResourceID = G.ResourceID 
						  AND G.GroupID = #GroupID# 
						  AND R.Category = '#Getcats.CodeValue#'
						  AND G.subcatID = L.Codevalue
						  AND L.CodeGroup = 'RECSUBCAT'
						 Order By CodeDesc 
					 </cfquery>
					</cfif>
			   <tr bgcolor="##003399">
	               <td colspan=2><font face="arial" color="ffffff" size="3"><strong>#GetCats.CatName# <cfif GetRecs.SubCatName NEQ "">: #GetRecs.SubCatName#</cfif></strong></font></td>
	           </tr>
				 <cfoutput>
				   <tr>
				     <td colspan=2><font face="arial" color="##006699" size="+1"><strong><cfif url.RecID EQ 0><a href="GroupResourcesDtl.cfm?GroupID=#GroupID#&CatID=#GetCats.Codevalue#&RecID=#GetRecs.ResourceID#">#GetRecs.ResourceLabel#</a><cfelse>#GetRecs.ResourceLabel#</cfif></strong></font></td>
				   </tr>
				   <tr>
				     <cfif url.RecID EQ 0><td width="5">&nbsp;</td></cfif>
				     <td width="98%"><font face="verdana" size="-2"><cfif url.RecID EQ 0>#SpanExcluding(GetRecs.Desc, chr(13))#<cfelse>#replacenocase(GetRecs.Desc, "#chr(13)##chr(10)#", "<br>", "All")#</cfif></font></td>
				   </tr>
				   <cfif url.RecID NEQ 0>
				      <cfif GetRecs.ResourceType EQ "S">
					  	  <cfquery name="GetResource" datasource="#Application.dsn#">
						    Select *
							From ListServs
							Where ListID = #GetRecs.ContentID#
						  </cfquery> 	
				      <cfelseif GetRecs.ResourceType NEQ "L"> 
						  <cfquery name="GetResource" datasource="#Application.dsn#">
						    Select *
							From Forms
							Where FormID = #GetRecs.ContentID#
						  </cfquery>
					    
					  <cfelse>
					  	  <cfquery name="GetResource" datasource="#Application.dsn#">
						    Select *
							From SiteLinks
							Where LinkID = #GetRecs.ContentID#
						  </cfquery>
					  </cfif>
				      <cfif GetRecs.ResourceType EQ "L">
						    <tr>
							  <td><font face="verdana" size="-1"><a href="http://#Replacelist(GetResource.SiteURL, 'http://, https://', '')#" target="_blank">#GetResource.SiteName#</a></font></td>
							</tr>
					  <cfelseif GetRecs.ResourceType EQ "S">
						    <tr>
							  <td><font face="verdana" size="-1">Mailing List: <a href="mailto:#getResource.Emailaddr#" target="_blank">#GetResource.Label#</a></font></td>
							</tr>	
					    <cfelse>
						    <tr>
							  <td><font face="verdana" size="-1"><a href="/DownloadResource.cfm?RecID=#GetResource.FormID#" target="_blank">Download the Resource</a></font></td>
							</tr>
					 </cfif>
					 <tr>
					  <td>&nbsp;</td>
					 </tr>
					  <cfif GetRecs.ContactName NEQ "" 
					        OR GetRecs.ContactEmail NEQ "" 
							OR GetRecs.ContactPhone NEQ "">
							 <tr>
							   <td colspan=2><font face="verdana" size="-1"><strong>Contact Information</strong></font></td>
							 </tr>
							  <cfif GetRecs.ContactName NEQ "">
							    <tr>
								  <td colspan=2><font face="verdana" size="-2">#GetRecs.ContactName#</font></td>
								</tr>
							  </cfif>
							  <cfif GetRecs.ContactEmail NEQ "">
							    <tr>
								  <td colspan=2><font face="verdana" size="-2"><a href="mailto:#GetRecs.ContactEmail#">#GetRecs.ContactEmail#</a></font></td>
								</tr>
							  </cfif>
							  <cfif GetRecs.ContactPhone NEQ "">
							    <tr>
								  <td colspan=2><font face="verdana" size="-2">#GetRecs.ContactPhone#</font></td>
								</tr>
							  </cfif>
					  </cfif>
				   </cfif>
				 </cfoutput>  
			 </cfoutput>
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
