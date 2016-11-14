<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Resource Directory</TITLE>
</head>
<cfquery name="GetResourceGroup" datasource="#Application.dsn#">
  Select G.*, R.*,
    (Select Codedesc
	   From Lookups
	   where CodeValue = R.SubCategory
	   AND CodeGroup = 'RECSUBCAT') as SubCategory,
	(Select CodeDesc
	  From Lookups
	   Where CodeGroup = 'RECCONTENT' 
	   AND CodeValue = R.ResourceType) as ResType,   
    (Select Codedesc
	   From Lookups
	   where CodeValue = R.Category
	   AND CodeGroup = 'RECCAT') as CatName   
  From ResourceGrouping G, ResourceGroupingContent C, Resources R
  Where G.RgroupID = C.RGroupID
  AND C.ResourceID = R.ResourceID
  AND R.Active = true
  AND G.RgroupID = #url.RGID#
  Order By R.Category, R.SubCategory, R.ResourceLabel
</cfquery>

<cfmodule template="#Application.header#" PageTitle="Resource Directory" subtitle="#GetResourceGroup.Title#">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
      <td width="168" bgcolor="#c8e1e6" valign="top"><cf_ResourceNav></td>
	  <td width="5">&nbsp;</td>
	  <td valign="top">
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<!---   <tr>
		     <td colspan=2><font face="arial" size="-1">Placeholder text. Explain what this is</font></td>
		  </tr> --->
		  <tr>
		    <td>&nbsp;</td>
		  </tr>
		  <cfoutput Query="GetResourceGroup" group="Catname">
		    <tr>
		       <td colspan=2><font face="arial" color="##990000" size="+1"><strong>#CatName#</strong></font></td>
		    </tr>
				<cfoutput>
				  <tr>
				    <td width="2%">&nbsp;</td>
					<td>
					  <table border="0" cellpadding="0" cellspacing="0" width="100%">
			              <cfif GetResourceGroup.ResourceType EQ "L" > 
								  <cfquery name="GetResource" datasource="#Application.dsn#">
								    Select *
									From SiteLinks
									Where LinkID = #GetResourceGroup.ContentID#
								  </cfquery>
							<cfelseif GetResourceGroup.ResourceType EQ "S">
							    <cfquery name="GetResource" datasource="#Application.dsn#">
								    Select *
									From ListServs
									Where ListID = #GetResourceGroup.ContentID#
								  </cfquery>
							<cfelse>
							  	  <cfquery name="GetResource" datasource="#Application.dsn#">
								    Select *
									From Forms
									Where FormID = #GetResourceGroup.ContentID#
								  </cfquery>
							</cfif>
							  <tr>
							    <td><font face="arial" color="##006699" size="+1"><strong>#GetResourceGroup.ResourceLabel#</strong></font></td>
							  </tr>
							  <tr>
							    <td><font face="verdana" size="-1">#replacenocase(GetResourceGroup.Desc, "#chr(13)##chr(10)#", "<br>", "ALL")#</font></td>
							  </tr> 
							  <cfif GetResourceGroup.ResourceType EQ "L">
							    <tr>
								  <td><font face="verdana" size="-1"><a href="http://#Replacelist(getresource.SiteURL, 'http://, https://', '')#" target="_blank">#GetResource.SiteName#</a></font></td>
								</tr>
							  <cfelseif GetResourceGroup.ResourceType EQ "S">
							    <tr>
								  <td><font face="verdana" size="-1"><a href="mailto:#getResource.Emailaddr#" target="_blank">#GetResource.Label#</a></font></td>
								</tr>	
							  <cfelse>
							    <tr>
								  <td><font face="verdana" size="-1"><a href="DownloadResource.cfm?RecID=#GetResource.FormID#" target="_blank">Download the #GetResourceGroup.ResType#</a></font></td>
								</tr>
							  </cfif>
							  <cfif GetResourceGroup.ContactName NEQ "" 
							        OR GetResourceGroup.ContactEmail NEQ "" 
									OR GetResourceGroup.ContactPhone NEQ "">
									 <tr>
									   <td>&nbsp;</td>
									 </tr>
									 <tr>
									   <td><font face="verdana" size="-2"><strong>Contact Information</strong></font></td>
									 </tr>
									  <cfif GetResourceGroup.ContactName NEQ "">
									    <tr>
										  <td><font face="verdana" size="-2">#GetResourceGroup.ContactName#</font></td>
										</tr>
									  </cfif>
									  <cfif GetResourceGroup.ContactEmail NEQ "">
									    <tr>
										  <td><font face="verdana" size="-2"><a href="mailto:#GetResourceGroup.ContactEmail#">#GetResourceGroup.ContactEmail#</a></font></td>
										</tr>
									  </cfif>
									  <cfif GetResourceGroup.ContactPhone NEQ "">
									    <tr>
										  <td><font face="verdana" size="-2">#GetResourceGroup.ContactPhone#</font></td>
										</tr>
									  </cfif>
							  </cfif> 
			          </table>
					</td>
				  </tr>
				  <tr>
				    <td><img src="/images/blank.gif" height="10" width="1" border="0" alt=""></td>
				  </tr>
				</cfoutput>
				<tr>
				  <td>&nbsp;</td>
				</tr>
		  </cfoutput>
		</table>
     </td>
   </tr>
</table>
</cfmodule>

</HTML>