<cfparam name="url.action" default="">

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Goals" SubTitle="Main Menu">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top" align="center">

      <cfif url.action EQ "ADD">
	     <!--- Error Handling --->
		 <cfif Len(trim(form.Goalnbr)) EQ 0>
		   <cflocation url="AddGoal.cfm?E=1" addtoken="No"> 
		 </cfif>
		 
		 <cfif Len(trim(form.Fyear)) EQ 0>
		   <cflocation url="AddGoal.cfm?E=2" addtoken="No"> 
		 </cfif>
		 
		 <cfif Len(trim(form.Label)) EQ 0>
		   <cflocation url="AddGoal.cfm?E=3" addtoken="No"> 
		 </cfif>
		 
		 
		 <!--- Set Temp Variables --->
		 <cfset TempLabel = Trim(Form.Label)>
		 <cfset TempDesc = Trim(Form.Desc)>
		 <!--- Add Record --->
		 <cfquery name="AddGoal" datasource="#Application.dsn#">
		   Insert Into Goals (
		   			GoalNbr, 
					FYear,
					Active,
					Label,
					Description, 
					LastUpdated)
		    Values (
		            #Form.GoalNbr#,
					#Form.fyear#,
					<cfif IsDefined("Form.Isactive")>1<cfelse>0</cfif>,
					'#TempLabel#',
					<cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
					#CreateODBCDateTime(now())#
				  )					 
		 </cfquery>
		 
		 <!--- Kick back to main page --->
		  <cflocation url="Goals.cfm?s=2" addtoken="No"> 
	  <cfelseif url.action EQ "Update">
	  <!--- Error Handling --->
		 <cfif Len(trim(form.Goalnbr)) EQ 0>
		   <cflocation url="EditGoal.cfm?GoalID=#Form.GoalID#&E=1" addtoken="No"> 
		 </cfif>
		 
		 <cfif Len(trim(form.Fyear)) EQ 0>
		   <cflocation url="EditGoal.cfm?GoalID=#Form.GoalID#&E=2" addtoken="No"> 
		 </cfif>
		 
		 <cfif Len(trim(Form.Label)) EQ 0>
		   <cflocation url="EditGoal.cfm?GoalID=#Form.GoalID#&E=3" addtoken="No"> 
		 </cfif>
		 
		 
		 <!--- Set Temp Variables --->
		 <cfset TempLabel = Trim(Form.Label)>
		 <cfset TempDesc = Trim(Form.Desc)>
		 
		 <!--- Add Record --->
		 <cfquery name="UpdGoal" datasource="#Application.dsn#">
		   Update Goals
		   	 Set GoalNbr = #Form.GoalNbr#, 
				 FYear = #Form.fyear#,
				 Active = <cfif IsDefined("Form.Isactive")>1<cfelse>0</cfif>,
				 Label = '#TempLabel#',
				 Description = <cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>, 
				 LastUpdated = #CreateODBCDateTime(now())#
		    Where GoalID = #form.GoalID# 
		 </cfquery>
		 
		 <!--- Kick back to main page --->
		  <cflocation url="Goals.cfm?s=2" addtoken="No"> 
	  <cfelseif url.action EQ "Delete">
	      <cfquery name="DeleteGoal" datasource="#Application.dsn#">
		     Delete From Goals
			 Where GoalID = #url.GoalID#
		  </cfquery>	 
		  <!--- Kick back to main page --->
		  <cflocation url="Goals.cfm?s=3" addtoken="No"> 
	  <cfelse>
	     <strong><font face="arial" color="#cc0000" size="+1">THERE WAS A PROBLEM WHILE ATTEMPTING TO WRITE THE RECORD.<BR><BR><a href="index.cfm">CLICK HERE</a> TO GO TO THE MAIN PAGE</font></strong>
	  </cfif> 


  </td>
  </tr>
</table>