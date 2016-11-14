<CFIF NOT IsDefined("Form.ClericalID")>
	<CFLOCATION URL="index.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Clergy Job Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Clergy Job Processing">


<cfset ErrorList = ArrayNew(1)>
<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.Parish# is "*">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Parish</b> field")>
	</CFIF>
	
	<CFIF #Form.JobOpen# is "*">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Open Position</b> field")>
	</CFIF>
	
	<CFIF #Form.JobDesc# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Job Description</b> field")>
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
		<CFQUERY Name="AddRec" Datasource="#Application.DSN#">
			INSERT into ClergyJobs
				(OrgID,
				 JobType,
				 Filled,
				 Receiving,
				 Description,
				 LastUpdated
				)
			VALUES
				(#Form.Parish#,
				'#Form.JobOpen#',
				<cfif IsDefined("Form.Filled")>1<cfelse>0</cfif>,
				<cfif IsDefined("Form.Receiving") and Form.JobOpen neq "10">1<cfelse>0</cfif>,
				 '#Form.JobDesc#',
				 #now()#
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New ClergyJob" Status="OK" Message="#Session.FullName# added Clergy Job Opening at : '#Form.Parish#'" User="#Session.UserID#">

	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From ClergyJobs
				WHERE ClericalID = #Form.ClericalID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete ClergyJob" Status="OK" Message="#Session.FullName# deleted Clergy Job at: '#Form.Parish#'" User="#Session.UserID#">

	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE CLergyJobs
			SET
				OrgID		= #Form.Parish#,
				JobType		= '#Form.JobOpen#',
				Filled		= <cfif IsDefined("Form.Filled")>1<cfelse>0</cfif>,
				Receiving	= <cfif IsDefined("Form.Receiving") and Form.JobOpen neq "10">1<cfelse>0</cfif>,
				Description	= '#Form.JobDesc#',
				LastUpdated	= #now()#
			WHERE ClericalID = #Form.ClericalID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update ClergyJob" Status="OK" Message="#Session.FullName# updated Clergy Job at: '#Form.Parish#'" User="#Session.UserID#">

	</CFIF>

</cfif>

<cflocation url="index.cfm" addtoken="No">

</CFMODULE>

</HTML>
