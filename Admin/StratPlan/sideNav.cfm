<cfquery name="GetGoals" datasource="#Application.dsn#">
  Select Count(*) as goalcount
  From Goals G
  Where Active = True
</cfquery>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td><font face="tahoma" size="-1"><strong>Strat Plan Admin</strong></font></td>
  </tr>
  <tr>
    <td><a href="index.cfm"><font face="verdana" size="-1">Admin Home</font></a></td>
  </tr>
  <tr>
    <td><a href="sitecontent.cfm"><font face="verdana" size="-1">Goals Homepage Content</a></td>
  </tr>
  <tr>
    <td><a href="goals.cfm"><font face="verdana" size="-1">Admin Goals</a></td>
  </tr>
  <cfif GetGoals.goalcount GT 0>
    <tr>
       <td><a href="Initiatives.cfm"><font face="verdana" size="-1">Admin Initiatives</a></td>
    </tr>
  </cfif>
</table>