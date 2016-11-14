

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify FaithExplorer.Org Text</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify FaithExplorer.Org Site Links">
   <cfif URL.action EQ "ADD">
        <!--- Check to see if the catID is passed --->
			<cfif Not ISDefined("form.catID")>
			   <cflocation url="SiteLinks.cfm?e=1" addtoken="NO">
			<cfelse>
			   <cfif Len(Trim(form.CatID)) EQ 0>
			       <cflocation url="SiteLinks.cfm?e=1" addtoken="NO">
			   </cfif>
			</cfif>
		
		<!--- Check to see if a link was selected --->
		    <cfif Not ISDefined("form.Link")>
			   <cflocation url="SiteLinks.cfm?e=2" addtoken="NO">
			<cfelse>
			   <cfif Len(Trim(form.Link)) EQ 0>
			       <cflocation url="SiteLinks.cfm?e=2" addtoken="NO">
			   </cfif>
			</cfif> 
		
		   <cfquery name="InsertLink" datasource="#Application.dsn#">
		      Insert into FaithExplorerLinks(SiteLinkID, CatID)
			  Values(#form.Link#, #Form.CatID#)
		   </cfquery>
		   
		   <cflocation url="SiteLinks.cfm" addtoken="NO">
   <cfelseif URL.action EQ "REMOVE">
        <cfquery name="InsertLink" datasource="#Application.dsn#">
		      Delete From FaithExplorerLinks
			  Where LinkID = #URL.LinkID#
		</cfquery>  
		
		<cflocation url="SiteLinks.cfm" addtoken="NO">
   </cfif> 
   
          
</CFMODULE>

</HTML>
