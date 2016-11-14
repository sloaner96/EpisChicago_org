<cfquery name="GetSubsites" datasource="#Application.dsn#" cachedwithin="#CreateTimespan(0,0,5,0)#">
Select G.*, L.CodeDesc, L.Ranking 
  From GroupNfo G, Lookups L
  where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE' 
  Order by L.CodeDesc, G.GroupType, L.Ranking
</cfquery>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
          <tr>
             <td><font face="tahoma" size="-1" color="003399"><strong>MANAGE SUBSITES</strong></font></td>
          </tr>
		  <tr>
		    <td><font face="verdana" size="-2"><a href="/admin/subsites/index.cfm">Group Subsite Home</a></font></td>
		  </tr>
		  <tr>
		    <td>&nbsp;</td>
		  </tr>
		  <cfoutput query="getsubsites" group="CodeDesc">
		     <tr>
			   <td><font face="verdana" size="-2"><strong>#GetSubsites.CodeDesc#</strong></font></td>
			 </tr>
		   <cfoutput>
		     <tr>
		       <td><a href="/admin/subsites/EditSite.cfm?GroupID=#GetSubsites.GroupID#"><font face="verdana" size="-2">#GroupName#</font></a></td>
		     </tr>
			</cfoutput>
			 <tr>
			   <td>&nbsp;</td>
			 </tr>
		  </cfoutput>
</table>
