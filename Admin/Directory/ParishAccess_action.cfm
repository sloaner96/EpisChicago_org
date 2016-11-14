   <cfquery name="DeleteAccess" datasource="#Application.dsn#">
     Delete From FaithAccesability
     WHERE OrgID = #form.OrgID#
  </cfquery>	

<cfloop index="x" list="#form.churchaccess#" delimiters=",">
   <cfquery name="GETGROUP" datasource="#Application.dsn#">
     Select GroupID
	 From FaithAccessMatrix
     Where CatID = '#X#'
   </cfquery>
	   
   <cfquery name="InsertAccess" datasource="#Application.dsn#">
     INSERT INTO FaithAccesability (ORGID, GROUPID, CatID, DateAdded)
	 VALUES (#form.ORGID#, '#GETGROUP.GROUPID#', '#X#', #CreateODBCDateTime(now())#)
   </cfquery>
</cfloop>

<cflocation url="ParishAccess.cfm?orgID=#form.orgID#" addtoken="NO">