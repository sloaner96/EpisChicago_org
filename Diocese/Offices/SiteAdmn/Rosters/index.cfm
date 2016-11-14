
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Maintain Member Information</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  pagetitle="Maintain Member Roster">
<cfoutput>
<div align="right"><a href="../EditSite.cfm?groupID=#url.groupid#"><font face="tahoma" size="-1">Back to Subsite Admin</font></a></div>
</cfoutput>
<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td valign="Top">
	  <cfquery name="GetMembers" datasource="#Application.dsn#">
	    Select M.*
		From Members M, GrpMembers G
	    Where M.MemberID = G.MemberID
		AND G.GroupID = #url.GroupID#
		Order By G.IsPrimary, G.Ranking, StaffID, M.LastName, M.Firstname
	  </cfquery>
	  
	<font face="Verdana" size="-1">
	   <p>Below are the members that currently belong to this group. You can click the individuals name to update information about the person or you can click the add a member link to the right and you may add a new member to this group.</p>
	</font>
	   <div>
	      <cfoutput>
		     <font face="tahoma" size="-1">
	            <a href="AddMember.cfm?GroupID=#url.GroupID#">ADD NEW MEMBER</a><br>
			 </font>
          </cfoutput>
	   </div>
	  <br>	<center>
	   <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="eeeeee">
	        <tr bgcolor="#6d6d6d">
			  <td><font face="verdana" color="ffffff" size="-1"><strong>Member Name</strong></font></td>
			  <td><font face="verdana" color="ffffff" size="-1"><strong>Email Address</strong></font></td>
			  <td><font face="verdana" color="ffffff" size="-1"><strong>Phone Number</strong></font></td>
			  <td>&nbsp;</td>
			</tr>  
	  <cfif Getmembers.recordcount GT 0>
          <cfoutput query="GetMembers">
			    <tr bgcolor="ffffff">
	               <td valign="top"><font face="arial" size="-1">#GetMembers.Prefix# #GetMembers.Firstname# #GetMembers.Lastname# #Suffix#</font></td>
				   <td valign="top"><font face="arial" size="-1">#GetMembers.email#</font></td>
				   <td valign="top"><font face="arial" size="-1">#GetMembers.Phone#</font></td>
				   <td align="center"><font face="verdana" size="-1"><cfif GetMembers.StaffID EQ ""><a href="EditRoster.cfm?ID=#Getmembers.MemberID#&GroupID=#Url.GroupID#">EDIT</a> |</cfif> <cfif MemberID NEQ Session.subUserID><a href="UpdateRoster.cfm?GroupID=#Url.GroupID#&ID=#MemberID#&Action=Delete" style="color:red">REMOVE<a/></cfif></font></td>
	            </tr>
		  </cfoutput>
	   <cfelse>
	   
            <tr bgcolor="ffffff">
               <td align="Center" colspan=5><font face="arial" color="acacac" size="-1"><strong>NO MEMBERS ARE ASSIGNED TO THIS GROUP</strong></font></td>
            </tr>
         
	   </cfif>
	   </table>
	</center>
   </td>
  </tr>
</table>
</CFMODULE>

</HTML>