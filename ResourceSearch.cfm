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
<cfquery name="GetRes" datasource="#Application.dsn#">
  Select R.ResourceID,
      (Select Codedesc
	    From Lookups
	    where CodeValue = R.Category
	    AND CodeGroup = 'RECCAT') as CatName,
	  (Select Codedesc
	    From Lookups
	    where CodeValue = R.SubCategory
	    AND CodeGroup = 'RECSUBCAT') as SubCategory,
   ResourceLabel, ResourceType, Desc, ContentID, Category, ContactName, ContactEmail, ContactPhone
  From Resources R
  Where (R.Active = True
  AND (R.ResourceLabel Like '%#form.search#%' 
       OR Desc Like '%#form.search#%' 
	   OR ContactName Like '%#form.search#%'))
  order by 	Category, 2, ResourceLabel   
</cfquery>
<cfmodule template="#Application.header#" PageTitle="Resource Directory" subtitle="Search Results">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
      <td width="168" bgcolor="#c8e1e6" valign="top"><cf_ResourceNav></td>
	  <td width="5">&nbsp;</td>
	  <td valign="top">
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
		  <tr>
		     <td colspan=2><font face="arial" size="-1">Below are your search relults. Click the resource name to view more detailed information about this resource.</font></td>
		  </tr>
		  <tr>
		    <td colspan=2><hr noshade size=1></td>
		  </tr>
		  <cfoutput>
		  <tr>
		    <td colspan=2><font face="verdana" size="-1">Your search returned <font color="cc0000"><strong>#GetRes.recordcount#</strong></font> results for <strong>#form.search#</strong> </font></td>
		  </tr>
		  </cfoutput>
		  <tr>
		    <td>&nbsp;</td>
		  </tr>
		  <cfif GetRes.recordcount GT 0>
			  <cfoutput Query="GetRes" group="CatName">
			    <tr>
			       <td colspan=2><font face="arial" color="##990000" size="+1"><strong><cfif Catname NEQ "">#CatName#<cfelse>No Category Assigned</cfif></strong></font></td>
			    </tr>
					<cfoutput>
					  <tr>
					    <td width="2%">&nbsp;</td>
						<td>
						  <table border="0" cellpadding="0" cellspacing="0" width="100%">
				             <cfif GetRes.ContentID NEQ "">
							  <!--- <cfif GetRes.ResourceType EQ "S">
							  	  <cfquery name="GetResource" datasource="#Application.dsn#">
								    Select *
									From ListServs
									Where ListID = #GetRes.ContentID#
								  </cfquery> 	
						      <cfelseif GetRes.ResourceType EQ "L"> 
								  
							    <cfquery name="GetResource" datasource="#Application.dsn#">
								    Select *
									From SiteLinks
									Where LinkID = #GetRes.ContentID#
								  </cfquery>
							  <cfelse>
							  	  <cfquery name="GetResource" datasource="#Application.dsn#">
								    Select *
									From Forms
									Where FormID = #GetRes.ContentID#
								  </cfquery>
							  </cfif> --->
							  
								  <tr>
								    <td><font face="verdana" size="-1"><a href="ResourceDetail.cfm?CatID=#GetRes.Category#&RecID=#Getres.ResourceID#">#GetRes.ResourceLabel#</a></font></td>
								  </tr>
								  <!--- <tr>
								    <td><font face="verdana" size="-1">#SpanExcluding(GetRes.Desc, Chr(10))#</font></td>
								  </tr> 
								  <cfif GetRes.ResourceType EQ "L">
								   <tr>
									  <td><font face="verdana" size="-1">Click to go to <a href="#GetResource.SiteURL#" target="_blank">#GetResource.SiteName#</a></font></td>
									</tr>
								    
								  <cfelseif GetRes.ResourceType EQ "S">
								    <tr>
									  <td><font face="verdana" size="-1">Mailing List: <a href="mailto:#getResource.Emailaddr#" target="_blank">#GetResource.Label#</a></font></td>
									</tr>		
								  <cfelse>
								    <tr>
									  <td><font face="verdana" size="-1"><a href="DownloadResource.cfm?RecID=#GetResource.FormID#" target="_blank">Download the Resource</a></font></td>
									</tr>
								  </cfif> --->
							  </cfif>  
				          </table>
						</td>
					  </tr>
					  <tr>
					    <td><img src="/images/blank.gif" height="8" width="1" border="0" alt=""></td>
					  </tr>
					</cfoutput>
					
					<tr>
					  <td>&nbsp;</td>
					</tr>
			  </cfoutput>
		  </cfif>
		</table>
     </td>
   </tr>
</table>
</cfmodule>

</HTML>