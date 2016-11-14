<cfparam name="Url.Type" default="m">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Add a New Member</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  pagetitle="Add a New Member">
	<cfquery name="GetMember" datasource="#Application.DSN#">
	  Select *
	  From Members 
	  Where MemberID = #Form.exMbr#
	</cfquery>
	<cfform name="AddMember" action="UpdateRoster.cfm?Type=M&Action=Add" Method="POST">
	   <cfoutput>
	      <input type="hidden" name="MbrID" value="#GetMember.MemberID#">
		  <input type="hidden" name="GroupID" value="#url.GroupID#">
			<table border="0" cellpadding="5" cellspacing="0" width="100%">
				<tr>
				  <td><font face="verdana" size="+1">Adding <strong>#GetMember.Prefix# #GetMember.Firstname# #GetMember.Lastname#</strong> to this Group Subsite.</font></td>
				</tr>
				<tr>
				  <td colspan="2">&nbsp;</td>
				</tr>
				 <tr>
				   <td colspan=2><font face="arial" size="-1">Is this the Primary Member?</font> <input type="checkbox" name="IsPrimary" value="1"> <font face="verdana" size="-2"><strong>YES</strong></font></td>
				 </tr>
				<tr>
				  <td colspan=2><font face="arial" size="-1">Will this member be able to administer this subsite? <input type="checkbox" name="IsAdmin" value="1"> <font face="verdana" size="-2"><strong>YES</strong></font></td>
				</tr>
				<cfif GetMember.UserName EQ "">
				 <tr>
				  <td colspan=2><font face="arial" size="-1"><strong>Username:</strong> &nbsp; <cfinput type="text" name="username" size="15" maxlength="30"></td>
				</tr>
				<tr>
				  <td colspan=2><font face="arial" size="-1"><strong>Password:</strong> &nbsp; <cfinput type="password" name="password" size="15" maxlength="30"></td>
				</tr>
				<cfelse>
				 <tr>
				   <td colspan=2><font face="verdana" size="-2"><strong>A Username and Password already exists for this user.</strong></font></td>
				 </tr>
				</cfif>
				<tr>
				  <td colspan=2>&nbsp;</td>
				</tr>
				<tr>
				  <td colspan="2"><input type="submit" name="submit" value="Add New Member >>"></td>
				</tr>
			</table> 
	   </cfoutput>	
	</cfform>
</cfmodule>