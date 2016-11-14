<cfmodule template="#Application.header#" PageTitle="Subsite Map">
<cfquery name="GetSubsites" datasource="#Application.dsn#" cachedwithin="#CreateTimespan(0,0,5,0)#">
Select G.*, L.CodeDesc, L.Ranking 
  From GroupNfo G, Lookups L
  where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE' 
  Order by G.GroupType, L.Ranking
</cfquery>
<center>
  <blockquote>
	<table border="0" cellpadding="2" cellspacing="0" width="100%" align="center">
	  <cfoutput query="getsubsites" group="GroupType">
	     <tr>
		   <td><font face="arial" size="-1"><strong>#GetSubsites.CodeDesc#</strong></font></td>
		 </tr>
	   <cfoutput>
	     <tr>
	       <td><a href="index.cfm?GroupID=#GetSubsites.GroupID#"><font face="verdana" size="-1">#GroupName#</font></a></td>
	     </tr>
		</cfoutput>
		 <tr>
		   <td>&nbsp;</td>
		 </tr>
	  </cfoutput>
	</table>
 </blockquote>	 
</center>

</cfmodule>