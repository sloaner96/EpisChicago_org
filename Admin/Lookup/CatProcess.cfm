<CFIF NOT IsDefined("Form.CValue")>
	<CFLOCATION URL="default.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Category Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Category Processing">

<cfset ErrorList = ArrayNew(1)>

<cfif Left(Form.Cmd, "6") is not "Delete">
	<cfif Left(Form.Cmd, "4") is "Save" AND Form.CValue is not "">
		<cfquery name="ChkID" datasource="#Application.DSN#">
			SELECT CodeID From Lookups
				WHERE CodeGroup = '#Form.CG#' AND CodeValue = '#Form.CValue#'
		</cfquery>
		<cfif ChkID.RecordCount gt 0>
			<cfset x = ArrayAppend(ErrorList, "Category value <b>#Form.CValue#</b> is already defined!")>
		</cfif>
	</cfif>

	<CFIF #Form.CG# is "*">
		<cfset x = ArrayAppend(ErrorList, "You must specify a <b>Category</b> for this Entry")>
	</CFIF>

	<CFIF #Form.CValue# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Entry Code</b> field")>
	</CFIF>
	
	<CFIF #Form.CDesc# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Description</b> field")>
	</CFIF>

</cfif>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<!--- ****************************************************** --->
	<!--- Process the Record here 						 --->

	<CFIF Left(Form.Cmd, 4) is "Save">
		<CFQUERY Name="AddRec" Datasource="#Application.DSN#">
			INSERT into Lookups
				(CodeGroup,
				 CodeValue,
				 CodeDesc
				)
			VALUES
				('#Form.CG#',
				 '#Form.CValue#',
				 '#Form.CDesc#'
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Code" Status="OK" Message="#Session.FullName# added Code: '#Form.CDesc#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Code has been Entered!</FONT></H3>
	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From Lookups
				WHERE CodeID = #Form.LookupID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Code" Status="OK" Message="#Session.FullName# deleted Code: '#Form.CDesc#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Code has been Removed!</FONT></H3>
	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE Lookups
			SET
				CodeGroup	= '#Form.CG#',
				CodeValue	= '#Form.CValue#',
				CodeDesc	= '#Form.CDesc#'
			WHERE CodeID = #Form.LookupID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Code" Status="OK" Message="#Session.FullName# updated Code: '#Form.CDesc#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Code has been Updated!</FONT></H3>
	</CFIF>

	<cflocation url="ListCodes.cfm?CG=#Form.CG#" addtoken="No">

</cfif>

<p align=center><a href="/Admin/"><font face="Tahoma" color="Maroon" size="+1">Return to Admin Page</font></a></p>

</CFMODULE>

</HTML>
