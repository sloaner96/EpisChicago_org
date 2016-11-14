<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Maintain Group Resources</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin"  pagetitle="Maintain Group Resource" subtitle="Search for a Resource">
	  <cfif Not IsDefined("Form.Keyword")>
	     <cfform name="Search" action="SearchResource.cfm?GroupID=#Url.GroupID#" Method="POST">
		  <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <td valign="top" width="150"><cf_ResourceNav groupID="#Url.groupID#"></td>
              <td>
			     <table border="0" cellpadding="4" cellspacing="0" width="100%">
		           <tr>
		              <td><font face="arial" size="-1">Search for an existing resource to add to this group site.</font><hr noshade size="1"></td>
		           </tr>
			       <tr>
			          <td><font face="verdana" size="-1"><strong>Keywords:</strong></font> <cfinput type="text" name="Keyword" size="20" maxlength="75"><td>
			       </tr>
			        <cfquery name="GetResType" datasource="#application.dsn#">
					     Select *
						   From Lookups
						   Where CodeGroup = 'RECCONTENT'
					   </cfquery>
					   <tr>
					     <td><font face="verdana" size="-1"><strong>Resource Type:</strong></font> <select name="Type">
						       <option value="">-- Select Type --</option>
							   <cfoutput query="GetResType">   
							     <option value="#CodeValue#">#CodeDesc#</option>
							   </cfoutput>
							 </select>
						 </td>
					   </tr>
					   <cfquery name="GetCat" datasource="#application.dsn#">
					     Select *
						   From Lookups
						   Where CodeGroup = 'RECCAT'
					   </cfquery>
					   <tr>
					     <td><font face="verdana" size="-1"><strong>Category:</strong></font> <select name="CatID">
						       <option value="">-- Select Category --</option>
							   <cfoutput query="GetCat">   
							     <option value="#CodeValue#">#CodeDesc#</option>
							   </cfoutput>
							 </select>
						 </td>
					   </tr>		 
			       <tr>
			          <td>&nbsp;</td>
			       </tr>
			       <tr>
			         <td><input type="submit" name="submit" value="Search >>"></td>
			      </tr>
		         </table>	
				</td>
            </tr>
          </table>
		 </cfform>  
	  <cfelse>
	   
	
			<cfquery name="SrchResources" datasource="#Application.dsn#" >
				  Select R.ResourceID, R.ResourceLabel,
				    (Select CodeDesc 
					   From Lookups
					   Where CodeValue = R.Category
					   AND CodeGroup = 'RECCAT') as CatName,
					(Select CodeDesc 
					   From Lookups
					   Where CodeValue = R.ResourceType
					   AND CodeGroup = 'RECCONTENT') as RecTypeName
				  From Resources R
				  where (1 = 1)
				  <cfif IsDefined("form.catid")>
				    <cfif form.CatID NEQ ""> 
				       AND Category = '#form.Catid#'
				    </cfif> 
				  </cfif>
				  <cfif IsDefined("form.Type")>
				    <cfif form.Type NEQ "">
				       AND R.ResourceType = '#form.Type#'
				     </cfif>
				  </cfif>
				  <cfif ISDefined("Form.Keyword")>
				     <cfif form.Keyword NEQ "">
				       AND ResourceLabel Like '%#form.Keyword#%'
				     </cfif> 
				  </cfif>
				  Order by 3, R.ResourceLabel 
			</cfquery>
			    <table border="0" cellpadding="0" cellspacing="0" width="100%">
						 <cfset RowsPerPage = 25>
						 
						 <cfset TotalRows = SrchResources.recordcount>
						 
						 <cfparam name="url.nstart" default="1">
						 
						 <cfset EndRow = Min(url.Nstart + RowsPerPage - 1, TotalRows)>
						 
						 <cfset StartRowNext = EndRow + 1>
						 
						 <cfset StartRowback = Url.nstart - RowsPerPage>
					   <tr>
					     <td valign="top" width="150"><cf_ResourceNav groupID="#Url.groupID#"></td>
					     <td valign="top" >
						  
						       <cfoutput>
							    <table border="0" cellpadding="3" cellspacing="0" width="100%"> 
								     <tr>
								       <td><font face="arial" size="-1"><a href="SearchResource.cfm?GroupID=#Url.GroupID#">Click Here</a> to Search Again</font></td>
								     </tr> 
									 <tr>
									   <td>&nbsp;</td>
									 </tr>
									 <tr>
									   <td><font face="arial" size="-1">Your Search Returned <strong>#SrchResources.recordcount#</strong> Records</font></td>
									 </tr>
								</table><br>
							   </cfoutput> 
							   <cfif SrchResources.recordcount GT 0>
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
								<cfform name="Add" action="UpdateResource.cfm?GroupID=#Url.groupID#&Action=SearchAdd" Method="POST">
							        <table border="0" cellpadding="2" cellspacing="1" width="100%">
									  <tr bgcolor="#006699">
									    <td width="10">&nbsp;</td>
							            <td><font face="verdana" color="ffffff" size="-1"><strong>Category</strong></font></td>
										<td><font face="verdana" color="ffffff" size="-1"><strong>Resource Type</strong></font></td>
										<td><font face="verdana" color="ffffff" size="-1"><strong>Resource Name</strong></font></td>
							          </tr>
									  <cfoutput query="SrchResources" startrow="#url.nstart#" maxrows="#RowsPerPage#">
									    <tr>
										  <td width="10"><input type="Checkbox" name="ResourceID" value="#ResourceID#"></td>
									      <td><font face="verdana" size="-1">#CatName#</strong></font></td>
										  <td><font face="verdana" size="-1">#RecTypeName#</strong></font></td>
										  <td><font face="verdana" size="-1">#ResourceLabel#</strong></font></td>
									    </tr>
									  </cfoutput>
									  <tr>
									     <td colspan="4">&nbsp;</td>
									  </tr>
									  <tr>
									     <td align="center"><input type="submit"  name="submit" value="Add Resources >>"></td>
									  </tr>
							        </table>
								</cfform>
						 <cfelse> <br><br>
						   <table border="0" cellpadding="0" cellspacing="0" width="100%">
			                  <tr>
			                    <td><font face="verdana" color="#b5b5b5" size="-1"><strong>There are currently no resources that match your criteria.</strong></font></td>
			                  </tr>
			               </table>
						 </cfif>	
					</td>
				</tr>
			  </table>	
	</cfif> 			
</CFMODULE>