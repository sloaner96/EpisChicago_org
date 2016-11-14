<cfquery name="GetSubSites" datasource="#Application.dsn#">
  Select G.*, L.*
  From GrpMembers M, GroupNfo G, Lookups L
  Where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE'
  AND G.GroupID = M.GroupID 
  AND M.MemberID = #Session.subUserID#
  AND M.IsAdmin = True
  order By G.GroupType, G.GroupName
</cfquery>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
          <tr>
             <td><font face="tahoma" size="-1" color="003399"><strong>MANAGE SUBSITES</strong></font></td>
          </tr>
		  <tr>
		    <td><font face="verdana" size="-2"><a href="/diocese/offices/siteadmn/siteAdmin.cfm">Group Subsite Home</a></font></td>
		  </tr>
		  <tr>
		    <td>&nbsp;</td>
		  </tr>
		  <cfoutput query="getsubsites" group="GroupType">
		     <tr>
			   <td><font face="verdana" size="-2"><strong>#GetSubsites.CodeDesc#</strong></font></td>
			 </tr>
		   <cfoutput>
		     <tr>
		       <td><a href="/diocese/offices/Siteadmn/EditSite.cfm?GroupID=#GetSubsites.GroupID#"><font face="verdana" size="-2">#GroupName#</font></a></td>
		     </tr>
			</cfoutput>
			 <tr>
			   <td>&nbsp;</td>
			 </tr>
		  </cfoutput>
</table>
