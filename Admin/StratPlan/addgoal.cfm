<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Goals" SubTitle="Main Menu">
<cfquery name="GetGoals" datasource="#Application.dsn#">
  Select Max(GoalNbr) as MaxGoals
  From Goals G
  Where Fyear = #Year(now())#
</cfquery>
 <cfif GetGoals.MaxGoals NEQ "">
     <cfset NextGoal = GetGoals.MaxGoals + 1>
 <cfelse>
    <cfset NextGoal = 1>
 </cfif>	
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
            <td><font face="arial" size="-1">Use the form below to Add a new Goal to the Strategic Plan.</font></td>
         </tr>
		 <tr>
		   <td><hr noshade size=1></td>
		 </tr>
		 <cfif url.e EQ 1>
		   <tr>
			 <td><font face="verdana" color="cc0000" size="-1"><strong>You Must Select a Goal Number for this Goal.</strong></font></td>
		   </tr>
		 <cfelseif url.e EQ 2>
		   <tr>
			 <td><font face="verdana" color="cc0000" size="-1"><strong>You Must Add a Strategic Plan Year for this Goal.</strong></font></td>
		   </tr>
		 <cfelseif url.e EQ 2>
		   <tr>
			 <td><font face="verdana" color="cc0000" size="-1"><strong>You Must Add a Goal Label for this Goal.</strong></font></td>
		   </tr>  
		 </cfif>
		 <tr>
		   <td>
		     <cfform action="UpdateGoals.cfm?action=Add" method="POST" name="addgoal" enctype="multipart/form-data">
			     <table border="0" cellpadding="3" cellspacing="0">
	                 <tr>
	                    <td><font face="verdana" size="-2"><strong>Goal Label:</strong></font></td>
						<td><cfinput type="Text" name="label" message="You must enter goal text" required="Yes" size="50" maxlength="255"></td>
	                 </tr>
					 <cfoutput>
					 <tr>
	                    <td><font face="verdana" size="-2"><strong>Goal Number:</strong></font></td>
						<td><select name="GoalNbr">
						      <option value="">-- Goal Number --</option>
							  <cfloop index="i" from="1" to="#NextGoal#">
							  <option value="#i#" <cfif i EQ NextGoal>Selected</cfif>>#i#</option>
							  </cfloop>
							</select>
						</td>
	                 </tr>
					 </cfoutput>
					 <tr>
					   <td><font face="verdana" size="-2"><strong>Activate Goal Now:</strong></font></td>
					   <td><input type="checkbox" name="Isactive" value="1"></td>
					 </tr>
					 <tr>
	                    <td><font face="verdana" size="-2"><strong>Strategic Plan Year:</strong></font></td>
						<td><cfinput type="Text" name="fyear" message="You must enter a strategic plan year." validate="integer" value="#year(now())#" required="Yes" size="4" maxlength="4"></td>
	                 </tr>
	                 
					 <!--- <tr>
					   <td><font face="verdana"  size="-2"><strong>Add Photo:</strong></font></td>
					   <td><input type="file" name="Goalimg" size="15"></td>
					 </tr>
					 <tr>
					   <td>&nbsp;</td>
					 </tr> --->
					 <tr>
					   <td colspan=2 valign="top"><font face="verdana" size="-2"><strong>Goal Description:</strong></font></td>
					 </tr>
					 <tr>
						<td colspan=2><textarea cols="55" rows="15" name="Desc"></textarea></td>
	                 </tr>
					 <tr>
					   <td>&nbsp;</td>
					 </tr>
					 <tr>
					   <td colspan=2 align="center"><input type="submit" name="submit" value="Add a New Goal >>"></td>
					 </tr>
	             </table>
			 </cfform>
		   </td>
		 </tr>
      </table>
   </td>
  </tr>
</table>

</CFMODULE>