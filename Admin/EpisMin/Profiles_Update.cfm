

<cfif Form.BishopID EQ "">
  <cflocation url="Profiles.cfm?e=1" addtoken="No">
</cfif>

<cfif Form.Profile EQ "">
  <cflocation url="Profiles.cfm?e=2" addtoken="No">
</cfif>

<cfif form.BNewimg NEQ "">
  <cffile action="UPLOAD" 
          filefield="form.BNewimg" 
		  destination="#Application.DirPath#\Images\" 
		  nameconflict="MAKEUNIQUE"> 
		  
  <cfset ThisPicture = file.serverfile>
<cfelse>
  <cfset ThisPicture = "">  		  
</cfif>

<cfset TempProfile = Trim(Form.Profile)>

<cfquery name="UpdateBishop" datasource="#Application.dsn#">
  Update Bishops
   Set BishopType = '#BType#',
       <cfif ThisPicture NEQ "">
         BishopImage = '#ThisPIcture#',
	   </cfif>
	   InstalledOn = <cfif InstalledON NEQ "">#CreateODBCDATETime(Form.InstalledOn)#,<cfelse>NULL,</cfif>
	   Profile = '#TempProfile#',
	   ConsecrationSite = <cfif form.ConSite NEQ "">'#Form.ConSite#',<cfelse>NULL,</cfif>
	   Email = <cfif form.email NEQ "">'#Form.Email#',<cfelse>NULL,</cfif>
	   Phone = <cfif form.Phone NEQ "">'#Form.Phone#',<cfelse>NULL,</cfif>
	   AdminID = <cfif form.BAdmin NEQ "">#Form.BAdmin#,<cfelse>NULL,</cfif>
	   LastUpdated = #CreateODBCDATETIME(Now())#
  Where BishopID = #Form.BishopID#
</cfquery>

<cflocation url="Profiles.cfm" addtoken="No">