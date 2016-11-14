<CFIF NOT IsDefined("Form.BishID")>
	<CFLOCATION URL="VisitSearch.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Visitation Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Visitation Processing">

<cfset ErrorList = ArrayNew(1)>

<CFIF #Form.BishID# is "*">
	<cfset x = ArrayAppend(ErrorList, "You must identify which <b>Bishop</b> will visit this Parish!")>
</CFIF>

<CFIF #Form.VDate# is "" OR (#Form.VDate# is not "" and NOT #IsDate(Form.VDate)#)>
	<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Visit Date & Time</b> field")>
</CFIF>

<CFIF #Form.Parish# is "*">
	<cfset x = ArrayAppend(ErrorList, "You must identify which <b>Parish</b> will be visited!")>
</CFIF>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors is 0 AND Left(Form.Cmd,4) is "Save">
	<cfquery name="ChkRec" datasource="#Application.DSN#">
		SELECT * From Visitations
			WHERE VisitDate = #CreateODBCDate(Form.VDate)#
				AND BishopID = #Form.BishID#
	</cfquery>
	<cfif ChkRec.RecordCount gt 0>
		<cfset x = ArrayAppend(ErrorList, "You have already entered a Visitation record for the date of #Form.VDate#!")>
	</cfif>
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
			INSERT into Visitations
				(BishopID,
				 VisitDate,
				 OrgID,
				 Notes
				)
			VALUES
				(#Form.BishID#,
				 #CreateODBCDate(Form.VDate)#,
				 #Form.Parish#,
				 '#Form.Notes#'
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Visitation" Status="OK" Message="#Session.FullName# added Visitation on '#Form.VDate#'" User="#Session.UserID#">

	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From Visitations
				WHERE VisitID = #Form.VisitID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Visitation" Status="OK" Message="#Session.FullName# deleted Visitation Entry for '#Form.VDate#'" User="#Session.UserID#">

	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE Visitations
			SET
				BishopID	= #Form.BishID#,
				VisitDate	= #CreateODBCDate(Form.VDate)#,
				OrgID		= #Form.Parish#,
				Notes		= '#Form.Notes#'
			WHERE VisitID = #Form.VisitID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Modify Visitation" Status="OK" Message="#Session.FullName# updated Visitation Entry for '#Form.VDate#'" User="#Session.UserID#">

	</CFIF>

</cfif>

<cflocation url="ListVisits.cfm?BishID=#Form.BishID#" addtoken="No">

</CFMODULE>

</HTML>
