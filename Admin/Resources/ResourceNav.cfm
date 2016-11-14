
<cfquery name="GetCats" datasource="#Application.dsn#">
   Select Codevalue, Codedesc as CatName  
	   From Lookups
	   where CodeGroup = 'RECCAT'
	   AND exists (Select Distinct Category From Resources where category = codevalue and active = true)
	   Order By 2
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
	  <td><font face="tahoma" color="#000099" size="3"><strong>Diocesan Resources</strong></font></td>
	</tr>
	<tr>
	  <td><img src="/images/blank.gif" height="15" width="1" border="0" alt=""></td>
	</tr>
  <cfoutput query="GetCats">
    <tr>
       <td><font face="verdana" size="-2"><a href="index.cfm?CatID=#GetCats.CodeValue#">#CatName#</a></font></td>
    </tr>
	<tr>
	  <td><img src="/images/blank.gif" height="8" width="1" border="0" alt=""></td>
	</tr>
  </cfoutput>
</table>