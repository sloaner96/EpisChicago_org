
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: FAQ Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="FAQ Processing">

<font face="Verdana,Arial" size="-1">

<cfset ErrorList = ArrayNew(1)>

<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.Section# is "*">
		<cfset x = ArrayAppend(ErrorList, "No site specified in the <b>FAQ Site</b> field")>
	</CFIF>

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
				 Section,
				 Question,
				 Response,
				 Display,
				 Ranking,
				 DateCreated
				)
			VALUES
				('#Form.Category#',
				 '#Form.Section#',
				'#Form.Question#',
				'#Form.Answer#',
				1,
				#Form.Ranking#,
				#now()#
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New FAQ" Status="OK" Message="#Session.FullName# added FAQ: '#Form.Question#'" User="#Session.UserID#">

	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From FAQs
				WHERE FaqID = #Form.FaqID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete FAQ" Status="OK" Message="#Session.FullName# deleted FAQ: '#Form.Question#'" User="#Session.UserID#">

	<CFELSE>
		<CFQUERY Name="UpdInfo" Datasource="#Application.DSN#">
			UPDATE FAQs
			SET
				Category	= '#Form.Category#',
				Section		= '#Form.Section#',
				Question	= '#Form.Question#',
				Response	= '#Form.Answer#',
				Display		= True,
				Ranking		= #Form.Ranking#
			WHERE FaqID = #Form.FaqID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update FAQ" Status="OK" Message="#Session.FullName# updated FAQ: '#Form.Question#'" User="#Session.UserID#">

	</CFIF>

	<cflocation url="index.cfm" addtoken="No">

</cfif>

</font>

</CFMODULE>
</HTML>
