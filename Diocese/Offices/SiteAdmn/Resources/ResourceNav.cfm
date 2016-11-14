<cfparam name="attributes.GroupID" default="0">
<cfquery name="GetCats" datasource="#Application.dsn#">
   Select R.Category,
     (Select CodeDesc
	   From Lookups
	   Where CodeValue = R.Category
	   AND Codegroup = 'RECCAT') As CatName
   From Resources R, GrpResources G
   Where R.ResourceID = G.ResourceID  
   AND G.GroupID = #Attributes.GroupID#
   Order By 2
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
	  <td><font face="tahoma" color="#000099" size="3"><strong>Group Resources</strong></font></td>
	</tr>
	<tr>
	  <td><img src="/images/blank.gif" height="15" width="1" border="0" alt=""></td>
	</tr>
	<cfoutput>
	<tr>
       <td><font face="verdana" size="-2"><a href="index.cfm?GroupID=#Attributes.GroupID#">Resource Home</a></font></td>
    </tr>
	</cfoutput>
	<tr>
	  <td>&nbsp;</td>
	</tr>
  <cfoutput query="GetCats" group="CatName">
    <tr>
       <td><font face="verdana" size="-2"><a href="index.cfm?CatID=#GetCats.Category#&GroupID=#Attributes.GroupID#">#CatName#</a></font></td>
    </tr>
	<tr>
	  <td><img src="/images/blank.gif" height="8" width="1" border="0" alt=""></td>
	</tr>
  </cfoutput>
</table>