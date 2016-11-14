<cfparam name="url.s" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="GetInit" datasource="#Application.dsn#">
  Select I.*,
    (Select Label
	  From Goals
	  Where GoalID = I.GoalID) as GoalLabel 
  From Initiatives I
  <cfif ISDefined("url.goalID")>
   Where GoalID = #url.goalID#
  </cfif>
  Order By I.GoalID, I.Ranking
</cfquery>
<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Goals" SubTitle="Main Menu">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top">
      <div align="center">
         <div align="right"><font face="verdana" size="-1"><a href="addInit.cfm">Add New Initiative</a></font></div><br>
		 <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
               <td><font face="arial" size="-1">Below are the active initiatives associated with the strategic plan. Click the initiative to manage the content.</font></td>
            </tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<cfif url.s EQ 1>
			  <tr>
			    <td><font face="verdana" color="009900" size="-1"><strong>You Have Successfully Added A New Initiative</strong></font></td>
			  </tr>
			<cfelseif url.S EQ 2>
			  <tr>
			    <td><font face="verdana" color="009900" size="-1"><strong>You Have Successfully Updated the Initiative</strong></font></td>
			  </tr>
			<cfelseif url.S EQ 3>
			  <tr>
			    <td><font face="verdana" color="009900" size="-1"><strong>You Have Successfully Deleted the Initiative</strong></font></td>
			  </tr>  
			</cfif>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<cfif GetInit.recordcount GT 0>
				<tr>
				  <td>
				    <table border="0" cellpadding="3" cellspacing="1" width="100%">
					<cfoutput query="GetInit" group="GoalLabel">
					  <tr>
					   <td colspan=3><font face="arial" color="##330099" size="-1"><strong>#GetInit.GoalLabel#</strong></font></td>
					  </tr>
	                  <tr bgcolor="eeeeee">
						 <td><font face="verdana" size="-1"><strong>Label</strong></font></td>
				         <td><font face="verdana" size="-1"><strong>Completed On</strong></font></td>
				      </tr>    
					    <cfoutput>  
						    <tr>
							  <td><font face="verdana" size="-1"><a href="EditInit.cfm?InitID=#GetInit.InitID#">#GetInit.Label#</a></font></td> 
							  <td><font face="verdana" size="-1"><cfif GetInit.CompletedOn NEQ "">#GetInit.CompletedOn#<cfelse>Not Yet Complete</cfif></font></td>
							</tr>
						</cfoutput>
						<tr>
						  <td colspan=2>&nbsp;</td>
						</tr>
					  </cfoutput>
	                </table>
				  </td>
				</tr>
			<cfelse>
			  <tr>
			    <td align="center"><font face="arial" color="red" size="-1"><strong>There are currently no active initiative for this goal.</strong></font></td>
			  </tr>	
			</cfif>
         </table>
	  </div>
   </td>
  </tr>
</table>

</CFMODULE>