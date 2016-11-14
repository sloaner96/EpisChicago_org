<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="url.e" default="0">
<html>
<head>
	<title>Chicago Diocese: Login</title>
</head>

<body bgcolor="#dfe0c5" onunload="window.opener.document.location.reload()">
<cfif Not IsDefined("form.username")>
	<cfform name="login" action="siteLogin.cfm" method="POST">
		<cfoutput>
		   <input type="hidden" name="groupID" value="#url.GroupID#">
		</cfoutput>
		<table border="0" cellpadding="3" cellspacing="0">
		 <tr>
		   <td colspan=2><font color="#003399" face="tahoma" size="+1">LOGIN</font></td>
		 </tr>
		  <tr>
		    <td colspan=2><font face="verdana" size="-2">Login to administer the content of this site.</font></td>
		  </tr>
		  <cfif url.e EQ 1>
		    <tr>
		      <td colspan=2 align="center"><font face="verdana" color="cc0000" size="-1"><strong>Error! Your username or password was incorrect.</strong></font></td>
		    </tr>
		  </cfif>
		  <tr>
		    <td><font face="arial" size="-1"><strong>Username:</strong></font></td>
			<td><cfinput type="text" name="username" size="15" maxlength="15" required="Yes" message="You must enter a username"></td>
		  </tr>
		  <tr>
		    <td><font face="arial" size="-1"><strong>Password:</strong></font></td>
			<td><cfinput type="Password" name="password" size="15" maxlength="15"></td>
		  </tr>
		  <tr>
		    <td>&nbsp;</td>
		  </tr>
		  <tr>
		    <td colspan="2" align="center"><input type="reset" name="reset" value="reset">&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Login"></td>
		  </tr>
		</table>
	</cfform>
<cfelse>
   <cfquery name="GetLogin" datasource="#Application.dsn#">
     Select M.*
	 From Members M, GrpMembers G
	 where G.MemberID = M.MemberID
	 and M.Username = '#form.username#'
	 and M.pswd = '#form.password#'
	 and G.IsAdmin = True
	 and g.groupID = #form.groupID#
   </cfquery>	
<!---   <cfif GetLogin.StaffID NEQ "">
	   <cfquery name="GetStaff" datasource="#Application.dsn#">
	     Select *
		 From Staff
		 where StaffID = #GetLogin.StaffID#
	   </cfquery>	
   </cfif> --->
   <cfif getLogin.recordcount GT 0>
      <cfset newLoginCount = GetLogin.NLogins + 1>
     <cfquery name="UpdateMember" datasource="#Application.dsn#">
	   Update Members
	   Set Nlogins = #newLoginCount#,
	       LastLogin = #createodbcdatetime(now())#
	   Where MemberID = #GetLogin.MemberID#	   
	 </cfquery>
	 <cflock name="SitesessionVars" timeout="30" throwontimeout="No" type="EXCLUSIVE">
	  <cfset Session.subUserID = getLogin.MemberID>
	  <cfset Session.SubUsername = getLogin.Username>
<!---	  <cfif GetLogin.StaffID EQ ""> --->
	     <cfset Session.subUserFullname = "#GetLogin.Prefix# #getLogin.FirstName# #Getlogin.LastName#">
	     <cfset Session.subUserFname = getLogin.FirstName>
	     <cfset Session.subUserLname = getLogin.LastName>
<!---	  <cfelse>
	     <cfset Session.subUserFullname = "#GetStaff.Prefix# #getStaff.FirstName# #GetStaff.LastName#">
	     <cfset Session.subUserFname = getstaff.FirstName>
	     <cfset Session.subUserLname = getstaff.LastName>
	  </cfif> --->
	 </cflock>
	 
	 <cfoutput>
	   <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
            <td align="center"><font face="arial" size="-1"><strong><font color="##008000">You have Successfully Logged In</font></strong><br><br>Click <a href="SiteAdmn/SiteAdmin.cfm?groupID=#form.groupID#" target="main" onclick="window.close();">Here</a> to close this window and administer content on this site.</font></td>
         </tr>
       </table>
	 </cfoutput>
   <cfelse>
     <cflocation url="siteLogin.cfm?e=1&groupID=#form.groupID#" addtoken="No">	 
   </cfif>
</cfif>
</body>
</html>
