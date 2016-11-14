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
<cfmodule template="#Application.header#" PageTitle="Resource Directory">
<cfparam name="url.catid" default="0">
<cfparam name="url.subcatid" default="0">
<cfparam name="url.recid" default="0">

<!--- <cfquery name="GetCats" datasource="#Application.dsn#">
   Select Codevalue, Codedesc as CatName  
	   From Lookups
	   where CodeGroup = 'RECCAT'
	   AND CodeValue = '#url.CatID#'
	   Order By CodeDesc
</cfquery> --->

<!--- <cfquery name="GetSubs" datasource="#Application.dsn#">
  Select L.Codevalue, L.Codedesc as SubCatName  
  From Resources R, lookups L
  where R.Category = <cfif url.subcatid EQ 0>'#Getcats.CodeValue#'<cfelse>'#url.subcatid#'</cfif>
  AND R.subcategory = L.Codevalue
  AND L.CodeGroup = 'RECSUBCAT'
  Order By CodeDesc 
</cfquery> --->

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td width="168" bgcolor="#c8e1e6" valign="top"><cf_ResourceNav></td>
	<td width="5">&nbsp;</td>
	<td valign="top"> 
		  <cfquery name="GetRecs" datasource="#Application.dsn#">
		    Select R.ResourceID, R.ResourceLabel, R.ResourceType, R.ContentID, R.Category,R.SubCategory, R.ContactName, R.ContactEmail, R.ContactPhone, R.Desc, 
			  (Select Codedesc 
	             From Lookups
	             where CodeGroup = 'RECCAT'
	             AND CodeValue = R.Category) as CatName,
			  (Select Codedesc 
	             From Lookups
	             where CodeGroup = 'RECSUBCAT'
	             AND CodeValue = R.SubCategory) as SubCatName
			From Resources R
			Where R.Active = True
			<cfif url.RecID NEQ 0>
			AND ResourceID = #url.RecID# 
			<cfelse>
			  AND R.Category = '#url.CatID#'
				<cfif url.subcatID NEQ 0>
				 AND R.SubCategory = '#url.subcatid#'
				</cfif>
			</cfif>
			order By 11, R.ResourceLabel
		  </cfquery>
		   <cfif GetRecs.recordcount GT 0>
		   <table border="0" cellpadding="3" cellspacing="0" width="100%">
	         <cfoutput query="GetRecs" group="SubCategory">
			   <tr bgcolor="##008080">
	               <td colspan=2><font face="arial" color="ffffff" size="3"><strong>#GetRecs.CatName# <cfif GetRecs.SubCatName NEQ "">: #GetRecs.SubCatName#</cfif></strong></font></td>
	           </tr>
				 <cfoutput>
				   <tr>
				     <td colspan=2><font face="arial" color="##006699" size="+1"><strong><cfif url.RecID EQ 0><a href="ResourceDetail.cfm?CatID=#GetRecs.Category#&RecID=#GetRecs.ResourceID#">#GetRecs.ResourceLabel#</a><cfelse>#GetRecs.ResourceLabel#</cfif></strong></font></td>
				   </tr>
				   <tr>
				     <cfif url.RecID EQ 0><td width="5">&nbsp;</td></cfif>
				     <td width="98%"><font face="verdana" size="-2">#SpanExcluding(GetRecs.Desc, chr(13))#</font></td>
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
							  <td><font face="verdana" size="-1">Click to go to <a href="http://#Replacelist(GetResource.SiteURL, 'http://, https://', '')#" target="_blank">#GetResource.SiteName#</a></font></td>
							</tr>
					  <cfelseif GetRecs.ResourceType EQ "S">
						    <tr>
							  <td><font face="verdana" size="-1">Mailing List: <a href="mailto:#getResource.Emailaddr#" target="_blank">#GetResource.Label#</a></font></td>
							</tr>	
					    <cfelse>
						    <tr>
							  <td><font face="verdana" size="-1"><a href="DownloadResource.cfm?RecID=#GetResource.FormID#" target="_blank">Download the Resource</a></font></td>
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
		 <cfelse>
		   <table border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
               <td><font face="verdana" size="-1"><strong>There are currently no resources for that category.</strong></font></td>
             </tr>
           </table>
		 </cfif>  
	</td>
  </tr>
</table>

</cfmodule>
</HTML>
