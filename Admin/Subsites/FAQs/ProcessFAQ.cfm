
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: FAQ Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin"  PageTitle="FAQ Processing">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
			<td valign="Top">
				<font face="Verdana,Arial" size="-1">
				
				<cfset ErrorList = ArrayNew(1)>
				
				<cfif Left(Form.Cmd, "6") is not "Delete">
				
					<CFIF #Form.Question# is "">
						<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Question</b> field")>
					</CFIF>
					
					<CFIF #Form.Answer# is "">
						<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Answer</b> field")>
					</CFIF>
					
					<CFIF #Form.Category# is "*">
						<cfset x = ArrayAppend(ErrorList, "No item specified for the <b>Category</b> field")>
					</CFIF>
				</cfif>
				
				<cfset NErrors = ArrayLen(ErrorList)>
				<cfif NErrors gt 0>
				
					<cfoutput>
					<h4><font color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
					</cfoutput>
					<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
					<ol>
					<cfloop INDEX="i" FROM="1" TO="#NErrors#">
					<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
					</cfloop>
					</ol>
					<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>
				
				<cfelse>
				
					<CFIF Left(Form.Cmd, 4) is "Save">
						<CFQUERY Name="AddInfo" Datasource="#Application.DSN#">
							INSERT into FAQs
								(Category,
								 GroupID,
								 Section,
								 Question,
								 Response,
								 Display,
								 Ranking,
								 DateCreated
								)
							VALUES
								('#Form.Category#',
								  #Form.GroupID#,
								 'GROUP',
								'#Form.Question#',
								'#Form.Answer#',
								1,
								#Form.Ranking#,
								#now()#
								)
						</CFQUERY>
						
					<CFELSEIF Left(Form.Cmd, "6") is "Delete">
						<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
							DELETE From FAQs
								WHERE FaqID = #Form.FaqID#
						</CFQUERY>
					
					<CFELSE>
						<CFQUERY Name="UpdInfo" Datasource="#Application.DSN#">
							UPDATE FAQs
							SET
								Category	= '#Form.Category#',
								Question	= '#Form.Question#',
								Response	= '#Form.Answer#',
								Display		= True,
								Ranking		= #Form.Ranking#
							WHERE FaqID = #Form.FaqID#
						</CFQUERY>

				
					</CFIF>
				
					<cflocation url="index.cfm?groupID=#form.GroupID#" addtoken="No">
				
				</cfif>
				
				</font>
	  </td>
	</tr>
</table>
</CFMODULE>
</HTML>
