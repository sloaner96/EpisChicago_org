<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>


<cfquery name="GetGrpResources" datasource="#Application.dsn#">
  Select G.SubCatID, N.GroupID, N.GroupName, R.ResourceID, R.ResourceLabel, R.Category
  From GrpResources G, GroupNfo N, Resources R
  Where N.GroupID = G.GroupID 
  AND G.ResourceID = R.ResourceID
  AND R.Active = 0
  order By R.Category, R.LastUpdated Desc
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Diocesan Resources Admin" SubTitle="Edit Resource">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	   <tr>
	     <td valign="top" width="150"><cf_ResourceNav></td>
		 <td valign="top">&nbsp;</td>
		 <td valign="top">
		    <br>
			<p><font face="arial" size="-1">Use the form below to approve group resources to be shown on the Diocesan site. You can choose to re-categorize the resource and You must select a subcategory for this category.</font></p> 
			<hr noshade size=1>
			  <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="eeeeee">
	            <cfif GetGrpResources.recordCount GT 0> 
			      <tr bgcolor="#006699">
	                 <td><font face="verdana" color="ffffff" size="-1"><strong>Approve</strong></font></td>
					 <td><font face="verdana" color="ffffff" size="-1"><strong>Resource Info</strong></font></td>
					 <td><font face="verdana" color="ffffff" size="-1"><strong>Category</strong></font></td>
					 <td><font face="verdana" color="ffffff" size="-1"><strong>Sub-Category</strong></font></td>
					 
	              </tr>
				   <cfquery name="GetCat" datasource="#application.dsn#">
		             Select *
			         From Lookups
			         Where CodeGroup = 'RECCAT'
		           </cfquery>
				   <cfquery name="GetSubCat" datasource="#application.dsn#">
		             Select *
			         From Lookups
			         Where CodeGroup = 'RECSUBCAT'
		           </cfquery>
				  <cfform name="approve" action="UpdateResource.cfm?Action=Approve" method="POST">
				  <cfoutput query="GetGrpResources">
				    <cfset Thiscategory = GetGrpResources.Category>
				    <tr bgcolor="ffffff">
					  <td width=1 valign="top" align="center"><input type="checkbox" name="Resources" value="#GetGrpResources.ResourceID#"></td>
					  <td><a href="javascript:void(0);" onclick="window.open('ResourcePop.cfm?ResID=#GetGrpResources.ResourceID#', 'popupwin', 'height=350, width=415, top=200, left=250, scrollbars=yes, resizable=yes');self.name = 'main';"title="Click to view this resource"><font face="verdana" size="-1">#GetGrpResources.ResourceLabel#</font></a></td>
					  <td width="40%"><select Name="CatID_#GetGrpResources.ResourceID#">
					        <cfloop query="GetCat">
					          <option value="#GetCat.CodeValue#" <cfif Thiscategory EQ GetCat.CodeValue>Selected</cfif>>#GetCat.CodeDesc#</option>
							</cfloop>
					      </select>
					  </td>
					  <td width="40%"><select Name="SubCatID_#GetGrpResources.ResourceID#">
					        <option value="">--- Select a SubCategory ---</option>
							<cfloop query="GetSubCat">
							  <option value="#GetSubCat.CodeValue#">#GetSubCat.CodeDesc#</option>
							</cfloop>
					      </select>
					  </td>
					  
					</tr>
				  </cfoutput>
				  <tr bgcolor="ffffff">
				    <td colspan=4>&nbsp;</td>
				  </tr>
				  <tr bgcolor="ffffff">
				    <td colspan=4 align="center"><input type="reset" name="reset" value="Reset All">&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" style="color:#009900;" value="Approve >>"></td>
				  </tr>
				  </cfform>
				<cfelse>
				  <tr bgcolor="ffffff">
				    <td><font face="tahoma" color="#959595" size="+1"><strong>There are group resources to approve.</strong></font></td>
				  </tr>  
				  <tr bgcolor="ffffff">
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="ffffff">
				    <td><font face="verdana" size="-1"><strong><a href="index.cfm">Click Here</a> to go back to the resource admin homepage.</strong></font></td>
				  </tr>
	            </cfif>
			  </table>
	     </td>
	   </tr>
	</table>
</CFMODULE>