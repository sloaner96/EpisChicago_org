<cfif url.action EQ "Create">
   <cfif Len(Trim(form.ResourceTitle)) GT 0>
      <cfquery name="GetRank" datasource="#Application.dsn#">
	    Select Max(Ranking) as MaxRank
		From ResourceGrouping
		Where Active = True
		AND DisplayOnSite = True
	  </cfquery>
      
	  <cfif GetRank.MaxRank NEQ "">
	    <cfset NextRank = GetRank.MaxRank + 1>
	  <cfelse>
	    <cfset NextRank =  1>
	  </cfif>
	  
	  <cfquery name="AddGrouping" datasource="#Application.dsn#">
	    Insert Into ResourceGrouping (Title, DisplayOnSite, Active, Ranking)
		Values('#Form.ResourceTitle#', 0, 0, #NextRank#)
	  </cfquery>
      
	  <cfquery name="GetGroupID" datasource="#Application.dsn#">
	    Select RGroupID
		From Resourcegrouping
		Where Title = '#Form.ResourceTitle#'
		AND DisplayOnSite = 0
		AND Active = 0
		AND Ranking = #NextRank#
	  </cfquery>
	  
	  <cflocation url="Editgrouping.cfm?RGID=#GetGroupID.RgroupID#" addtoken="No">
   <cfelse>
     <cflocation url="Newgrouping.cfm?e=1" addtoken="No">
   </cfif>
<cfelseif url.action EQ "Add">
   <cfif IsDefined("Form.Resource")>
      <cfif ListLen(Form.Resource, ",") GT 0>
	     <cfloop index="i" list="#form.Resource#" delimiters=",">
		    <cfquery name="AddResource" Datasource="#Application.dsn#">
			   Insert Into ResourceGroupingContent (RGroupID, ResourceID)
			   Values(#URL.RGID#, #i#)
			</cfquery>
		 </cfloop>
	  </cfif>
   </cfif>
   <cflocation url="Editgrouping.cfm?RGID=#Url.RGID#" addtoken="No">
<cfelseif url.action EQ "Remove">
   <cfif IsDefined("url.ResID") AND IsDefined("Url.RGID")>
     <cfif Len(trim(url.ResiD)) GT 0 AND Len(trim(url.RGID)) GT 0>
	    <cfquery name="AddResource" Datasource="#Application.dsn#">
			   Delete From ResourceGroupingContent
			   WHERE RGroupID = #URL.RGID#
			   AND ResourceID = #url.ResiD#
	    </cfquery>
	 </cfif> 
   </cfif>
   <cflocation url="Editgrouping.cfm?RGID=#Url.RGID#" addtoken="No">
<cfelseif url.action EQ "Delete">
    <cfif IsDefined("Url.RGID")>
     <cfif Len(trim(url.RGID)) GT 0>
	    <cfquery name="AddResource" Datasource="#Application.dsn#">
		   Delete From ResourceGroupingContent
		   WHERE RGroupID = #URL.RGID#
	    </cfquery>
		<cfquery name="AddResource" Datasource="#Application.dsn#">
			Delete From ResourceGrouping
			WHERE RGroupID = #URL.RGID#
	    </cfquery>
	 </cfif> 
   </cfif>
   <cflocation url="GroupResources.cfm" addtoken="No">
<cfelseif url.action EQ "Activation">
  <cfif IsDefined("form.Active")>
    <cfquery name="Activate" datasource="#Application.dsn#">
	  Update ResourceGrouping
	  Set Active = True,
	  DisplayOnSite = True
	  Where Rgroupid = #url.RGID#
	</cfquery>
  <cfelseif IsDefined("form.InActive")>
    <cfquery name="inActivate" datasource="#Application.dsn#">
	  Update ResourceGrouping
	  Set Active = 0,
	  DisplayOnSite = 0 
	  Where Rgroupid = #url.RGID#
	</cfquery>
  </cfif>  
  
  <cflocation url="Editgrouping.cfm?RGID=#Url.RGID#" addtoken="No">
  
</cfif>