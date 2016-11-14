<cfparam name="attributes.imgname" default="blank.gif">
<cfparam name="attributes.groupname" default="">
<cfparam name="attributes.B" default="0">
<cfparam name="Attributes.ShowMembers" default="0">

	<cfquery name="Members" datasource="#Application.DSN#">
		SELECT * 
		From GrpMembers G, Members M
		Where G.MemberID = M.MemberID
		AND G.GroupID = #GroupID#
		<cfif Attributes.ShowMembers EQ 0>
		 AND G.ISPrimary = True
		</cfif>
		Order By G.Ranking
	</cfquery>

<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tr>
		  <td><img src="/images/subsite/#Attributes.ImgName#" alt="#Attributes.GroupName#" border="0"></td>
	   </tr>
	   <cfif Attributes.ShowMembers EQ 1>
	    <tr bgcolor="##e9e2e1">
		  <td><font face="Tahoma" color="##003399" size="+1"><strong>Staff</strong></font></td>
		</tr>
		<tr bgcolor="##e9e2e1">
		   <td>
			 <table border="0" cellpadding="4" cellspacing="0" width="100%">
			   
					   <tr>
						 <td>
						   <font face="Arial, verdana, Helvetica,sans-serif" size="-1" color="##000000">
				
							   <cfloop query="Members">
							        <strong>#Members.Title#</strong><br>
								    #Members.Prefix# #Members.FirstName# #Members.MI# #Members.LastName#<br>
								    <cfif members.Phone NEQ "">#Members.Phone#<br></cfif>
									<cfif members.email NEQ ""><a href="mailto:#Members.Email#">#Members.email#</a><br></cfif><br>
							        
							   </cfloop>
						   </font>
						 </td>
					   </tr>
				   
			 </table>
		   </td>
		</tr>   	
		</cfif> 
	    <tr bgcolor="##e9e2e1">
		  <td><font face="Tahoma" color="##003399" size="+1"><strong>Content</strong></font></td>
		</tr>
		<tr bgcolor="##e9e2e1">
		   <td>
			 <table border="0" cellpadding="2" cellspacing="0" width="100%">
				<tr>
				   <td><a href="/bishop/index.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Home</font></a></td>
			    </tr>
				<tr>
				  <td><a href="/bishop/BishopProfile.cfm?b=1"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Bishop Persell</font></a></td>
				</tr>
				<cfquery name="GetSermon" datasource="#Application.dsn#">
				  Select Max(SermonID) as ThisSermonID
				  From Sermons
				  Where SermonType = 'SERMON'
				  AND BishopID = #Attributes.B#
				</cfquery>
				<cfquery name="GetMessage" datasource="#Application.dsn#">
				  Select Max(SermonID) as ThisSermonID
				  From Sermons
				  Where SermonType = 'MESG'
				  AND BishopID = #Attributes.B#
				</cfquery>
				
				<cfif Attributes.b Eq 1>
				 <tr>
				   <td>
				     <table border="0" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
				         <td width=10>&nbsp;</td>
				         <td><font face="verdana" size="-2">- <a href="BishopMessage.cfm?<cfif GetMessage.RecordCount GT 0>SID=#GetMessage.ThisSermonID#&</cfif>B=1&Type=MESG">Bishops Message</a></font></td>
				       </tr>
					   <tr>
				         <td width=10>&nbsp;</td>
				         <td><font face="verdana" size="-2">- <a href="BishopMessage.cfm?<cfif GetSermon.RecordCount GT 0>SID=#GetSermon.ThisSermonID#&</cfif>B=1&Type=SERMON">Sermons/Addresses</a></font></td>
				       </tr>
					   <tr>
				         <td width=10>&nbsp;</td>
				         <td><font face="verdana" size="-2">- <a href="VisitationSchedule.cfm?B=1">Visitation Schedule</a></font></td>
				       </tr>
                     </table>
				   </td>
				 </tr>
				</cfif>
				<tr>
				  <td><a href="/bishop/BishopProfile.cfm?b=2"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Bishop Scantlebury</font></a></td>
				</tr>
				<cfif Attributes.b Eq 2>
				 <tr>
				   <td>
				     <table border="0" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
				         <td width=10>&nbsp;</td>
				         <td><font face="verdana" size="-2">- <a href="BishopMessage.cfm?<cfif GetMessage.ThisSermonID GT 0>SID=#GetMessage.ThisSermonID#&</cfif>B=2&Type=MESG">Bishops Message</a></font></td>
				       </tr>
					   <tr>
				         <td width=10>&nbsp;</td>
				         <td><font face="verdana" size="-2">- <a href="BishopMessage.cfm?<cfif GetSermon.ThisSermonID GT 0>SID=#GetSermon.ThisSermonID#&</cfif>B=2&Type=SERMON">Sermons/Addresses</a></font></td>
				       </tr>
					   <tr>
				         <td width=10>&nbsp;</td>
				         <td><font face="verdana" size="-2">- <a href="VisitationSchedule.cfm?B=2">Visitation Schedule</a></font></td>
				       </tr>
                     </table>
				   </td>
				 </tr>
				</cfif>
				<tr>
				  <td><a href="/bishop/Bishops.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Chicago's Bishops</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/EpisHistory.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Episcopal History</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/EpisMinistry.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Episcopal Ministry</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/EpisInChicago.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Episcopal Ministry in Chicago</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/EpisSymbols.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Episcopal Symbols</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/MinofBishops.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Ministry of the Bishop</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/PhotoAlbum.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Photo Albums</font></a></td>
				</tr>
				<tr>
				  <td><a href="/bishop/visitationschedule.cfm"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Visitation Schedule</font></a></td>
				</tr>
				<tr>
				  <td>&nbsp;</td>
				</tr>
			 </table>
		   </td>
		</tr> 		
	</table>
</cfoutput>