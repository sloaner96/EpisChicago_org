<cfparam name="url.action" default="">
<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Subsite Admin" SubTitle="">
	<cfif url.action EQ "ADD">
	   <!--- Check Form Variables --->
	     <cfif Len(Trim(form.GroupName)) EQ 0 AND Len(Trim(form.Dept)) EQ 0>
		    <cflocation url="index.cfm?e=1"  addtoken="no">
		 <cfelseif Len(Trim(form.GroupName)) GT 0>
		     <cfquery name="CheckgroupName" datasource="#Application.dsn#">
                 Select GroupID
                 From GroupNfo
                 Where GroupName = '#Form.GroupName#'
			  </cfquery>
			  
			  <cfif CheckGroupName.recordcount GT 0>
			      <cflocation url="index.cfm?e=5"  addtoken="no">
			  </cfif>
		 <cfelseif Len(Trim(form.Dept)) GT 0>
		     <cfquery name="CheckDept" datasource="#Application.dsn#">
                 Select GroupID
                 From GroupNfo
                 Where DeptID = #Form.Dept#
			  </cfquery>
			  
			  <cfif CheckDept.recordcount GT 0>
			      <cflocation url="index.cfm?e=6"  addtoken="no">
			  </cfif>
		       
		 </cfif>
		 
		 
		 <cfif Len(Trim(form.SiteType)) EQ 0>
		    <cflocation url="index.cfm?e=2"  addtoken="no">
		 </cfif>
		 
		  <cfif Len(Trim(form.GroupPurpose)) EQ 0>
		    <cflocation url="index.cfm?e=3"  addtoken="no">
		 </cfif>
		 
		 <!--- if there is a picture, run it through CFX image and upload it --->
		 <cfif Len(Trim(form.GroupPhoto)) GT 0>
		    <cfset MaxPhotoSize = 30000>
            <cfset MaxPhotoLength = 250>
            
			<cftry>
			  <cffile action="UPLOAD" filefield="form.GroupPhoto" 
				destination="#Application.DirPath#\images\subsite\" 
				nameconflict="MAKEUNIQUE">
				
				<cfcatch type="any">
					<cflocation url="index.cfm?e=4"  addtoken="no">
				</cfcatch>
			</cftry>  
		    
			
			<!--- <CFX_IMAGE ACTION="READ" name="ImageNfo" FILE="#Application.DirPath#\images\subsite\#File.ServerFile#"> 
			   
			 <cfif ImageNfo.width gt MaxPhotoLength>
				<CFX_IMAGE 
				    ACTION="RESIZE" 
					FILE="#Application.DirPath#\images\subsite\#File.ServerFile#" 
					Output="#Application.DirPath#\images\subsite\sm_#File.ServerFile#" 
					Name="ImageReSize" 
					Quality="100" 
					Width="250"> 
					
				<cfset NewImageName = "sm_#File.ServerFile#">
			<cfelse>		
			    <cfset NewImageName = "#File.ServerFile#">
			</cfif> --->
             <cfset NewImageName = "#File.ServerFile#">
		 </cfif>
	   
	   <!--- If everything looks good, then lets add the Info to Groupnfo, and add the content types for the site --->
				  <cfif Len(Trim(Form.Dept)) GT 0>
				      <cfquery name="GetDepts" datasource="#Application.dsn#">
		                 Select *
		                 From Lookups
		                 Where CodeGroup= 'DEPTS'
		                 AND CodeID = #form.Dept#
					  </cfquery>
					  
					<cfif Len(Trim(form.GroupName)) GT 0>
			           <cfset thisGroupName = form.groupname>
			        <cfelse>
					    <cfset thisGroupName = GetDepts.CodeDesc>
					</cfif>		    
					  
				  <cfelse>
				      <cfset thisGroupName = form.groupname>	  
				  </cfif>
				  
				  <cfset TempPurpose = Trim(form.GroupPurpose)>
				  
			      <cfquery name="AddGroup" datasource="#Application.dsn#">
				     Insert Into GroupNfo(
					                       GroupName, 
						                   GroupType, 
										   Purpose, 
										   IsActive,
										   HomePageDisplay, 
										   DeptID, 
										   ImgName, 
										   ShowMembers)
					                Values(
					                       '#ThisGroupName#', 
										   '#Form.SiteType#', 
										   '#TempPurpose#', 
										   <cfif IsDefined("form.IsSiteActive")>
										     #form.IsSiteActive#,
										   <cfelse>
										     0,
										   </cfif>
										   <cfif IsDefined("form.ShowOnHomepage")>
										     #form.ShowOnHomepage#,
										   <cfelse>
										     0,
										   </cfif>
										   <cfif  Len(Trim(Form.Dept)) GT 0>
										     '#Form.Dept#',
										   <cfelse>
										     NULL,
										   </cfif>
										   <cfif Len(Trim(form.GroupPhoto)) GT 0>
										     '#NewImageName#',
										   <cfelse>
										     NULL,
										   </cfif>
										   <cfif IsDefined("form.ShowMembers")>
										     #form.ShowMembers#
										   <cfelse>
										     0
										   </cfif>)
				  </cfquery>
				  
				  <cfquery name="GetGroupID" datasource="#Application.DSN#">
				     Select GroupID
					 From GroupNfo
					 Where GroupName = '#ThisGroupName#'
					 AND GroupType = '#Form.SiteType#'
				  </cfquery>
			       
				   <cfset NewGroupID = GetGroupID.GroupID>
				   
				   <cfif IsDefined("form.ContentType")>
					   <cfif ListLen(form.ContentType) GT 0>
						 <cfloop index="i" list="#form.ContentType#" delimiters=",">
							 <cfquery name="AddGroupContent" datasource="#Application.DSN#">
								Insert Into GroupContent(GroupID, ContentCode, MenuName, RankOrder)
								Values(#NewGroupID#, '#i#', <cfif Len(Trim(Evaluate("form.ContentLabel_#i#"))) GT 0>'#Evaluate("form.ContentLabel_#i#")#'<cfelse>NULL</cfif>, #Evaluate("form.ContentRank_#i#")#)
							 </cfquery>
						 </cfloop> 
					   </cfif>
                   </cfif>
	   <!--- Once I am done lets kick them to the edit screen --->
	        <cflocation url="EditSite.cfm?GroupID=#NewGroupID#" addtoken="no">
	<cfelseif url.action EQ "UPDATE">
	    <!--- Check to make sure this GroupExists --->
		<cfquery name="GetGroup" datasource="#Application.DSN#">
		  Select *
		  From GroupNfo
		  Where GroupID = #Form.GroupID#
		</cfquery>
		
		<!--- Check Form Variables --->
		<cfif Len(Trim(form.groupID)) EQ 0>
		     <cflocation url="index.cfm" addtoken="No">
		</cfif>
		
		<cfif Len(Trim(form.GroupName)) EQ 0 AND Len(Trim(form.Dept)) EQ 0>
		    <cflocation url="EditSite.cfm?GroupID=#Form.GroupID#&e=1"  addtoken="no">
		 <cfelseif Len(Trim(form.GroupName)) GT 0>
		     <cfquery name="CheckgroupName" datasource="#Application.dsn#">
                 Select GroupID
                 From GroupNfo
                 Where GroupName = '#Form.GroupName#'
				 AND GroupID <> #Form.GroupID#
			  </cfquery>
			  
			  <cfif CheckGroupName.recordcount GT 0>
			      <cflocation url="EditSite.cfm?GroupID=#Form.GroupID#&e=5"  addtoken="no">
			  </cfif>
		 <cfelseif Len(Trim(form.Dept)) GT 0>
		     <cfquery name="CheckDept" datasource="#Application.dsn#">
                 Select GroupID
                 From GroupNfo
                 Where DeptID = #Form.Dept#
				 AND GroupID <> #Form.GroupID#
			  </cfquery>
			  
			  <cfif CheckDept.recordcount GT 0>
			      <cflocation url="EditSite.cfm?GroupID=#Form.GroupID#&e=6"  addtoken="no">
			  </cfif>
		       
		 </cfif>
		 
		 
		 <cfif Len(Trim(form.SiteType)) EQ 0>
		    <cflocation url="EditSite.cfm?GroupID=#Form.GroupID#&e=2"  addtoken="no">
		 </cfif>
		 
		  <cfif Len(Trim(form.GroupPurpose)) EQ 0>
		    <cflocation url="EditSite.cfm?GroupID=#Form.GroupID#&e=3"  addtoken="no">
		 </cfif>
	   <!--- if there is a picture, run it through CFX image and upload it Delete the old photo and add this one--->
	     <cfif Len(Trim(form.GroupPhoto)) GT 0>
		    <cfset MaxPhotoSize = 30000>
            <cfset MaxPhotoLength = 250>
            
			<cftry>
			  <cffile action="UPLOAD" filefield="form.GroupPhoto" 
				destination="#Application.DirPath#\images\subsite\" 
				nameconflict="MAKEUNIQUE">
				
				<cfcatch type="any">
					<cflocation url="index.cfm?e=4"  addtoken="no">
				</cfcatch>
			</cftry>  
		    
			
			<!--- <CFX_IMAGE ACTION="READ" name="ImageNfo" FILE="#Application.DirPath#\images\subsite\#File.ServerFile#"> 
			   
			 <cfif ImageNfo.width gt MaxPhotoLength>
				<CFX_IMAGE 
				    ACTION="RESIZE" 
					FILE="#Application.DirPath#\images\subsite\#File.ServerFile#" 
					Output="#Application.DirPath#\images\subsite\sm_#File.ServerFile#" 
					Name="ImageReSize" 
					Quality="100" 
					Width="250"> 
					
				<cfset NewImageName = "sm_#File.ServerFile#">
			<cfelse>		
			    <cfset NewImageName = "#File.ServerFile#">
			</cfif> --->
             <cfset NewImageName = "#File.ServerFile#">
		 </cfif>
	   <!--- If everything looks good, then update the Info in Groupnfo, and Change the Content for this Group --->
	      <cfif Len(Trim(Form.Dept)) GT 0>
			  <cfquery name="GetDepts" datasource="#Application.dsn#">
		          Select *
		          From Lookups
		          Where CodeGroup= 'DEPTS'
		          AND CodeID = #form.Dept#
			  </cfquery>
			
			<cfif Len(Trim(form.GroupName)) GT 0>
			   <cfset thisGroupName = form.groupname>
			<cfelse>
			   <cfset thisGroupName = GetDepts.CodeDesc>
			</cfif>
		  <cfelse>
			 <cfset thisGroupName = form.groupname>
		  </cfif>
				  
				  <cfset TempPurpose = Trim(form.GroupPurpose)>
				  
			      <cfquery name="AddGroup" datasource="#Application.dsn#">
				     Update GroupNfo
					 Set GroupName = '#ThisGroupName#', 
						 GroupType = '#Form.SiteType#', 
				         Purpose = '#TempPurpose#', 
					     <cfif IsDefined("form.IsSiteActive")>
						    IsActive = #form.IsSiteActive#,
						 <cfelse>
							IsActive = 0,
					     </cfif>
						 <cfif IsDefined("form.ShowOnHomepage")>
						   HomePageDisplay  = #form.ShowOnHomepage#,
						 <cfelse>
							HomePageDisplay  = 0,
					     </cfif>
						 <cfif  Len(Trim(Form.Dept)) GT 0>
							DeptID =     '#Form.Dept#',
						 <cfelse>
							DeptID = NULL,
						 </cfif>
						 <cfif Len(Trim(form.GroupPhoto)) GT 0>
							ImgName = '#NewImageName#',
						 <cfelse>
						    <cfif GetGroup.ImgName EQ "">
							  ImgName = NULL,
							</cfif>
						 </cfif> 
						 <cfif IsDefined("form.ShowMembers")>
							 ShowMembers = #form.ShowMembers#
						 <cfelse>
							 ShowMembers = 0
						</cfif> 
					 Where GroupID = #Form.GroupID#               
				  </cfquery>
			       
				   <cfset NewGroupID = form.groupID>
				   
				   <cfoutput>
				      <cfif IsDefined("form.ContentType")>
						   <cfif ListLen(form.ContentType) GT 0>
							 <cfquery Name="DeleteContent" datasource="#Application.dsn#">
							   Delete From GroupContent
							   Where GroupID = #Form.GroupID#
							 </cfquery>
							 <cfloop index="i" list="#form.ContentType#" delimiters=",">
								 <cfquery name="AddGroupContent" datasource="#Application.DSN#">
								   Insert Into GroupContent(GroupID, ContentCode, MenuName, RankOrder)
								   Values(#NewGroupID#, '#i#', <cfif Len(Trim(Evaluate("form.ContentLabel_#i#"))) GT 0>'#Evaluate("form.ContentLabel_#i#")#'<cfelse>NULL</cfif>, #Evaluate("form.ContentRank_#i#")#)
							     </cfquery>
							 </cfloop> 
						   </cfif>
					   </cfif>
				   </cfoutput>
				   
	   <!--- Once I am done lets kick them to the edit screen --->
	      <cflocation url="EditSite.cfm?GroupID=#form.GroupID#" addtoken="no">
	<cfelseif url.action EQ "CONFIRM">
	   <br>
	   <cfoutput>
	   <!--- Make Sure that they want to delete the group --->
	   <div align="center"><font face="arial" size="-1"><strong>ARE YOU SURE YOU WOULD LIKE TO DELETE THIS SUBSITE?</strong><br><br><a href="AddGroup.cfm?Action=Delete&GroupID=#Url.GroupID#">YES, DELETE THIS SUBSITE</a>&nbsp;&nbsp;&nbsp;<a href="EditSite.cfm?GroupID=#Url.GroupID#">NO, DO NOT DELETE THIS SUBSITE</a></font></div>
	   </cfoutput>
	<cfelseif url.action EQ "DELETE">
	   <!--- Delete the Content Type, --->
	     <cfquery name="DeleteContentType" datasource="#Application.dsn#">
		     Delete From GroupContent
			 Where GroupID = #url.groupID#
		 </cfquery>
	   
	   <!--- Delete the GroupNfo --->
	     <cfquery name="DeleteGroupNfo" datasource="#Application.dsn#">
		     Delete From GroupNfo
			 Where GroupID = #url.groupID#
		 </cfquery>
		 
	   <!--- Delete the GroupMembers --->
	     <cfquery name="DeleteGroupMembers" datasource="#Application.dsn#">
		      Delete From GrpMembers
			 Where GroupID = #url.groupID#   
		 </cfquery>
		 
		 <cflocation url="index.cfm" addtoken="no">
	<cfelse>
	   <p><font face="tahoma" color="990000" size="-1"><strong>THERE WAS AN ERROR. PLEASE CLICK HERE TO GO BACK TO THE MAIN PAGE.</strong></font>
	</cfif>
</cfmodule>