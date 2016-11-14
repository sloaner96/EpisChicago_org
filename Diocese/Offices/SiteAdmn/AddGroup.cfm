<cfparam name="url.action" default="">
<CFMODULE Template="#Application.Header#" PageTitle="Subsite Admin" SubTitle="">
	<cfif url.action EQ "UPDATE">
	    <!--- Check to make sure this GroupExists --->
		<cfquery name="GetGroup" datasource="#Application.DSN#">
		  Select *
		  From GroupNfo
		  Where GroupID = #Form.GroupID#
		</cfquery>
		
		<!--- Check Form Variables --->
		 
		  <cfif Len(Trim(form.GroupPurpose)) EQ 0>
		    <cflocation url="EditSite.cfm?GroupID=#Form.GroupID#&e=3"  addtoken="no">
		 </cfif>
	   <!--- if there is a picture, run it through CFX image and upload it Delete the old photo and add this one, 
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
		    
			
			<CFX_IMAGE ACTION="READ" name="ImageNfo" FILE="#Application.DirPath#\images\subsite\#File.ServerFile#"> 
			   
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
			</cfif> 
             <cfset NewImageName = "#File.ServerFile#">
		 </cfif>--->
	   <!--- If everything looks good, then update the Info in Groupnfo, and Change the Content for this Group --->
				  
				  <cfset TempPurpose = Trim(form.GroupPurpose)>
				  
			      <cfquery name="UpdGroup" datasource="#Application.dsn#">
				     Update GroupNfo
					 Set   
				         Purpose = '#TempPurpose#', 
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
	<cfelse>
	   <p><font face="tahoma" color="990000" size="-1"><strong>THERE WAS AN ERROR. PLEASE CLICK HERE TO GO BACK TO THE MAIN PAGE.</strong></font>
	</cfif>
</cfmodule>