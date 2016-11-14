<cfparam name="Url.Type" default="M">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Add a New Member</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  pagetitle="Search For a Member">
<cfoutput>
<div align="right"><a href="index.cfm?groupID=#url.groupid#"><font face="tahoma" size="-1">Back to Member Admin</font></a></div>
</cfoutput>
<br>

<font face="Verdana" size="-1">
  <p>From this web page, you can add an existing member from another group to the Member Roster of this subsite.</p>
</font>
<hr noshade size=1>
<br>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
	<tr>
		<td valign="top">
			<cfoutput>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
				  <td><font face="verdana" size="-1"><strong>Search for an existing member from another group subsite </strong></font></td>
				</tr>
				<tr>
				  <td>&nbsp;</td>
				</tr>
				<cfform name="search" action="addmember.cfm?type=#url.type#&groupid=#url.groupid#" method="POST"> 
				<tr>
				  <td><input type="text" name="membersrch" size="20" maxlength="40">&nbsp;&nbsp;<input type="submit" name="submit" value="search"></td>
				</tr>
				</cfform>
				<tr>
				  <td colspan=2>&nbsp;</td>
				</tr>
				<cfif ISDefined("form.membersrch")>
				  <cfquery name="GetMember" datasource="#application.dsn#">
				     Select M.*
					 From Members M
					 Where firstname like '%#form.membersrch#%'
					 OR M.lastname like '%#form.membersrch#%'
					 AND M.MemberID Not IN (Select G.MemberID
					                         From GrpMembers G
										     where G.MemberID = M.MemberID
											 AND G.GroupID = #url.GroupID#)
					 order by lastname, firstname
				  </cfquery>
				 
					 <cfif getmember.recordcount EQ 0>
					    <tr>
						  <td><font face="verdana" size="-1">There are no members that meet your criteria. Click <a href="AddNewMember.cfm?Type=N&GroupID=#Url.GroupID#">Here</a> to Add this Member.</font></td>
						</tr>
					 <cfelse>
					   <tr>
					    <td><font face="tahoma" size="-1"><strong>Your Search Returned <font color="##800000">#GetMember.Recordcount#</font> Members</strong></font></td>
					   </tr>
					   <tr>
					     <td>
						   <table border="0" cellpadding="0" cellspacing="0" width="100%">
							 <tr>
							   <td><font face="arial" size="-1">Select the member below that matches your search. If there are no existing members that match your search you can add a new member by clicking <a href="AddNewMember.cfm?Type=N&GroupID=#Url.GroupID#">here</a>.</font></td>
							 </tr>
							 <tr>
							   <td>&nbsp;</td>
							 </tr>
								 <form name="AddExMember" action="UpdateRoster.cfm?Type=M&Action=Add&GroupID=#Url.GroupID#" Method="POST">
									 <tr>
										<td>
										  <table border="0" cellpadding="0" cellspacing="0">
											<cfloop query="GetMember">
											  <tr>
									   			 <td width="5"><input type="radio" name="mbrID" value="#GetMember.MemberID#" <cfif GetMember.recordcount EQ 1>Checked</cfif>></td>
									             <td><font face="verdana" size="-2"><strong>#GetMember.Prefix# #GetMember.FirstName# #GetMember.LastName# #GetMember.Suffix#</strong></font></td>
		                                      </tr>
											</cfloop>
		                                   </table>
										</td>
									 </tr>
									 <tr>
									   <td>&nbsp;</td>
									 </tr>
									 <tr>
									   <td><input type="submit" name="submit" value="Add Member >>"></td>
									 </tr>
								 </form>
							 </table>
							</cfif>
						 </td>
					   </tr>
				</cfif>
			</table>
		  </cfoutput> 

		</td>
	</tr>
</table>
</CFMODULE>

</HTML>