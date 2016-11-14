			 
			<cfparam name="url.action" default="">
<cfparam name="Error" default="">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
		
		
<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Diocesan Resources Admin" SubTitle="Main Menu">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
     <td valign="top">
		<cfif url.action EQ "Add">
		   <!--- Error Checking --->
		      <cfif Len(Trim(form.RecLabel)) EQ 0>
			    <cflocation url="AddResource.cfm?E=1&GroupID=#Form.GroupID#" addtoken="No">
			  </cfif>
			  
			  <cfif Len(Trim(form.ResType)) EQ 0>
			    <cflocation url="AddResource.cfm?E=2&GroupID=#Form.GroupID#" addtoken="No">
			  </cfif>
			  
			  <cfif Len(Trim(form.CatiD)) EQ 0>
			    <cflocation url="AddResource.cfm?E=3&GroupID=#Form.GroupID#" addtoken="No">
			  </cfif>
		
			  
			  <cfif form.ResType EQ "L" >
			     <cfif Len(Trim(form.RecLinkLabel)) EQ 0>
			        <cflocation url="AddResource.cfm?E=4&GroupID=#Form.GroupID#" addtoken="No">
			     </cfif>
				 <cfif Len(Trim(form.RecLink)) EQ 0>
			        <cflocation url="AddResource.cfm?E=4&GroupID=#Form.GroupID#" addtoken="No">
			     </cfif>
				 
			  <cfelseif form.ResType EQ "S">
			      <cfif Len(Trim(form.RecEmailLabel)) EQ 0>
			        <cflocation url="AddResource.cfm?E=5&GroupID=#Form.GroupID#" addtoken="No">
			     </cfif>
				 <cfif Len(Trim(form.RecEmail)) EQ 0>
			        <cflocation url="AddResource.cfm?E=5&GroupID=#Form.GroupID#" addtoken="No">
			     </cfif>
			  </cfif>
		   <cfif Error EQ "">	 
		          <!--- Set Temp Variables --->
				  <cfset TempLabel = Trim(Form.RecLabel)>
				  <cfset TempDesc = Trim(form.ResDesc)> 
				  
			   <!--- Insert  Resource Into Correct Table--->
			      <cfif form.ResType EQ "L" >
				     <cfquery name="InsertLink" datasource="#application.dsn#">
				       Insert Into SiteLinks(
					          SiteName,
							  SiteURL,
							  Description,
							  Category
							  )
						Values (
						      '#form.RecLinkLabel#',
							  '#form.RecLink#',
							  <cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
							  #form.CatID#
								)	  
				     </cfquery>
					 
					 <cfquery name="GetID" datasource="#Application.DSN#">
					   Select LinkID
					   From SiteLinks
					   Where SiteName = '#form.RecLinkLabel#'
					   AND Category = #form.CatID#
					 </cfquery>
					 
					  <cfset ThisContentID = GetID.LinkID>
								 
		       <cfelseif form.ResType EQ "S">
				     <cfquery name="InsertListServ" datasource="#application.dsn#">
				        Insert Into ListServs (
						      EmailAddr,
							  Active,
							  Label,
							  LastUpdated
						       )
						Values (
						       '#form.RecEmail#',
							   1,
						       '#form.RecEmailLabel#',
							   #CreateODBCDateTime(now())#
						       )
				      </cfquery>
					  
					  <cfquery name="GetID" datasource="#Application.DSN#">
					   Select ListID
					   From ListServs
					   Where EmailAddr = '#form.RecEmail#'
					   AND Label = '#form.RecEmailLabel#'
					 </cfquery>
					 
					  <cfset ThisContentID = GetID.ListID>		  
				  <cfelse>
				     <!--- Upload any Files --->
					  <cfif len(form.RecFile) GT 0>
					     <cfset Location = "#Application.DirPath#\Forms\Resources\">
				          
						  <cffile action="UPLOAD"
				             filefield="Form.RecFile"
				             destination="#Location#"
				             nameconflict="MakeUnique">
							 
						<cfset ThisFile = "/Resources/#file.serverfile#"> 
					 <cfelse>
					   <cfset ThisFile = "">	
					   <cflocation url="AddResource.cfm?E=6&GroupID=#Form.GroupID#" addtoken="No">
					 </cfif>
	 
					 <cfif ThisFile NEQ "">
					     <cfquery name="InsertForm" datasource="#application.dsn#">
					        Insert Into Forms(
							      Active, 
								  FormName,
								  FormDesc,
								  FormType,
								  FileType,
								  FileName,
								  LastUpdated,
								  UpdatedBy
								  )
							  Values(
							      1,
								  '#Left(TempLabel, 100)#',
								  <cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
								  '#form.ResType#',
								  '#Right(ThisFile, 3)#',
								  '#ThisFile#',
								   #CreateODBCDateTime(now())#,
								   #Session.Userid#
								  )	  
					      </cfquery>  
						  
						  <cfquery name="GetID" datasource="#Application.dsn#">
						    Select Max(FormID) as ThisFormID
							From Forms
						  </cfquery>
						  
						  <cfset ThisContentID = GetID.ThisFormID>
					  <cfelse>
					     	  
					  </cfif>
				  </cfif>  
				  
	
			   <!--- Insert Resource Master Record --->
		   	     <cfquery name="InsResource" datasource="#application.dsn#">
			       Insert Into Resources (
				        ResourceLabel,
						ResourceType,
						[Desc],
						ContentID,
						Category,
						ContactName,
						ContactEmail,
						ContactPhone,
						AddedBy,
						LastUpdated)
					Values (
					    '#TempLabel#',
						'#form.ResType#',
						<cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
						#ThisContentID#,
						'#form.CatID#',
						<cfif IsDefined("form.ContactName")><cfif form.ContactName NEQ "">'#form.ContactName#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
						<cfif IsDefined("form.ContactEmail")><cfif form.ContactEmail NEQ "">'#form.ContactEmail#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
						<cfif IsDefined("form.ContactPhone")><cfif form.ContactPhone NEQ "">'#form.ContactPhone#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
						#Session.UserID#,
						#CreateodbcDateTime(now())#)	
			     </cfquery>
			     
				 <cfquery name="GetResource" datasource="#Application.dsn#">
				   Select ResourceID
				   From Resources
				   Where ResourceLabel = '#TempLabel#'
				   AND Category = '#form.CatID#'
				   AND ContentID = #ThisContentID#
				 </cfquery> 
				 
				 <cfquery name="INsGroupResource" datasource="#Application.dsn#">
				   Insert Into GrpResources (GroupID, ResourceID, SubCatID, Highlight)
				   Values(#form.GroupID#, #GetResource.ResourceID#, <cfif IsDefined("form.SubCatID")><cfif form.SubCatID NEQ "">'#form.SubCatID#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,<cfif IsDefined("form.Highlight")>1<cfelse>0</cfif>)
				 </cfquery>
				 
			   <!--- Kick back to homepage --->
			     <cflocation url="index.cfm?s=1&GroupID=#Form.GroupID#" addtoken="No">
		   <cfelse>
		      <tr>
			    <td><font face="arial" size="-1"><strong>There was an Error while trying to add this resource. Please correct the error and resubmit the form.</strong></font></td>
			  </tr>
			  <tr>
			    <td><font face="arial" size="-1"><a href="" onclick="history.back();">Click here</a> to go back and correct this resource.</font></td>
			  </tr>
		   </cfif>	 
	<cfelseif url.action EQ "SearchAdd">
		   <cfif ListLen(Form.ResourceID) GT 0>
		      <cfloop List="#form.ResourceID#" delimiters="," index="i">
			     <cfquery name="AddResource" datasource="#Application.dsn#">
				    Insert Into GrpResources (GroupID,ResourceID)
					Values(#url.GroupID#, #i#)
				 </cfquery> 
			  </cfloop>
		   </cfif>
		   <cflocation url="index.cfm?GroupID=#url.GroupID#" addtoken="No">
	<cfelseif url.action EQ "Update">
		
		     
			 <!--- Error Checking --->
		      <cfif Len(Trim(form.RecLabel)) EQ 0>
			    <cflocation url="EditResource.cfm?E=1&ResID=#Form.ResourceID#&GroupID=#Form.GroupID#" addtoken="No">
			  </cfif>
			  
			  <cfif Len(Trim(form.ResType)) EQ 0>
			    <cflocation url="EditResource.cfm?E=2&ResID=#Form.ResourceID#&GroupID=#Form.GroupID#" addtoken="No">
			  </cfif>
			  
			  <cfif Len(Trim(form.CatiD)) EQ 0>
			    <cflocation url="EditResource.cfm?E=3&ResID=#Form.ResourceID#&GroupID=#Form.GroupID#" addtoken="No">
			  </cfif>
		
			  
			  <cfif form.ResType EQ "L" >
			     <cfif Len(Trim(form.RecLinkLabel)) EQ 0>
			        <cflocation url="EditResource.cfm?E=4&ResID=#Form.ResourceID#&GroupID=#Form.GroupID#" addtoken="No">
			     </cfif>
				 <cfif Len(Trim(form.RecLink)) EQ 0>
			        <cflocation url="EditResource.cfm?E=4&ResID=#Form.ResourceID#&GroupID=#Form.GroupID#" addtoken="No">
			     </cfif>
				 
			  <cfelseif form.ResType EQ "S">
			      <cfif Len(Trim(form.RecemailLabel)) EQ 0>
			        <cflocation url="EditResource.cfm?E=5&ResID=#Form.ResourceID#" addtoken="No">
			     </cfif>
				 <cfif Len(Trim(form.RecEmail)) EQ 0>
			        <cflocation url="EditResource.cfm?E=5&ResID=#Form.ResourceID#" addtoken="No">
			     </cfif>
			  </cfif>
			  <cfif IsDefined("Form.ResourceID")>
				  <!--- Get Resource --->
					  <cfquery name="GetResource" datasource="#Application.dsn#">
					    Select *
						From Resources
						Where ResourceID = #Form.ResourceID#
					  </cfquery>
					   
					  <cfset ThisResourceID = GetResource.ResourceID>
					  <cfset ThisContentID = GetResource.ContentID>
			  <cfelse>
			    	<cflocation url="index.cfm?E=1" addtoken="No">	  
			  </cfif>
			   
		          <!--- Set Temp Variables --->
				  <cfset TempLabel = Trim(Form.RecLabel)>
				  <cfset TempDesc = Trim(form.ResDesc)> 
				  
			   <!--- Insert  Resource Into Correct Table--->
			      <cfif form.ResType EQ "L" >
				     <cfquery name="InsertLink" datasource="#application.dsn#">
				        Update SiteLinks
					         Set  SiteName = '#form.RecLinkLabel#',
							  	  SiteURL = '#form.RecLink#',
							      Description = <cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
							      Category = #form.CatID#
						Where LinkID = #ThisContentID#
				     </cfquery>
					  <cfquery name="GetID" datasource="#Application.DSN#">
					   Select LinkID
					   From SiteLinks
					   Where SiteName = '#form.RecLinkLabel#'
					   AND Category = #form.CatID#
					 </cfquery>
					 
					  <cfset NewContentID = GetID.LinkID>
		          <cfelseif form.ResType EQ "S">
				     <cfquery name="InsertListServ" datasource="#application.dsn#">
				        Update ListServs
						  Set EmailAddr = '#form.RecEmail#',
							  Active = True,
							  Label = '#form.RecEmailLabel#',
							  LastUpdated = #CreateODBCDateTime(now())#
						  Where ListID = #ThisContentID#	  
				      </cfquery>
					  <cfquery name="GetID" datasource="#Application.DSN#">
					   Select ListID
					   From ListServs
					   Where EmailAddr = '#form.RecEmail#'
					   AND Label = '#form.RecEmailLabel#'
					 </cfquery>
					 
					  <cfset NewContentID = GetID.ListID>			  
				  <cfelse>
				     <!--- Upload any Files --->
					  <cfif len(form.RecFile) GT 0>
					     <cfset Location = "#Application.DirPath#\Forms\Resources\">
				          
						  <cffile action="UPLOAD"
				             filefield="Form.RecFile"
				             destination="#Location#"
				             nameconflict="MakeUnique">
							 
						<cfset ThisFile = "/Resources/#file.serverfile#"> 
					 <cfelse>
					   <cfset ThisFile = "">	
					 </cfif>
	 
					     <cfquery name="InsertForm" datasource="#application.dsn#">
					        Update Forms
							    Set Active = True,
								    FormName ='#Left(TempLabel, 100)#',
								    FormDesc =<cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
								  	FormType ='#form.ResType#',
								  	FileType ='#Right(ThisFile, 3)#',
								  	<cfif ThisFile NEQ "">FileName = '#ThisFile#',</cfif>
								  	LastUpdated = #CreateODBCDateTime(now())#,
								  	UpdatedBy = #Session.Userid# 
							 Where FormID = #GetResource.ContentID#		
					      </cfquery>  
						 
						  
						  <cfset NewContentID = ThisContentID>
		
				  </cfif>  
				  
	
			   <!--- Insert Resource Master Record --->
		   	     <cfquery name="UpdResource" datasource="#application.dsn#">
			       Update Resources 
				       Set  ResourceLabel = '#TempLabel#',
							ResourceType = '#form.ResType#',
							<cfif TempDesc NEQ "">[Desc] = '#TempDesc#',</cfif>
							ContentID = #NewContentID#,
							Category = '#form.CatID#',
							SubCategory =<cfif IsDefined("form.SubCatID")><cfif form.SubCatID NEQ "">'#form.SubCatID#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
							Active =<cfif IsDefined("form.IsActive")>#form.IsActive#<cfelse>0</cfif>,
							ContactName = <cfif IsDefined("form.ContactName")><cfif form.ContactName NEQ "">'#form.ContactName#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
							ContactEmail = <cfif IsDefined("form.ContactEmail")><cfif form.ContactEmail NEQ "">'#form.ContactEmail#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
							ContactPhone = <cfif IsDefined("form.ContactPhone")><cfif form.ContactPhone NEQ "">'#form.ContactPhone#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
							AddedBy = #Session.UserID#,
							LastUpdated = #CreateodbcDateTime(now())#	
						Where ResourceID = #Form.ResourceID#	
			     </cfquery>
			     
				 <cfquery name="InsGroupRes" datasource="#application.dsn#">
			       Update GrpResources 
				       Set SubCatID = <cfif IsDefined("form.SubCatID")><cfif form.SubCatID NEQ "">'#form.SubCatID#'<cfelse>NULL</cfif><cfelse>NULL</cfif>,
			               Highlight = <cfif IsDefined("form.Highlight")><cfif form.highlight NEQ "">1<cfelse>0</cfif><cfelse>0</cfif>  
				   Where ResourceID = #Form.ResourceID#	
				   AND GroupID = #Form.GroupID#
			     </cfquery> 
			   <!--- Kick back to homepage --->
			     <cflocation url="index.cfm?s=2&GroupID=#Form.GroupID#" addtoken="No">
		
		
		<cfelseif url.action EQ "Confirm">
		  <tr>
		    <td align="center"><font face="arial" color="#003399" size="+1"><strong>Are you sure you would like to remove this Resource?</strong></font></td>
		  </tr>
		  <tr><td>&nbsp;</td></tr> 
		  <cfoutput>
			  <tr>
			    <td align="center"><font face="arial" size="+1"><a href="UpdateResource.cfm?action=Delete&ResID=#url.ResID#&GroupID=#GroupID#" style="color:##009900;">YES</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="index.cfm" style="color:##cc0000;">NO</a></font></td>
			  </tr>
		  </cfoutput>
		<cfelseif url.action EQ "Delete">
		  <cfquery name="Delete" datasource="#Application.dsn#">
		    Delete From GrpResources
			Where GroupID = #url.GroupID#
			AND ResourceID = #URL.ResID#
		  </cfquery>
		  
		  <cflocation url="index.cfm?s=3&GroupID=#URL.GroupID#" addtoken="No">
		<cfelseif url.action EQ "Approve">
		   <cfif IsDefined("form.Resources")>
		      <cfif listLen(form.Resources) GT 0>
			     <cfloop index="i" list="#Form.Resources#" delimiters=",">
				     <cfquery name="ApproveResource" Datasource="#Application.dsn#">
					    Update Resources
						Set Active = True,
						    Category = '#Evaluate("CatID_#i#")#' ,
							SubCategory = '#Evaluate("SubCatID_#i#")#' 
						Where ResourceID = #i#	
					 </cfquery>
				 </cfloop>
				 <cflocation url="ApproveResources.cfm?S=1" addtoken="No">
			  <cfelse>
			    <cflocation url="ApproveResources.cfm?e=1" addtoken="No">	 
			  </cfif>
		   <cfelse>
		      <cflocation url="ApproveResources.cfm?e=1" addtoken="No">
		   </cfif>
		<cfelse>
		  <tr>
		    <td align="center"><strong><font face="arial" color="#cc0000" size="+1">THERE WAS A PROBLEM WHILE ATTEMPTING TO WRITE THE RECORD.<BR><BR><a href="index.cfm">CLICK HERE</a> TO GO TO THE MAIN PAGE</font></strong></td>
		  </tr>
		</cfif>
     </td>
   </tr>
</table>
</CFMODULE>