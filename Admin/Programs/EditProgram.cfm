<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="Programs" datasource="#Application.DSN#">
	Select P.*, 
	  (Select Count(*)
	    From ProgramContent
		Where ProgramID = P.ProgramID) as ContentCount
	From Programs p
	Where P.ProgramID = #url.PID#
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Add New Program">
	<blockquote>
<cfoutput>	
	  <cfform name="AddProg" action="UpdateProgram.cfm?Action=UpdateInfo" Method="POST">
          <input type="hidden" name="ProgramID" value="#url.PID#">
		  <table border="0" cellpadding="4" cellspacing="0" width="100%">
	         <tr>
	           <td><font face="arial" size="-1">Use the form below to edit information about this program.</font></td>
	         </tr>
			 <tr>
			   <td>&nbsp;</td>
			 </tr>
			 <cfif url.e eq 1>
			    <tr>
				  <td align="center"><font face="arial" color="##cc0000" size="-1"><strong>Error! You must include a title for this program</strong></font></td>
				</tr>
			 <cfelseif url.e eq 2>
			    <tr>
				  <td align="center"><font face="arial" color="##cc0000" size="-1"><strong>Error! The title you included for this program is already in use, please try another title.</strong></font></td>
				</tr>
			 <cfelseif url.e eq 3>
			   <tr>
				  <td align="center"><font face="arial" color="##cc0000" size="-1"><strong>Error! You must enter a end date for this program</strong></font></td>
				</tr>
			 </cfif>
			 <tr>
			   <td><p><font face="verdana" size="-2"><strong>Last Updated:</strong> #DateFormat(Programs.LastUpdated, 'mm/dd/yyyy')#</font></p></td>
			 </tr>
			 <tr>
			   <td>
			     <table border="0" cellpadding="4" cellspacing="0" width="100%">
				   <cfif Programs.ContentCount GT 0 AND Programs.ContentCount NEQ "">
				     <tr>
					   <td><font face="verdana" size="-1"><strong>Approve For Release:</strong> <input type="checkbox" name="Approve" value="1" <cfif Programs.Approved EQ 1>Checked</cfif>></font></td>
					 </tr>
					 <tr>
					   <td><font face="verdana" size="-1"><strong>Show on Diocesan Homepage:</strong> <input type="checkbox" name="ShowOnSite" value="1" <cfif Programs.HomePageDisplay EQ 1>Checked</cfif>></font></td>
					 </tr>
			<!--- 		 <tr>
					   <td><font face="verdana" size="-1"><strong>Highlight on the Site:</strong> <cfif Programs.ProgHighlight EQ ""><input type="checkbox" name="Highlight" value="1" <cfif Programs.Hightlight EQ 1>Checked</cfif>><cfelse>"<em>#Programs.ProgHighlight#</em>" is currently the highlighted item on the site.</cfif></font></td>
					 </tr> --->
				   <cfelse>
				    <tr>
					  <td><font face="arial" color="Red" size="-1"><strong>You must <a href="EditContent.cfm?PID=#Programs.ProgramID#">add</a> content to this program before you can make it active.</strong></font></td>
					</tr>	 
				   </cfif>
	               <tr>
	                 <td><font face="verdana" size="-1"><strong>Program Title:</strong></font><br><cfinput type="text" name="Title" size="40" maxlength="150" value="#Trim(Programs.Title)#" required="Yes" message="You must enter a title for this program"></td>
	               </tr>
				   <tr>
	                 <td><font face="verdana" size="-1"><strong>Begin Date:</strong></font><br><cfinput type="text" name="BeginDate" size="12" maxlength="12" value="#DateFormat(Programs.BeginDate,'mm/dd/yyyy')#" required="no" message="You must enter a begin date"></td>
	               </tr>
				   <tr>
	                 <td><font face="verdana" size="-1"><strong>End Date:</strong></font><br><cfinput type="text" name="EndDate" size="12" maxlength="12" value="#DateFormat(Programs.EndDate,'mm/dd/yyyy')#" required="no" message="You must enter a end date"></td>
	               </tr>
				   <tr>
	                 <td><font face="verdana" size="-1"><strong>Short Description:</strong></font><br><textarea cols="45" rows="10" name="SDesc">#trim(Programs.ShortDesc)#</textarea></td>
	               </tr>
				   
	             </table>
			   </td>
			 </tr>
			 <tr>
			   <td>&nbsp;</td>
			 </tr>
			 <tr>
			   <td><input type="submit" name="submit" value="Update Info >>"></td>
			 </tr>
	      </table><br><br>
		  
	  </cfform>
	  </cfoutput>
	</blockquote>
</CFMODULE>

</HTML>