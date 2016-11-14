
<CFMODULE Template="#Application.Header#" pagetitle="Manage Site Content" >

<cfif action EQ "Add">
	   
	   <!--- Form Validation --->
	   <cfif Not IsDefined("Form.Section") OR Len(trim(form.section)) EQ 0>
	      <cflocation url="sitecontent.cfm?e=1" addtoken="No">
	   </cfif> 
	   
	   <cfif Len(trim(form.Phead)) EQ 0>
	      <cflocation url="sitecontent.cfm?e=2" addtoken="No">
	   </cfif>
	   
	   <cfif Len(trim(form.Ptext)) EQ 0>
	      <cflocation url="sitecontent.cfm?e=3" addtoken="No">
	   </cfif>
	   
	   	<cfquery name="GetContent" datasource="#Application.dsn#">
		   Select Max(Ranking) as TopRanking
		   From Pagetext P
		   where P.PSection = '#form.section#'
		</cfquery>
		
	   <cfif form.pranking EQ 0>
	     <cfset form.pranking = GetContent.TopRanking + 1>
	   </cfif>
	   
	   
	   
	   <cfset temptext = trim(form.ptext)>
	   
	   <cfquery name="InsertContent" datasource="#Application.DSN#">
	     Insert Into PageText(PSection, Heading, InfoText, Ranking, ImgName, LastUpdated, UpdatedBy)
		 Values('#Form.Section#', '#trim(form.pHead)#', '#temptext#', #form.pranking#, Null, #CreateODBCDateTime(now())#, #Session.UserID#)
	   </cfquery>
	   
	   <cflocation url="SiteContent.cfm?s=1&Section=#form.section#" addtoken="No">
<cfelseif Action EQ "Update">
    <!--- Form Validation --->
	   <cfif Not IsDefined("Form.Section") OR Len(trim(form.section)) EQ 0>
	      <cflocation url="sitecontent.cfm?e=1" addtoken="No">
	   </cfif> 
	   
	   <cfif Len(trim(form.Phead)) EQ 0>
	      <cflocation url="EditContent.cfm?e=1&RecID=#form.RecordID#" addtoken="No">
	   </cfif>
	   
	   <cfif Len(trim(form.Ptext)) EQ 0>
	      <cflocation url="EditContent.cfm?e=2&RecID=#form.RecordID#" addtoken="No">
	   </cfif>
	   
	   <cfquery name="GetContent" datasource="#Application.dsn#">
		   Select Max(Ranking) as TopRanking
		   From Pagetext P
		   where P.PSection = '#form.section#'
		</cfquery>
		
	   <cfif form.pranking EQ 0>
	     <cfset form.pranking = GetContent.TopRanking + 1>
	   </cfif>
	   
	   <!--- Deal with The Rank Changing --->
	   
	      <!--- Check to see if this items rank changed --->
	         <cfquery name="CheckRank" datasource="#Application.DSN#">
		        Select *
			    From PageText
			    Where RecID = #Form.RecordID#
		     </cfquery>
		   
		  <!--- If this items rank changed, get the rank that this item is changing to, set the 
		        old rank and update both this item and the item with the new rank ---> 
		     <cfif CheckRank.Ranking NEQ form.pranking>
		         <cfset OldRank =  checkRank.Ranking>
				 <cfset NewRank =  form.pranking>
				 
				 <cfquery name="GetOldRank" datasource="#Application.DSN#">
		            Select *
			        From PageText
			        Where PSection = #form.Section#
					and Ranking = #NewRank#
		         </cfquery>
				 
				  <cfquery name="UpdateThisItem" datasource="#Application.DSN#">
		            Update PageText
					set Ranking = #NewRank#
			        Where RecID = #form.RecordID#
		          </cfquery>
				  
				  <cfquery name="UpdateExistingItem" datasource="#Application.DSN#">
		            Update PageText
					set Ranking = #OldRank#
			        Where RecID = #GetOldRank.RecID#
		          </cfquery>
		    
		     </cfif>
		  
	   <!--- Set the Text to a variable ---> 
	   <cfset temptext = trim(form.ptext)>
	   
	   <!--- Update the Site Content --->
	   <cfquery name="updateContent" datasource="#Application.dsn#">
	     Update PageText
		 Set PSection = #form.Section#,
		     Heading = '#trim(form.pHead)#',
			 InfoText = '#temptext#',
			 LastUpdated = #CreateODBCDateTime(now())#,
			 UpdatedBy = #Session.UserID# 
		 Where RecID = #Form.RecordID#
	   </cfquery>
	   
	   <!--- Kick us back to the Main page --->
	   <cflocation url="SiteContent.cfm?s=2&Section=#form.section#" addtoken="No">
<cfelseif Action EQ "Confirm">
	<cfoutput>
	  <div align="Center" class="normalText">
	   <font face="arial" size="-1">
	   Are you sure you would like to <strong>Delete</strong> this Paragraph??<br><br>
	   <strong><a href="SiteContent_Update.cfm?Action=Delete&RecID=#Url.RecID#">YES</a>&nbsp;&nbsp;&nbsp;<a href="SiteContent.cfm">NO</a></strong>
	  </font>
	  </div>  
	  <br><br></cfoutput>
<cfelseif Action EQ "Delete">
	     <cfquery name="DeleteContent" datasource="#Application.dsn#">
	       Delete From PageText
		   Where RecID = #url.RecID#
	     </cfquery>
		 
	     <cflocation url="SiteContent.cfm?s=3" addtoken="No">
<cfelseif action EQ "AddPhoto">
      	<cfquery name="GetContent" datasource="#Application.dsn#">
		   Select Max(Ranking) as TopRanking
		   From Pagetext P
		   where P.PSection = '#form.section#'
		</cfquery>
	  <!--- Upload the image and either update the top paragraph or Add it to this Paragraph--->
	   <cfif Len(trim(form.FileContents)) GT 0>
	     <cffile action="UPLOAD" 
		         filefield="form.FileContents" 
				 destination="#Application.DirPath#\Images\" 
				 nameconflict="MAKEUNIQUE">
		   
		     <cfset formname = File.ServerFile>	  
			 
			 <cfif GetContent.recordcount GT 0>
				   <cfquery name="UpdatePic" datasource="#Application.DSN#">
				     Update PageText 
					 Set ImgName = '#Formname#'
					 Where PSection = '#Form.Section#'
					 AND Ranking = 1
				   </cfquery>
				    <cflocation url="SiteContent.cfm?s=4&Section=#form.section#" addtoken="No">
			 <cfelse>
			   <cflocation url="SiteContent.cfm?e=5" addtoken="No">  
			 </cfif>
	   <cfelse>
	     <cflocation url="SiteContent.cfm?e=4" addtoken="No">
	   </cfif>   
<cfelseif action EQ "DeletePhoto">
   <cfquery name="GetPic" datasource="#Application.DSN#">
	  Select *
	  From PageText
	  Where PSection = '#Form.Section#'
	  AND Ranking = 1
   </cfquery>
   
   <cfif FileExists(#Application.DirPath#\Images\#getpic.ImgName#)>
      <cffile action="DELETE" file="#Application.DirPath#\Images\#getpic.ImgName#">
   </cfif>
     <cflocation url="SiteContent.cfm?s=2&Section=#form.section#" addtoken="No">
<cfelseif action EQ "UpdatePhoto">
       	<cfquery name="GetContent" datasource="#Application.dsn#">
		   Select *
		   From Pagetext P
		   AND ImgName IS NOT NULL
		   AND Ranking = 1
		   where P.PSection = '#form.section#'
		</cfquery>
	    <!--- Upload the image and either update the top paragraph or Add it to this Paragraph--->
	   <cfif Len(trim(form.FileContents)) GT 0>
	     <cffile action="UPLOAD" 
		         filefield="form.FileContents" 
				 destination="#Application.DirPath#\Images\#form.filecontents#" 
				 nameconflict="MAKEUNIQUE">
		 
		     <cfset formname = File.ServerFile>	 
			  
			 <cfif FileExists(#Application.DirPath#\Images\#getpic.ImgName#)>
                <cffile action="DELETE" file="#Application.DirPath#\Images\#getContent.ImgName#">
             </cfif>
			 
			 <cfif GetContent.recordcount GT 0>
				   <cfquery name="UpdatePic" datasource="#Application.DSN#">
				     Update PageText 
					 Set ImgName = '#Formname#'
					 Where PSection = '#Form.Section#'
					 AND Ranking = True
				   </cfquery>
				    <cflocation url="SiteContent.cfm?s=4&Section=#form.section#" addtoken="No">
			 <cfelse>
			   <cflocation url="SiteContent.cfm?e=5" addtoken="No">  
			 </cfif>
	   <cfelse>
	     <cflocation url="SiteContent.cfm?e=4" addtoken="No">
	   </cfif>    
</cfif>
</cfmodule>