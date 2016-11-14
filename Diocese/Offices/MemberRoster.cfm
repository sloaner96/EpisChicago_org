
<cfquery name="GetMembers" datasource="#Application.dsn#">
  Select M.*, G.ISPrimary
  From Members M, GrpMembers G
  Where G.GroupID = #Attributes.GroupID#
  AND G.MemberID = M.MemberID
  Order By g.RANKING, G.IsPrimary, M.ISManager, M.LastName, M.Firstname 
</cfquery>
<div align="center">

<table border="0" cellpadding="2" cellspacing="4" align="center">
 <cfif GetMembers.recordcount GT 0>
    
	<cfoutput query="GetMembers">
	  <cfif GetMembers.currentrow MOD 2 EQ 1><tr></cfif>

		  <td valign="top"><font face="arial" size="-1"><strong>#GetMembers.Prefix# #GetMembers.Firstname# #GetMembers.Lastname#</strong></font><br>
		      <cfif StaffID NEQ ""><font face="verdana" size="-1">#GetMembers.Title#<br></cfif>
			  <a href="mailto:#GetMembers.Email#">#GetMembers.Email#</a><br>
			  <cfif StaffID NEQ ""><cfif GetMembers.Phone NEQ "">#GetMembers.Phone#</font></cfif></cfif>
		  </td>
		  <td>&nbsp;</td>
	  <cfif GetMembers.currentrow MOD 2 EQ 0></tr><tr><td>&nbsp;</td></tr></cfif>
	  
	</cfoutput>
  </cfif>
</table>
</div>
