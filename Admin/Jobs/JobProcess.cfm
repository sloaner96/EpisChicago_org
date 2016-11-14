<CFIF NOT IsDefined("Form.MarketID")>
	<CFLOCATION URL="/Admin/default.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: MarketPlace Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="MarketPlace Job Processing">


<cfset ErrorList = ArrayNew(1)>
<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.Title# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Title</b> field")>
	</CFIF>
	
	<CFIF #Form.Contact# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Contact</b> field")>
	</CFIF>
	
	<CFIF IsDefined("Form.Parish")>
		<cfif #Form.Parish# is "*">
			<cfset x = ArrayAppend(ErrorList, "You must specify a <b>Parish</b>")>
		</cfif>
	<cfelseif Form.Location is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Location</b> field")>
	</CFIF>

	<CFIF #Form.Phone# is "" AND Form.EMail is "">
		<cfset x = ArrayAppend(ErrorList, "You must specify a value for either the <b>Phone</b> or <b>EMail Address</b> field")>
	</CFIF>

	<CFIF #Form.JobDesc# is "">
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
			INSERT into MarketJobs
				(Title,
				 <cfif IsDefined("Form.Location")>
				 Location,
				 <cfelse>
				 DirectID,
				 </cfif>
				 Contact,
				 ContactPhone,
				 ContactEmail,
				 <cfif Form.DateExpires is not "">
				 ExpiresOn,
				 </cfif>
				 DateCreated,
				 Description
				)
			VALUES
				('#Form.Title#',
				 <cfif IsDefined("Form.Location")>
				 '#Form.Location#',
				 <cfelse>
				 #Form.Parish#,
				 </cfif>
				 '#Form.Contact#',
				 '#Form.Phone#',
				 '#Form.EMail#',
				 <cfif Form.DateExpires is not "">
				 #CreateODBCDate(Form.DateExpires)#,
				 </cfif>
				 #CreateODBCDate(now())#,
				 '#Form.JobDesc#'
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Job" Status="OK" Message="#Session.FullName# added Job: '#Form.Title#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Job Opening has been Entered!</FONT></H3>
	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From MarketJobs
				WHERE MarketID = #Form.MarketID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Job" Status="OK" Message="#Session.FullName# deleted Job: '#Form.Title#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Job Opening has been Removed!</FONT></H3>
	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE MarketJobs
			SET
				Title		= '#Form.Title#',
				<cfif IsDefined("Form.Location")>
				Location	= '#Form.Location#',
				<cfelse>
				DirectID		= #Form.Parish#,
				</cfif>
				Contact		= '#Form.Contact#',
				ContactPhone= '#Form.Phone#',
				ContactEMail= '#Form.EMail#',
				<cfif Form.DateExpires is not "">
				ExpiresOn	= #CreateODBCDate(Form.DateExpires)#,
				</cfif>
				Description	= '#Form.JobDesc#'
			WHERE MarketID = #Form.MarketID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Job" Status="OK" Message="#Session.FullName# updated Job: '#Form.Title#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Job Opening has been Updated!</FONT></H3>
	</CFIF>

</cfif>

<p align=center><a href="/Admin/"><font face="Tahoma" color="Maroon" size="+1">Return to Admin Page</font></a></p>

</CFMODULE>

</HTML>
