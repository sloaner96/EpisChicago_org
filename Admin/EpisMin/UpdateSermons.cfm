<cfif URL.Action EQ "ADD">
   <cfif Len(Trim(form.title)) EQ 0>
     <cflocation url="NewSermons.cfm?B=#Form.Bishop#&T=#Form.Stype#&E=1" addtoken="No">
   </cfif>
   
   <cfif Len(Trim(form.SermonDate)) EQ 0>
     <cflocation url="NewSermons.cfm?B=#Form.Bishop#&T=#Form.Stype#&E=2" addtoken="No">
   </cfif>
   
   <cfif Len(Trim(form.SermonText)) EQ 0>
     <cflocation url="NewSermons.cfm?B=#Form.Bishop#&T=#Form.Stype#&E=3" addtoken="No">
   </cfif>
   
   <cfif Len(Trim(form.imgFile)) GT 0>
       <cffile action="UPLOAD" 
          filefield="form.imgFile" 
		  destination="#Application.DirPath#\Images\" 
		  nameconflict="MAKEUNIQUE"> 
      <cfset ThisImage = file.serverfile>
   <cfelse>
      <cfset ThisImage = ""> 	  
   </cfif>
   
   <cfset TempSermon = Trim(Form.SermonText)>
   <cfquery name="AddSermon" datasource="#Application.dsn#">
      Insert Into Sermons (SermonTitle, 
	                       BishopID, 
						   SermonDate, 
						   SermonType, 
						   SermonText, 
						   WebURL, 
						   URLHeading, 
						   ImgName, 
						   LastUpdated)
	  Values ('#Form.Title#', 
	          #form.Bishop#, 
			  #CreateODBCDATE(Form.SermonDate)#, 
			  '#form.Stype#', 
			  '#TempSermon#', 
			  <cfif form.urlheading NEQ "">'#form.urlheading#',<cfelse>NULL,</cfif> 
			  <cfif form.weburl NEQ "">'#form.weburl#',<cfelse>NULL,</cfif> 
			  <cfif ThisImage NEQ "">'#ThisImage#',<cfelse>NULL,</cfif> 
			  #CreateODBCDateTime(Now())#)
   </cfquery>
   
  <cflocation url="Sermons.cfm" addtoken="No">
<cfelseif url.Action EQ "UPDATE">
   <cfif Not IsDefined("form.SermonID")>
     <cflocation url="index.cfm?E=1" addtoken="No">
   </cfif>
   <cfif Len(Trim(form.title)) EQ 0>
     <cflocation url="EditSermons.cfm?SID=#Form.SermonID#&E=1" addtoken="No">
   </cfif>
   
   <cfif Len(Trim(form.SermonDate)) EQ 0>
     <cflocation url="EditSermons.cfm?SID=#Form.SermonID#&E=2" addtoken="No">
   </cfif>
   
   <cfif Len(Trim(form.SermonText)) EQ 0>
     <cflocation url="EditSermons.cfm?SID=#Form.SermonID#&E=3" addtoken="No">
   </cfif>
   
   <cfif Len(Trim(form.imgFile)) GT 0>
       <cffile action="UPLOAD" 
          filefield="form.imgFile" 
		  destination="#Application.DirPath#\Images\" 
		  nameconflict="MAKEUNIQUE"> 
      <cfset ThisImage = file.serverfile>
   <cfelse>
      <cfset ThisImage = ""> 	  
   </cfif>
   
   <cfset TempSermon = Trim(Form.SermonText)>
   
   <cfquery name="AddSermon" datasource="#Application.dsn#">
      Update Sermons 
	   Set SermonTitle = '#Form.Title#', 
	       BishopID = #form.Bishop#, 
	       SermonDate = #CreateODBCDATE(Form.SermonDate)#, 
		   SermonType = '#form.Stype#', 
		   SermonText = '#TempSermon#', 
	       WebURL = <cfif form.urlheading NEQ "">'#form.urlheading#',<cfelse>NULL,</cfif> 
		   URLHeading = <cfif form.weburl NEQ "">'#form.weburl#',<cfelse>NULL,</cfif>  
		   <cfif ThisImage NEQ "">ImgName = '#ThisImage#',</cfif>
		   LastUpdated = #CreateODBCDateTime(Now())#
		Where SermonID = #Form.SermonID#   
   </cfquery>
   
  
  <cflocation url="Sermons.cfm" addtoken="No">
<cfelseif URL.Action EQ "DELETE">
  <cfquery name="Remove" datasource="#Application.dsn#">
    Delete From Sermons
	Where SermonID = #url.SermonID#
  </cfquery> 
  <cflocation url="Sermons.cfm" addtoken="No">
<cfelse>
  <cflocation url="Sermons.cfm" addtoken="No">
</cfif>