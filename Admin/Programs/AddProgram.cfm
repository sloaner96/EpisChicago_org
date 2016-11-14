<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Add New Program">
	<blockquote>
	  <cfform name="AddProg" action="UpdateProgram.cfm?Action=AddInfo" Method="POST">
		  <table border="0" cellpadding="4" cellspacing="0" width="100%">
	         <tr>
	           <td><font face="arial" size="-1">Use the form below to setup a new program. Once you have entered the program info click the save and continue button, you will need to add content, and finally events to this program.</font></td>
	         </tr>
			 <tr>
			   <td>&nbsp;</td>
			 </tr>
			 <cfif url.e eq 1>
			    <tr>
				  <td align="center"><font face="arial" color="#cc0000" size="-1"><strong>Error! You must include a title for this program</strong></font></td>
				</tr>
			 <cfelseif url.e eq 2>
			    <tr>
				  <td align="center"><font face="arial" color="#cc0000" size="-1"><strong>Error! The title you included for this program is already in use, please try another title.</strong></font></td>
				</tr>
			 <cfelseif url.e eq 3>
			   <tr>
				  <td align="center"><font face="arial" color="#cc0000" size="-1"><strong>Error! You must enter a end date for this program</strong></font></td>
				</tr>
			 </cfif>
			 <tr>
			   <td>
			     <table border="0" cellpadding="4" cellspacing="0" width="100%">
	               <tr>
	                 <td><font face="verdana" size="-1"><strong>Program Title:</strong></font><br><cfinput type="text" name="Title" size="40" maxlength="150" required="Yes" message="You must enter a title for this program"></td>
	               </tr>
				   <tr>
	                 <td><font face="verdana" size="-1"><strong>Begin Date:</strong></font><br><cfinput type="text" name="BeginDate" size="12" maxlength="12" required="no" message="You must enter a begin date"></td>
	               </tr>
				   <tr>
	                 <td><font face="verdana" size="-1"><strong>End Date:</strong></font><br><cfinput type="text" name="EndDate" size="12" maxlength="12" required="no" message="You must enter a end date"></td>
	               </tr>
<!--- 				   <tr>
				     <td><font face="verdana" size="-1"><strong>Highlight on the Diocesan Homepage:</strong></font> <input type="checkbox" name="onHomepage" value="1"></td>
				   </tr> --->
				   <tr>
	                 <td><font face="verdana" size="-1"><strong>Short Description:</strong></font><br><textarea cols="45" rows="10" name="SDesc"></textarea></td>
	               </tr>
				   
	             </table>
			   </td>
			 </tr>
			 <tr>
			   <td>&nbsp;</td>
			 </tr>
			 <tr>
			   <td><input type="submit" name="submit" value="Save & Continue >>"></td>
			 </tr>
	      </table>
	  </cfform>
	</blockquote>
</CFMODULE>

</HTML>