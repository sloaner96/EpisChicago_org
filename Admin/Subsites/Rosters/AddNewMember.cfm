
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Add a new Member</TITLE>
	</cfoutput>
</HEAD>
<CFMODULE Template="#Application.Header#" Section="Admin"  pagetitle="Add a new Member">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
<td>&nbsp;</td>
<td valign="top">

	<font face="Verdana" size="-1">
	<p>From this web page, you can add a new members information.</p>
	</font>

		<cfform name="addmem" Action="UpdateRoster.cfm?action=Add&Type=N" method="Post">
		    <cfoutput>
		      <input type="hidden" name="GroupID" Value="#url.groupID#">
					<table border="0" cellpadding="0" cellspacing="3">
						<tr>
						  <td colspan=2>
						    <table border="0" cellpadding="3" cellspacing="0">
	                          <tr>
						         <td><font face="arial" size="-1"><strong>Is this the Primary Member?</strong></font></td>
						         <td><input type="checkbox" name="IsPrimary" value="1" > <font face="verdana" size="-2"><strong>YES</strong></font></td>
						      </tr>
	                        </table>
						  </td>
						</tr>
						<tr>
						  <td colspan=2>
						    <table border="0" cellpadding="3" cellspacing="0">
	                          <tr>
						         <td><font face="arial" size="-1"><strong>Is this a Diocesan Staff Member?</strong></font></td>
						         <td><input type="checkbox" name="IsStaff" value="1" > <font face="verdana" size="-2"><strong>YES</strong></font></td>
						      </tr>
	                        </table>
						  </td>
						</tr>
						<tr>
						  <td colspan=2>
						    <table border="0" cellpadding="3" cellspacing="0">
	                          <tr>
						         <td><font face="arial" size="-1"><strong>Can this member Administer the subsite?</strong></font></td>
						         <td><input type="checkbox" name="IsAdmin" value="1" > <font face="verdana" size="-2"><strong>YES</strong></font></td>
						      </tr>
	                        </table>
						  </td>
						</tr>
						<tr>
						  <td colspan=2>
						    <table border="0" cellpadding="3" cellspacing="0">
	                          <tr>
						         <td><font face="arial" size="-1"><strong>If this member can admin the subsite, please enter a username and password</strong></font></td>
						      </tr>
							  <tr> 
							     <td><font face="arial" size="-1"><strong>USERNAME:</strong></font> <input type="text" name="Username" size="20" maxlength="50" value=""><br>
								     <font face="arial" size="-1"><strong>PASSWORD:</strong></font> <input type="password" name="Password" size="20" maxlength="50" value=""> 
								 </td>
						      </tr>
	                        </table>
						  </td>
						</tr>
						<tr>
						  <td colspan="2">&nbsp;</td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Title:</strong></font></td>
						   <td><cfinput type="text" name="Title" size="30" maxlength="70" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Prefix:</strong></font></td>
						   <td><input type="text" name="Prefix" size="20" maxlength="50" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Firstname:</strong></font></td>
						   <td><cfinput type="text" name="Firstname" size="30" maxlength="70" value="" required="Yes" message="You must enter the firstname of this member"></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>MI:</strong></font></td>
						   <td><input type="text" name="MI" size="30" maxlength="70" value=""></td>
						</tr>
						
						<tr>
						   <td><font face="arial" size="-1"><strong>Lastname:</strong></font></td>
						   <td><cfinput type="text" name="Lastname" size="30" maxlength="70" value="" required="Yes" message="You must enter the lastname of this member"></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Suffix:</strong></font></td>
						   <td><input type="text" name="Suffix" size="20" maxlength="60" value=""></td>
						</tr>
						<tr>
						  <td colspan="2">&nbsp;</td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Phone:</strong></font><br><font face="verdana" size="-2">ex. 555-555-5555</font></td>
						   <td><input type="text" name="Phone" size="15" maxlength="13" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Fax:</strong></font><br><font face="verdana" size="-2">ex. 555-555-5555</font></td>
						   <td><input type="text" name="Fax" size="15" maxlength="13" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Email:</strong></font><br><font face="verdana" size="-2">you@email.com</font></td>
						   <td><input type="text" name="email" size="30" maxlength="70" value=""></td>
						</tr>
						<tr>
						  <td colspan="2">&nbsp;</td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Address:</strong></font></td>
						   <td><input type="text" name="Address1" size="30" maxlength="60" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>Additional<br>Address</strong></font></td>
						   <td><input type="text" name="Address2" size="30" maxlength="60" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>City:</strong></font></td>
						   <td><input type="text" name="City" size="30" maxlength="50" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>State:</strong></font></td>
						   <td><input type="text" name="State" size="4" maxlength="20" value=""></td>
						</tr>
						<tr>
						   <td><font face="arial" size="-1"><strong>ZipCode:</strong></font></td>
						   <td><input type="text" name="Zipcode" size="10" maxlength="15" value=""></td>
						</tr>
						<tr>
							<td colspan=2 align=center>
								<input type="Submit" value="Add new Member >>"> 
							</td>
						</tr>
				</table>
			</cfoutput>
		</cfform>
</td>
</tr>
</table>
</CFMODULE>

</HTML>