<cfparam name="Attributes.GroupID" default="0">
<cfparam name="Attributes.ShowAdmin" default="0">
<cfparam name="Attributes.ShowMembers" default="0">
<cfparam name="Attributes.NavImg" default="blank.gif">
<cfparam name="Attributes.GroupType" default="D">
<cfparam name="Attributes.GroupName" default="blank.gif">
<cfset GroupID = Attributes.GroupID>
<cfquery name="GetGroupContent" datasource="#Application.DSN#">
	SELECT C.*, L.CodeDesc
	  FROM GroupContent C, Lookups L
		WHERE C.ContentCode = L.CodeValue
		AND L.CodeGroup = 'CONTENT'
		AND C.GroupID = #groupid#
		ORDER BY C.RankOrder
</cfquery>


<cfif Attributes.ShowMembers EQ 1>
	<cfquery name="Members" datasource="#Application.DSN#">
		SELECT * 
		From GrpMembers G, Members M
		Where G.MemberID = M.MemberID
		AND G.GroupID = #GroupID#
		Order By G.Ranking, G.IsPrimary
	</cfquery>
</cfif>
<cfif GetGroupContent.recordcount GT 0>
	<cfoutput>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
		<cfif attributes.showAdmin EQ 1 AND GetGroupContent.recordcount GT 0>
		  <tr>
		    <td align="right"><cfif IsDefined("session.subusername")><font face="verdana" size="-2">Logged in as <strong>#Session.subUsername#</strong><br><a href="SiteAdmn/SiteAdmin.cfm">Admin Your Sites</a></font><cfelse><a href="javascript:void(0);" onclick="window.open('siteLogin.cfm?GroupID=#GroupID#', 'popupwin', 'height=250, width=300, top=200, left=250, scrollbars=no, resizable=no');self.name='main';"><font face="verdana" size="-1">[Login]</font></a></cfif></td>
		  </tr>
		 </cfif>
		  
		 <cfif Attributes.NavImg NEQ "">
		   <tr>
			  <td><img src="/images/subsite/#Attributes.NavImg#" alt="#Attributes.GroupName#" border="0"></td>
		   </tr>
		 </cfif>
		 
			 <tr>
			   <td <cfif attributes.grouptype EQ "D">bgcolor="##efefe6"<cfelseif attributes.grouptype EQ "M">bgcolor="##ffe6cd"<cfelseif attributes.grouptype EQ "C">bgcolor="##e0e4f3"<cfelseif attributes.grouptype EQ "B">bgcolor="##e9e2e1"</cfif>>
				 <table border="0" cellpadding="4" cellspacing="0" width="100%"> 
				  <cfif Attributes.ShowMembers EQ 1>
					   <tr>
						 <td>
						   <font face="Arial, verdana, Helvetica,sans-serif" size="-1" color="##000000">
				
							   <cfloop query="Members">
								    <cfif Members.StaffID NEQ ""><strong>#Members.Title#</strong><br></cfif>
								    #Members.Prefix# #Members.FirstName# #Members.MI# #Members.LastName#<br>
								    <cfif members.email NEQ ""><a href="mailto:#Members.Email#">#Members.email#</a><br></cfif>
									<cfif Members.StaffID NEQ "" AND Members.Phone NEQ "">#Members.Phone#<br></cfif><br>
							   </cfloop>
						   </font>
						 </td>
					   </tr>
				   </cfif>
				   <cfif GetGroupContent.recordcount GT 0>
					   <tr>
						 <td><font face="Tahoma" color="##003399" size="+1"><strong>Content</strong></font></td>
					   </tr>
					   <tr>
					     <td>
						   <table border="0" cellpadding="0" cellspacing="0" width="100%">
						      <tr>
				                  <td><a href="/diocese/offices/index.cfm?GroupID=#groupid#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1">Home</font></a></td>
				              </tr>
				              <cfloop query="GetGroupContent">
							    <cfswitch expression="#ContentCode#">
								   <!--- Events --->
								   <cfcase value="01">
								     <cfquery name="CheckEvent" datasource="#Application.DSN#">
									    Select Count(*) as EventExists
										From Events
										Where OwningGroupID = #groupid#
									 </cfquery>
									 <cfif CheckEvent.EventExists GT 0>
								       <tr>
				                          <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                       </tr>
									 </cfif> 
								   </cfcase>
								   <!--- Member Roster --->
								   <cfcase value="02">
								      <cfquery name="CheckMembers" datasource="#Application.DSN#">
		                                 SELECT Count(*) as MemberExists
		                                 From GrpMembers G
		                                 Where G.GroupID = #GroupID#
	                                  </cfquery> 
									  <cfif CheckMembers.MemberExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- FAQs --->
								   <cfcase value="03">
								      <cfquery name="CheckFAQ" datasource="#Application.DSN#">
		                                 SELECT Count(*) as FAQExists
		                                 From FAQs
		                                 Where GroupID = #GroupID#
	                                  </cfquery> 
									  <cfif CheckFAQ.FAQExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- FORMS --->
								   <cfcase value="04">
								      <cfquery name="CheckForm" datasource="#Application.DSN#">
		                                 SELECT Count(*) as FormExists
		                                 From Resources R, GrpResources G
		                                 Where R.ResourceID = G.ResourceID 
										 AND G.GroupID = #GroupID#
										 AND R.ResourceType = 'F'
	                                  </cfquery> 
									  <cfif CheckForm.FormExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- ListServ --->
								   <cfcase value="05">
								      <cfquery name="CheckForm" datasource="#Application.DSN#">
		                                 SELECT Count(*) as FormExists
		                                 From Resources R, GrpResources G
		                                 Where R.ResourceID = G.ResourceID 
										 AND G.GroupID = #GroupID#
										 AND R.ResourceType = 'S'
	                                  </cfquery> 
									  <cfif CheckForm.FormExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- Policies --->
								   <cfcase value="06">
								      <cfquery name="CheckForm" datasource="#Application.DSN#">
		                                 SELECT Count(*) as FormExists
		                                 From Resources R, GrpResources G
		                                 Where R.ResourceID = G.ResourceID 
										 AND G.GroupID = #GroupID#
										 AND R.ResourceType = 'P'
	                                  </cfquery> 
									  <cfif CheckForm.FormExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- Programs --->
								   <cfcase value="07">
								     <cfquery name="CheckPrograms" datasource="#Application.DSN#">
		                                 SELECT Count(*) as ProgramExists
		                                 From GrpPrograms G, Programs P
		                                 Where G.programID = P.ProgramID 
										 AND P.EndDate >= #Createodbcdate(now())#
										 AND P.Approved = True
										 AND G.GroupID = #GroupID#
	                                  </cfquery> 
									  <cfif CheckPrograms.ProgramExists GT 0>
								      <tr>
				                         <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                      </tr>
									  </cfif>
								   </cfcase>
								   <!--- Resources --->
								   <cfcase value="08">
								     <cfquery name="CheckRec" datasource="#Application.DSN#">
		                                 SELECT Count(*) as RecExists
		                                 From GrpResources
		                                 Where GroupID = #GroupID#
	                                  </cfquery> 
									  <cfif CheckRec.RecExists GT 0>
								      <tr>
				                         <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                      </tr>
									  </cfif>
								   </cfcase>
								   <!--- Photo Albums --->
								   <cfcase value="09">
								      <cfquery name="CheckPhoto" datasource="#Application.DSN#">
		                                 SELECT Count(*) as AlbumExists
		                                 From Album
		                                 Where GroupID = #GroupID#
	                                  </cfquery> 
									  <cfif CheckPhoto.AlbumExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- NewsLetters --->
								   <cfcase value="10">
								      <cfquery name="CheckForm" datasource="#Application.DSN#">
		                                 SELECT Count(*) as FormExists
		                                 From Resources R, GrpResources G
		                                 Where R.ResourceID = G.ResourceID 
										 AND G.GroupID = #GroupID#
										 AND R.ResourceType = 'N'
	                                  </cfquery> 
									  <cfif CheckForm.FormExists GT 0>
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								   <!--- Meetings --->
								   <cfcase value="11">
								     <cfquery name="CheckMeeting" datasource="#Application.DSN#">
		                                 SELECT Meetings
		                                 From GroupNfo
		                                 Where GroupID = #GroupID#
										 AND Meetings IS NOT NULL
	                                  </cfquery>
									  <cfif CheckMeeting.Meetings NEQ "">
								        <tr>
				                           <td><a href="siteContent.cfm?GroupID=#groupid#&GCID=#ContentCode#"><font face="Arial, verdana, Helvetica,sans-serif" size="-1"><cfif GetGroupContent.MenuName EQ "">#GetGroupContent.CodeDesc#<cfelse>#GetGroupContent.MenuName#</cfif></font></a></td>
				                        </tr>
									  </cfif>
								   </cfcase>
								</cfswitch>
							  
							    
				              </cfloop>
						   </table>
						 </td>
					   </tr>
				   </cfif>
				 </table>
			  </td>
			 </tr>
		 </table>
	</cfoutput>
</cfif>