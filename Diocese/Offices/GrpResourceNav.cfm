<cfparam name="Attributes.GroupID" default="0">
<cfquery name="GetCats" datasource="#Application.dsn#">
   Select Codevalue, Codedesc as CatName  
	   From Lookups L
	   where L.CodeGroup = 'RECCAT'
	   AND exists (Select Distinct Category 
	                 From Resources R, GrpResources G
					 where R.category = L.codevalue
					 AND G.ResourceID = R.ResourceID
					 AND G.GroupID = #Attributes.GroupID#)
	   Order By CodeDesc
</cfquery>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
    <tr bgcolor="#dfdeaa">
	  <td><font face"verdana" color="#cc3300" size="-1"><strong>GROUP RESOURCES</strong></font></td>
	</tr>
	<tr>
	  <td><img src="/images/blank.gif" height="15" width="1" border="0" alt=""></td>
	</tr>
	<cfoutput>
	<tr>
       <td><font face="verdana" size="-2"><a href="GroupResources.cfm?GroupID=#Attributes.GroupID#">All Resources</a></font></td>
    </tr>
	</cfoutput>
	<tr>
	  <td><img src="/images/blank.gif" height="8" width="1" border="0" alt=""></td>
	</tr>
  <cfoutput query="GetCats">
    <tr>
       <td><font face="verdana" size="-2"><a href="GroupResourcesDtl.cfm?CatID=#GetCats.CodeValue#&GroupID=#Attributes.GroupID#">#CatName#</a></font></td>
    </tr>
	<tr>
	  <td><img src="/images/blank.gif" height="8" width="1" border="0" alt=""></td>
	</tr>
  </cfoutput>
</table>