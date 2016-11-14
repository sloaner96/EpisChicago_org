<cfparam name="url.s" default="0">

<cfquery name="ActiveResources" datasource="#Application.dsn#" >
  Select ResourceID, ResourceLabel,
    (Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.Category
	   AND CodeGroup = 'RECCAT') as CatName,
	(Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.SubCategory
	   AND CodeGroup = 'RECSUBCAT') as SubCatName,
	(Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.ResourceType
	   AND CodeGroup = 'RECCONTENT') as RecTypeName
  From Resources R
  where R.Active = True
  <cfif IsDefined("url.catid")>
   AND Category = '#url.Catid#'
  </cfif>
  Order by 3, R.ResourceLabel 
</cfquery>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Diocesan Resources Admin" SubTitle="Main Menu">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
     <td valign="top" width="150"><cf_ResourceNav></td>
	 <td valign="top">&nbsp;</td>
	 <td valign="top">
	    <table border="0" cellpadding="2" cellspacing="0" width="100%">
          <tr bgcolor="eeeeee">
             <td><font face="tahoma" size="+1"><strong>Unapproved Group Resources</strong></font></td>
          </tr>
		  <tr>
             <td><a href="ApproveResource.cfm"><font face="arial" size="-1">Click Here to Approve Group Resource</font></a></td>
          </tr>
        </table><br>
		  <cfif IsDefined("url.catid")>
		     <cfquery name="GetCat" datasource="#Application.dsn#">
			    Select CodeDesc as CatName
	            From Lookups
	            Where CodeValue = '#url.CatId#'
	            AND CodeGroup = 'RECCAT'
				Order By CodeDesc
			 </cfquery>
		     
		</cfif>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		  <cfoutput> 
		   <tr bgcolor="eeeeee">
             <td><font face="tahoma" size="+1"><strong><cfif IsDefined("url.CatID")>#GetCat.CatName#<cfelse>All Diocesan</cfif> Resources</strong></font></td>
          </tr>
		  </cfoutput>
		  <tr>
		     <td><font face="arial" size="-1">From the admin below you can maintain the resource directory.</font></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr>
		     <td><font face="arial" size="-1"><a href="AddResource.cfm">Add New Resource</a></font></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <cfif url.s EQ 1>
		     <tr>
			   <td><font face="arial" color="#009900" size="-1"><strong>You have successfully added a new resource.</strong></font></td>
			 </tr>
			 <tr>
			   <td>&nbsp;</td>
			 </tr> 	 
		   <cfelseif url.s EQ 2>
		     <tr>
			   <td><font face="arial" color="#009900" size="-1"><strong>You have successfully updated the resource.</strong></font></td>
			 </tr>
			 <tr>
			   <td>&nbsp;</td>
			 </tr> 	 
		   <cfelseif url.s EQ 3>
		     <tr>
			   <td><font face="arial" color="#990000" size="-1"><strong>You have successfully deleted the resource.</strong></font></td>
			 </tr>	
			 <tr>
			   <td>&nbsp;</td>
			 </tr> 	 
		   </cfif>  
		 
			 <cfset RowsPerPage = 25>
			 
			 <cfset TotalRows = ActiveResources.recordcount>
			 
			 <cfparam name="url.nstart" default="1">
			 
			 <cfset EndRow = Min(url.Nstart + RowsPerPage - 1, TotalRows)>
			 
			 <cfset StartRowNext = EndRow + 1>
			 
			 <cfset StartRowback = Url.nstart - RowsPerPage>
		   <tr>
		     <td>
			    <table border="0" cellpadding="0" cellspacing="0" width="100%">
		           <cfoutput>
					  <tr bgcolor="ffffff">
					    <td colspan=3 align="right">
						   <table border="0" cellpadding="3" cellspacing="0" align="right">
			                  <tr>
							   <cfif startrowBack GT 0>
			                     <td align="right"><a href="index.cfm?nstart=#StartRowBack#"><font face="verdana" size="-2"><< BACK</font></a></td>
							   </cfif>
							   <cfif StartRowNext LT TotalRows>
								 <td align="right"><a href="index.cfm?nstart=#StartRowNext#"><font face="verdana" size="-2">NEXT >></font></a></td>
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
					  <td><font face="verdana" size="-2"><a href="UpdateResource.cfm?Action=Confirm&ResID=#ActiveResources.ResourceID#" style="color:##cc0000;">[DELETE]</a></font></td>
				      <td><font face="verdana" size="-1">#CatName#</strong></font></td>
					  <td><font face="verdana" size="-1">#SubCatName#</strong></font></td>
					  <td><font face="verdana" size="-1">#RecTypeName#</strong></font></td>
					  <td><a href="EditResource.cfm?ResID=#ActiveResources.ResourceID#"><font face="verdana" size="-1">#ResourceLabel#</strong></font></a></td>
				    </tr>
				  </cfoutput>
		        </table>
			 </td>
		   </tr>
		</table>
     </td>
   </tr>
</table>
</CFMODULE>