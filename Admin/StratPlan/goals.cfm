<cfparam name="url.s" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="GetGoals" datasource="#Application.dsn#">
  Select G.*, 
    (Select Count(*)
	  From Initiatives I
	  Where I.GoalID = G.GoalID) as InitExists 
  From Goals G
  Where Active = True
  Order By GoalNbr
</cfquery>
<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Goals" SubTitle="Main Menu">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top">
      <div align="center">
         <div align="right"><font face="verdana" size="-1"><a href="addgoal.cfm">Add New Goal</a></font></div><br>
		 <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
               <td><font face="arial" size="-1">Below are the active goals associated with the strategic plan. Click the goal number link to edit the goal content.</font></td>
            </tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<cfif url.s EQ 1>
			  <tr>
			    <td><font face="verdana" color="009900" size="-1"><strong>You Have Successfully Added A New Goal</strong></font></td>
			  </tr>
			<cfelseif url.S EQ 2>
			  <tr>
			    <td><font face="verdana" color="009900" size="-1"><strong>You Have Successfully Updated the Goal</strong></font></td>
			  </tr>
			<cfelseif url.S EQ 3>
			  <tr>
			    <td><font face="verdana" color="009900" size="-1"><strong>You Have Successfully Deleted the Goal</strong></font></td>
			  </tr>  
			</cfif>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<cfif GetGoals.recordcount GT 0>
				<tr>
				  <td>
				    <table border="0" cellpadding="3" cellspacing="1" width="100%">
	                  <tr bgcolor="eeeeee">
					     
						 <td align="center"><font face="verdana" size="-1"><strong>Goal Number</strong></font></td>
				         <td align="center"><font face="verdana" size="-1"><strong>Initiatives</strong></font></td>
						 <td><font face="verdana" size="-1"><strong>Goal</strong></font></td>
				      </tr>    
					  <cfoutput query="GetGoals">
					    <tr>
						  <td align="center"><font face="verdana" size="-1"><a href="EditGoal.cfm?GoalID=#GetGoals.GoalID#">#GetGoals.GoalNbr#</a></font></td> 
						  <td align="center"><font face="verdana" size="-2"><a href="initiatives.cfm?GoalID=#GetGoals.GoalID#"><cfif InitExists GT 0>Maintain Inititaives<cfelse>Add new Inititaives</cfif></a></font></td>
						  <td><font face="verdana" size="-1">#GetGoals.Label#</font></td>
						</tr>
					  </cfoutput>
	                </table>
				  </td>
				</tr>
			<cfelse>
			  <tr>
			    <td align="center"><font face="arial" size="-1"><strong>There are currently no active goals.</strong></font></td>
			  </tr>	
			</cfif>
         </table>
	  </div>
   </td>
  </tr>
</table>

</CFMODULE>