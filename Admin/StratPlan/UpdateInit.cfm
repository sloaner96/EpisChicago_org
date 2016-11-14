<cfparam name="url.action" default="">

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Initiatives" SubTitle="Main Menu">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top" align="center">

      <cfif url.action EQ "ADD">
	     <!--- Error Handling --->
		 <cfif Len(trim(form.GoalID)) EQ 0>
		   <cflocation url="AddInit.cfm?E=1" addtoken="No"> 
		 </cfif>
		 
		 <cfif Len(trim(form.Label)) EQ 0>
		   <cflocation url="AddInit.cfm?E=3" addtoken="No"> 
		 </cfif>
		 
		 <cfif len(form.Initimg) GT 0>
		   <cfset Location = "#Application.DirPath#\Forms\Subsites\">
	          <cffile action="UPLOAD"
	             filefield="Form.InitImg"
	             destination="#Location#"
	             nameconflict="MakeUnique">
				 
			<cfset Picname = file.serverfile> 
		 <cfelse>
		   <cfset Picname = "">	
		 </cfif>
		 
		 <!--- Set Temp Variables --->
		 <cfset TempLabel = Trim(Form.Label)>
		 <cfset TempDesc = Trim(Form.Desc)>
		 
		 <cfquery name="GetRank" datasource="#Application.dsn#">
		   Select Max(Ranking) as MaxRank
		   From Initiatives
		   Where GoalID = #form.GoalID#
		 </cfquery>
		 <cfif GetRank.recordcount GT 0>
			 <cfif GetRank.MaxRank NEQ "">
			   <cfset ThisRank = GetRank.MaxRank + 1>
			 <cfelse>
			   <cfset ThisRank = 1>
			 </cfif>
		 <cfelse>
		   	 <cfset ThisRank = 1>
		 </cfif>
		 <!--- Add Record --->
		 <cfquery name="AddInit" datasource="#Application.dsn#">
		   Insert Into Initiatives (
		   			GoalID,
					Label,
					Description,
					ImgPath,
					AlbumID,
					Ranking,
					LastUpdated)
		    Values (
		            #Form.GoalID#,
					'#TempLabel#',
					<cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>,
					<cfif Picname NEQ "">'#Picname#'<cfelse>NULL</cfif>,
					<cfif form.AlbumID NEQ "">#form.AlbumID#<cfelse>NULL</cfif>,
					#ThisRank#,
					#CreateODBCDateTime(now())#
				  )					 
		 </cfquery>
		 
		 <!--- Kick back to main page --->
		  <cflocation url="initiatives.cfm?s=2" addtoken="No"> 
	  <cfelseif url.action EQ "Update">
	  <!--- Error Handling --->
		 <cfif Len(trim(form.GoalID)) EQ 0>
		   <cflocation url="EditInit.cfm?GoalID=#Form.InitID#&E=1" addtoken="No"> 
		 </cfif>
		 
		 
		 <cfif Len(trim(Form.Label)) EQ 0>
		   <cflocation url="EditInit.cfm?GoalID=#Form.InitID#&E=3" addtoken="No"> 
		 </cfif>
		 
		 <!--- Set Temp Variables --->
		 <cfset TempLabel = Trim(Form.Label)>
		 <cfset TempDesc = Trim(Form.Desc)>
		 
		 <cfif len(form.Initimg) GT 0>
		   <cfset Location = "#Application.DirPath#\images\Subsites\">
	          <cffile action="UPLOAD"
	             filefield="Form.InitImg"
	             destination="#Location#"
	             nameconflict="MakeUnique">
				 
			<cfset Picname = file.serverfile> 
		 <cfelse>
		   <cfset Picname = "">	
		 </cfif>
		 
		 <!--- Add Record --->
		 <cfquery name="UpdInit" datasource="#Application.dsn#">
		   Update Initiatives
		   	 Set GoalID = #Form.GoalID#, 
				 Label = '#TempLabel#',
				 Description = <cfif TempDesc NEQ "">'#TempDesc#'<cfelse>NULL</cfif>, 
				 <cfif Picname NEQ "">ImgPath = '#PicName#',</cfif>
				 AlbumID = <cfif form.AlbumID NEQ "">#form.AlbumID#<cfelse>NULL</cfif>,
				 CompletedOn = <cfif form.DateComplete NEQ "">#CreateODBCDate(form.DateComplete)#<cfelse>NULL</cfif>,
				 Ranking = #Ranking#,
				 LastUpdated = #CreateODBCDateTime(now())#
		    Where InitID = #form.InitID# 
		 </cfquery>
		 
		 <!--- Kick back to main page --->
		  <cflocation url="initiatives.cfm?s=2" addtoken="No"> 
	  <cfelseif url.action EQ "Delete">
	      <cfquery name="DeleteInit" datasource="#Application.dsn#">
		     Delete From Initiatives
			 Where InitID = #url.InitID#
		  </cfquery>	 
		  <!--- Kick back to main page --->
		  <cflocation url="initiatives.cfm?s=3" addtoken="No"> 
	  <cfelse>
	     <strong><font face="arial" color="#cc0000" size="+1">THERE WAS A PROBLEM WHILE ATTEMPTING TO WRITE THE RECORD.<BR><BR><a href="index.cfm">CLICK HERE</a> TO GO TO THE MAIN PAGE</font></strong>
	  </cfif> 


  </td>
  </tr>
</table>