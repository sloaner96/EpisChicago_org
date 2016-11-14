<cfquery name="BannerAds" datasource="#Application.dsn#">
  Select *
  From BannerAds
  Where BannerID = #Url.BID# 
</cfquery>

<cfif BannerAds.recordcount GT 0>
	<cfif BannerAds.HitCount NEQ "">
	   <cfset NewHitCount = BannerAds.HitCount +1>
	<cfelse>
	    <cfset NewHitCount = 1>
	</cfif>
	
	<cfquery name="UpdHitCount" datasource="#Application.dsn#">
	  Update BannerAds
	    Set HitCount = #NewHitCount#
		Where BannerID = #BannerAds.BannerID#
	</cfquery>
	
	<cfif BannerAds.AdURL NEQ "">
		<cfset GoSite = "#BannerAds.AdURL#">
	 <cfelse>
	   <cfif BannerAds.EventID NEQ ""> 
		  <cfset GoSite = "/ViewEvent.cfm?EventID=#BannerAds.EventID#">
	   <cfelseif BannerAds.ProgramID NEQ "">
	       <cfset GoSite = "/Programs.cfm?ProgramID=#BannerAds.ProgramID#">
	   <cfelseif BannerAds.GroupID NEQ "">
	       <cfset GoSite = "/diocese/offices/index.cfm?GroupID?#BannerAds.GroupID#">
	   </cfif>		
	 </cfif>
						 
	<cflocation url="#GoSite#" addtoken="no">
</cfif>