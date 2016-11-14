<cfif url.action EQ "ADD">
    <cfif Len(trim(Form.orgID)) EQ 0>
	  <cflocation URL="index.cfm" addtoken="NO">
	</cfif>
	
	<cfif Len(trim(Form.MinDesc)) EQ 0>
	  <cflocation URL="ParishMinistries.cfm?e=1" addtoken="NO">
	</cfif>
	
   <cfquery name="AddMinistry" datasource="#Application.DSN#">
     Insert Into FaithExplorerMinistrty (
	     ORGID, 
		 [Desc], 
		 ContactName, 
		 Email, 
		 Phone, 
		 DateAdded
		 )
	 VALUES(
	     #Form.OrgID#, 
		 '#Form.MinDesc#', 
		 <cfif Len(trim(Form.Contact)) NEQ 0>'#Form.Contact#'<cfelse>NULL</cfif>, 
		 <cfif Len(trim(Form.Email)) NEQ 0>'#Form.Email#'<cfelse>NULL</cfif>, 
		 <cfif Len(trim(Form.Phone)) NEQ 0>'#Form.Phone#'<cfelse>NULL</cfif>, 
		 #CreateODBCDateTime(now())#
		 )
   </cfquery>
   
   <cflocation URL="ParishMinistries.cfm?OrgID=#form.OrgID#" addtoken="NO">
<cfelseif URL.Action EQ "UPDATE">
   <cfquery name="updMinistry" datasource="#Application.DSN#">
     Update FaithExplorerMinistrty
	   ORGID       = #Form.OrgID#,
	   [Desc]        = '#Form.MinDesc#',
	   <cfif Len(trim(Form.Contact)) NEQ 0>ContactName = '#Form.Contact#'<cfelse>NULL</cfif>,
	   <cfif Len(trim(Form.Email)) NEQ 0>Email       = '#Form.Email#'<cfelse>NULL</cfif>,
	   <cfif Len(trim(Form.Phone)) NEQ 0>Phone       = '#Form.Phone#'<cfelse>NULL</cfif>,
	   DateAdded   = #CreateODBCDateTime(now())#
	 Where MinistryID = #Form.MinistryID#
   </cfquery>
   
   <cflocation URL="ParishMinistries.cfm?OrgID=#form.OrgID#" addtoken="NO">
<cfelseif URL.Action EQ "REMOVE">
    <cfif Not IsDefined("url.MinID")>
	  <cflocation URL="ParishMinistries.cfm?e=4" addtoken="NO">
	</cfif>
    <cfquery name="updMinistry" datasource="#Application.DSN#">
      Delete From FaithExplorerMinistrty
	  Where MinistryID = #URL.MinID#
   </cfquery>
   
   <cflocation URL="ParishMinistries.cfm?OrgID=#url.OrgID#" addtoken="NO">
</cfif>