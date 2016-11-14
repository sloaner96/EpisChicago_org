<CFIF NOT IsDefined("Form.LinkID")>
	<CFLOCATION URL="default.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Web Link Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Web Link Processing">

<cfset ErrorList = ArrayNew(1)>

<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.SiteName# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Web Site</b> field")>
	</CFIF>
	
	<CFIF #Form.WebURL# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Web URL</b> field")>
	</CFIF>

	<CFIF #Form.Category# is "*">
		<cfset x = ArrayAppend(ErrorList, "You must specify a <b>Category</b> for this Web Link")>
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
			INSERT into SiteLinks
				(SiteName,
				 SiteURL,
				 Category,
				 Description
				)
			VALUES
				('#Form.SiteName#',
				 '#Form.WebURL#',
				 #Form.Category#,
				 '#Form.Description#'
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Link" Status="OK" Message="#Session.FullName# added Link: '#Form.SiteName#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Link has been Entered!</FONT></H3>
	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From SiteLinks
				WHERE LinkID = #Form.LinkID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Link" Status="OK" Message="#Session.FullName# deleted Link: '#Form.SiteName#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Link has been Removed!</FONT></H3>
	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE SiteLinks
			SET
				SiteName	= '#Form.SiteName#',
				SiteURL		= '#Form.WebURL#',
				Category	= #Form.Category#,
				Description	= '#Form.Description#'
			WHERE LinkID = #Form.LinkID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Link" Status="OK" Message="#Session.FullName# updated Link: '#Form.SiteName#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Link has been Updated!</FONT></H3>
	</CFIF>

</cfif>

<p align=center><a href="/Admin/"><font face="Tahoma" color="Maroon" size="+1">Return to Admin Page</font></a></p>

</CFMODULE>

</HTML>
