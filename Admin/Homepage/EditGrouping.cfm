<cfparam name="url.e" default="0">
<cfparam name="url.RGID" default="0">

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<cfquery name="GetGrouping" datasource="#Application.DSN#">
	Select G.*,
	  (Select Count(*)
	    From ResourceGroupingContent
		Where  RGroupID = G.RgroupID) as ResourceCount
	From ResourceGrouping G
	Where RgroupID = #url.RGID#
	Order By G.Active, G.DisplayonSite, G.Ranking
</cfquery>

<cfquery name="GetCat" datasource="#application.dsn#">
    Select *
    From Lookups
    Where CodeGroup = 'RECCAT'
</cfquery>

<cfquery name="GetAssignedRes" datasource="#Application.dsn#">
  Select R.ResourceLabel, C.ResourceID, C.RGroupID
  From Resources R, ResourceGroupingContent C
  Where C.ResourceID = R.ResourceID
  AND C.RGroupID = #Url.RGID#
  Order BY R.ResourceLabel
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Administer Homepage" SubTitle="Add New Resource Grouping">

<center>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
   <tr>
     <td></td>
	 <td align="right"><a href="GroupResources.cfm"><font face="verdana" size="-2">Back to Resource Grouping Admin</font></a></td>
   </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td><font face="arial" size="-1">You may use this page to add, edit, or remove resources from this grouping.</font></td>
  </tr>
