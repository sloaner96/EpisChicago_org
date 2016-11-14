<cfparam name="url.s" default="0">

<cfquery name="ActiveResources" datasource="#Application.dsn#" >
  Select R.Active, R.ResourceID, R.ResourceLabel,
    (Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.Category
	   AND CodeGroup = 'RECCAT') as CatName,
	(Select Count(*)
	  From GrpResources
	  Where ResourceID = R.ResourceID
	  AND GroupID <> #Url.GroupID#) as ExitsOtherGroups,   
	(Select CodeDesc 
	   From Lookups
	   Where CodeValue = G.SubCatID
	   AND CodeGroup = 'RECSUBCAT') as SubCatName,
	(Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.ResourceType
	   AND CodeGroup = 'RECCONTENT') as RecTypeName
  From Resources R, GrpResources G
  where G.ResourceID = R.ResourceID
  <cfif IsDefined("url.catid")>
   AND Category = '#url.Catid#'
  </cfif>
  <cfif IsDefined("url.Type")>
   AND R.ResourceType = '#url.Type#'
  </cfif>
  AND G.GroupID = #Url.GroupID#
  Order by 4, R.ResourceLabel 
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Maintain Group Resources</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  pagetitle="Maintain Group Resource">


<table border="0" cellpadding="0" cellspacing="0" width="100%">
			 <cfset RowsPerPage = 25>
			 
			 <cfset TotalRows = ActiveResources.recordcount>
			 
			 <cfparam name="url.nstart" default="1">
			 
			 <cfset EndRow = Min(url.Nstart + RowsPerPage - 1, TotalRows)>
			 
			 <cfset StartRowNext = EndRow + 1>
			 
			 <cfset StartRowback = Url.nstart - RowsPerPage>
		   <tr>
		     <td valign="top" width="150"><cf_ResourceNav groupID="#Url.groupID#"></td>
		     <td valign="top" >
			   <cfoutput>
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
					  <tr>
					    <td><font face="arial" size="-1"><a href="SearchResource.cfm?groupID=#url.GroupID#">Search for resources to add</a><br><a href="AddResource.cfm?groupID=#url.GroupID#">Add a new resource</a></font></td>
					    <td align="right"><a href="../EditSite.cfm?groupID=#url.groupid#"><font face="tahoma" size="-1">Back to Subsite Admin</font></a></td>
					  </tr>
					</table><br>
				</cfoutput>
			   <cfif ActiveResources.recordcount GT 0>
			    <table border="0" cellpadding="0" cellspacing="0" width="100%">
		           <cfoutput>
					  <tr bgcolor="ffffff">
					    <td colspan=3 align="right">
						   <table border="0" cellpadding="3" cellspacing="0" align="right">
			                  <tr>
							   <cfif startrowBack GT 0>
			                     <td align="right"><a href="index.cfm?nstart=#StartRowBack#&groupID=#url.groupid#"><font face="verdana" size="-2"><< BACK</font></a></td>
							   </cfif>
							   <cfif StartRowNext LT TotalRows>
								 <td align="right"><a href="index.cfm?nstart=#StartRowNext#&groupID=#url.groupid#"><font face="verdana" size="-2">NEXT >></font></a></td>
							   </cfif>	
			                  </tr>
			                </table>
						</td>
					  </tr> 
					  
					   <tr>
					     <td colspan=3 align="center">
					       <table border="0" cellpadding="0" cellspacing="0" width="100%">
			                 <tr>
			                   <td><font face="verdana" color="000000" size="-1">Displaying <strong>#Url.nstart#</strong> to <strong>#EndRow#</strong> of <strong>#TotalRows#</strong></font></td>
			                 </tr>
			               </table> 
					     </td>
					   </tr>
		            </cfoutput>
		        </table>
		        <table border="0" cellpadding="2" cellspacing="1" width="100%">
				  <tr bgcolor="#006699">
				    <td width="10">&nbsp;</td>
		            <td><font face="verdana" color="ffffff" size="-1"><strong>Category</strong></font></td>
					<td><font face="verdana" color="ffffff" size="-1"><strong>SubCategory</strong></font></td>
					<td><font face="verdana" color="ffffff" size="-1"><strong>Resource Type</strong></font></td>
					<td><font face="verdana" color="ffffff" size="-1"><strong>Resource Name</strong></font></td>
		          </tr>
				  <cfoutput query="ActiveResources" startrow="#url.nstart#" maxrows="#RowsPerPage#">
				    <tr>
					  <td><font face="verdana" size="-2"><a href="UpdateResource.cfm?Action=Confirm&ResID=#ActiveResources.ResourceID#&groupID=#url.groupid#" style="color:##cc0000;">[REMOVE]</a></font></td>
				      <td><font face="verdana" size="-1">#CatName#</strong></font></td>
					  <td><font face="verdana" size="-1">#SubCatName#</strong></font></td>
					  <td><font face="verdana" size="-1">#RecTypeName#</strong></font></td>
					  <td><cfif ActiveResources.ExitsOtherGroups EQ 0 OR ActiveResources.ACTIVE EQ 0><a href="EditResource.cfm?ResID=#ActiveResources.ResourceID#&groupID=#url.groupid#"><font face="verdana" size="-1">#ResourceLabel#</strong></font></a><cfelse><font face="verdana" size="-1">#ResourceLabel#</strong></font></cfif></td>
				    </tr>
				  </cfoutput>
		        </table>
			 <cfelse> <br><br>
			   <table border="0" cellpadding="0" cellspacing="0" width="100%">
                  <tr>
                    <td><font face="verdana" color="#b5b5b5" size="-1"><strong>There are currently no resources that match your criteria. Click the "Add New Resources" link above.</strong></font></td>
                  </tr>
               </table>
			 </cfif>	
		</td>
	</tr>
  </table>	
  			
</CFMODULE>
