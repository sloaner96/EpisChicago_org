<cfquery name="GetForm" datasource="#Application.DSN#">
  Select * From Forms
  Where FormID = #url.FID#
  AND GroupID = #url.GroupID#
</cfquery>

<CFSET Location = "#Application.DirPath#\Forms\Subsites\">

<cfquery name="DeleteForm" datasource="#Application.DSN#">
  Delete From Forms
  Where FormID = #url.FID#
  AND GroupID = #url.GroupID#
</cfquery>

<cfif FileExists("#Location#/#GetForm.filename#")>
   <cffile action="DELETE" file="#Location#/#GetForm.filename#"> 
</cfif>

<cflocation url="index.cfm?GroupID=#url.groupID#" addtoken="No">