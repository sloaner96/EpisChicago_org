<cfparam name="attributes.imgname" default="">
<cfparam name="attributes.groupname" default="">
<cfparam name="attributes.B" default="0">
<cfparam name="Attributes.ShowMembers" default="1">

<cfif Attributes.ShowMembers EQ 1>
	<cfquery name="Members" datasource="#Application.DSN#">
		SELECT * 
		From GrpMembers G, Members M
		Where G.MemberID = M.MemberID
		AND G.GroupID = #GroupID#
		Order By G.Ranking
	</cfquery>
</cfif>
<cfoutput>
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
	   <cfif Attributes.imgname NEQ "">
	   <tr>
		  <td><img src="/images/subsite/#Attributes.ImgName#" alt="#Attributes.GroupName#" border="0"></td>
	   </tr>
	   </cfif>
	   <tr bgcolor="##e6f2ff">
		  <td><font face="verdana" size="-2"><strong>65 E. Huron<br>Chicago, IL 60611<br>(312) 751-6721</strong><br><a href="mailto:eccs@attglobal.net">eccs@attglobal.net</a></font></td>
		</tr>
	   <cfif Attributes.ShowMembers EQ 1>
	   <tr bgcolor="##e6f2ff">
	     <td>&nbsp;</td>
	   </tr>
	    <tr bgcolor="##e6f2ff">
		  <td><font face="Tahoma" color="##003399" size="+1"><strong>Staff</strong></font></td>
		</tr>
		<tr bgcolor="##e6f2ff">
		   <td>
			 <table border="0" cellpadding="4" cellspacing="0" width="100%">
			   <cfloop query="Members">
					   <tr>
						 <td>
						   <font face="Arial, verdana, Helvetica,sans-serif" size="-1" color="##000000">
									  <strong>#Members.Title#</strong><br>
									  #Members.Prefix# #Members.FirstName# <cfif members.mi NEQ "">#Members.MI#</cfif> #Members.LastName#<br>
								    <cfif Members.email NEQ ""><a href="mailto:#members.Email#">#Members.email#</a><br></cfif>
									<cfif Members.phone NEQ "">(312) #ReplaceList(Members.Phone, "(312),312-,312.,312", "")#</cfif>
						   </font>
						 </td>
					   </tr>
				   </cfloop>
			 </table>
		   </td>
		</tr>  
		<tr bgcolor="##e6f2ff">
	     <td>&nbsp;</td>
	   </tr> 	
		</cfif> 
	    <tr bgcolor="##e6f2ff">
		  <td><font face="Tahoma" color="##003399" size="+1"><strong>Content</strong></font></td>
		</tr>
		<tr bgcolor="##e6f2ff">
		  <td>
		    <table border="0" cellpadding="4" cellspacing="0" width="100%">
              <tr>
			   <td><a href="EpisCharCalendar.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Calendar</font></a></td>
			  </tr>
			  <tr>
               <td><a href="EpisCharFAQ.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">FAQ</font></a></td>
              </tr>
            </table>
		  </td>
		</tr> 		
	</table>
</cfoutput>