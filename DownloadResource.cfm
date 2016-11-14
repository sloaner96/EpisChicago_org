<cfif IsDefined("url.RecID") AND ISNumeric(URL.RecID)>
   <cfquery name="GetResource" datasource="#application.dsn#">
      Select *
	  From Forms
	  Where FormID = #url.RecID#
   </cfquery>
   
   <cfif GetResource.recordcount GT 0>
       <cfswitch expression="#Right(GetResource.FileName, 3)#">
	      <cfcase value="pdf">
		    <cfset Mime =  "application/pdf">
		  </cfcase>
		  <cfcase value="doc">
		    <cfset Mime =  "application/msword">
		  </cfcase>
		  <cfcase value="excel">
		    <cfset Mime =  "application/msexcel">
		  </cfcase>
		  <cfcase value="xls">
		    <cfset Mime =  "application/msexcel">
		  </cfcase>
		  <cfdefaultcase>
		    <cfset Mime =  "application/pdf">
		  </cfdefaultcase>
	   </cfswitch>
       <cfcontent type="#Mime#" file="#Application.DirPath#\forms#replacenocase(GetResource.FileName, "/", "\", "ALL")#" deletefile="No"> 
   </cfif>
</cfif>