</table><br>
<cfif url.e EQ 1>
<p><font face="arial" color="#cc0000" size="-1"><strong>Error! You must Enter a Resource Title to Continue</strong></font></p>
<br>
</cfif>
<cfoutput>
	<table border="0" cellpadding="5" cellspacing="0" width="100%">
	  <form name="" action="UpdateGrouping.cfm?Action=Activation&RGID=#URL.RGID#" Method="POST">
	  <cfif GetGrouping.Active EQ 0>
	   <tr>
	      <td><input type="submit" name="Active" value="Activate Resource Grouping" style="color:green;"></td>
	   </tr>
	  <cfelse>
	   <tr>
	      <td><input type="submit" name="InActive" value="InActivate Resource Grouping" style="color:red;"></td>
	   </tr>
	  </cfif>
	  </form> 
	  <tr>
	     <td><font face="verdana" size="-1"><strong>Resource Title:</strong> #GetGrouping.Title#</font></td>
	  </tr>
	 
	  <tr>
	    <td><hr noshade size=1></td>
	  </tr>
	  <tr>
	    <td><font face="verdana" color="##003399" size="-1"><strong>Search For Resources</strong></font></td>
	  </tr>
	  <tr>
	     <td><font face="arial" size="-1">Use the form below to search for resources to add to this grouping.</font></td>
	  </tr>
	  <tr>
	    <td>
		   <cfform name="search" action="EditGrouping.cfm?RGID=#url.RGID#" method="POST">
		   <table border="0" cellpadding="4" cellspacing="0">
	          <tr>
	             <td><font face="verdana" size="-1"><strong>Title:</strong></font></td>
				 <td><input type="text" name="ResTitle" size="25" maxlength="40"></td>
	          </tr>
	          <tr>
	             <td><font face="verdana" size="-1"><strong>Category:</strong></font></td>
		         <td><select Name="Cat">
				       <option value="">-- Select a Category --</option>
					   <cfloop query="GetCat">
					    <option value="#CodeValue#">#CodeDesc#</option>
					   </cfloop>
					 </select>
				 </td>
	          </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td colspan=2><input type="submit" name="submit" value="Search >>"></td>
			  </tr>
		   </table>
		   </cfform> 
		   </cfoutput>
		   <cfif IsDefined("Form.ResTitle") OR IsDefined("Form.Cat")>
		     <cfquery name="FindRes" datasource="#Application.dsn#">
			    Select ResourceID, ResourceLabel, ResourceType, Category,
				   (Select CodeDesc
				      From Lookups
					  Where CodeValue = R.Category
					  AND CodeGroup = 'RECCAT') as CatName
				From Resources R
				Where Active = True
				<cfif IsDefined("Form.ResTitle") GT 0>
				 <cfif Len(Trim(Form.ResTitle))>
				   AND ResourceLabel Like '%#form.ResTitle#%'
				 </cfif> 
				</cfif> 
				<cfif IsDefined("Form.Cat")>
				 <cfif Len(Trim(Form.Cat)) GT 0>
				   AND Category = '#form.Cat#'
				 </cfif> 
				</cfif> 
				<cfif GetAssignedRes.recordcount GT 0>
				  AND ResourceID NOT IN (#GetAssignedRes.ResourceID#)
				</cfif>
				Order By ResourceLabel, ResourceType
			 </cfquery>
			 <table border="0" cellpadding="4" cellspacing="0" width="100%">
	
			 <cfif FindRes.RecordCount GT 0>
			   <cfoutput>
				   <tr>
		             <td colspan=3><font face="arial" size="-1">Your search returned <strong>#FindRes.Recordcount#</strong> matches. Please check the resources you would like to add to this grouping.</font>	 </td>
		           </tr> 
				    <tr bgcolor="eeeeee">
					  <td></td>
					  <td><font face="arial" size="-1"><strong>Category</strong></font></td>
					  <td><font face="arial" size="-1"><strong>ResourceLabel</strong></font></td>
					</tr>
					<cfform name="Add" action="UpdateGrouping.cfm?Action=Add&Rgid=#Url.Rgid#" Method="POST">
					    <cfloop query="FindRes">
					     <tr>
						   <td width="1"><input type="checkbox" name="Resource" value="#FindRes.ResourceID#"></td>
						   <td width="20%"><font face="verdana" size="-2">#FindRes.CatName#</font></td>
					       <td width="89%"><font face="arial" size="-1"><a href="javascript:void(0);" onclick="window.open('ResourcePop.cfm?ResID=#FindRes.ResourceID#', 'popupwin', 'height=350, width=415, top=200, left=250, scrollbars=yes, resizable=yes');self.name = 'main';"title="Click to view this resource">#FindRes.ResourceLabel#</a></font></td>
					     </tr>
						</cfloop>
						<tr>
						  <td colspan=3 align="center"><input type="submit" value="submit" name="Add Resource >>"></td>
						</tr>
				  	</cfform>
			   </cfoutput>
			 <cfelse>
			   <tr>
	             <td><font face="arial" size="-1">Your search returned <strong>0</strong> matches. Please Refine your search above and try again.</font>	 </td>
	           </tr>
			 </cfif>
		
	         </table>
		   </cfif>
		</td>
	  </tr>
	</table>
<hr noshade size=1>
	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	   <tr>
	     <td colspan=2><font face="arial" color="#003399" size="-1"><strong>ADDED RESOURCES</strong></font></td>
	   </tr>
	   <cfif GetGrouping.ResourceCount GT 0>
	     
		 <cfoutput query="GetAssignedRes">
		 <tr>
		   <td width="10"><a href="UpdateGrouping.cfm?Action=REMOVE&RGID=#url.Rgid#&ResID=#GetAssignedRes.ResourceID#"><font face="verdana" color="##cc0000" size="-2">[REMOVE]</font></a></td>
		   <td><a href="javascript:void(0);" onclick="window.open('ResourcePop.cfm?ResID=#GetAssignedRes.ResourceID#', 'popupwin', 'height=350, width=415, top=200, left=250, scrollbars=yes, resizable=yes');self.name = 'main';"title="Click to view this resource"><font face="arial" size="-1">#GetAssignedRes.ResourceLabel#</font></a></td>
		 </tr>
		 </cfoutput>
		 <cfelse>
		  <tr>
		    <td>&nbsp;</td>
		  </tr>
		  <tr>
		    <td><font face="arial" color="#bcbcbc" size="-1"><strong>THERE ARE CURRENTLY NO RESOURCES ASSIGNED TO THIS GROUP</strong></font></td>
		  </tr>
	   	</cfif>	
	</table>
</center>

</CFMODULE>

</HTML>