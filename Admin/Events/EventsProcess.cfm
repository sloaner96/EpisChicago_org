<CFIF NOT IsDefined("Form.Heading")>
	<CFLOCATION URL="/Admin/EventSearch.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Event Processing">

<cfset ErrorList = ArrayNew(1)>

<CFIF #Form.Heading# is "">
	<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Heading</b> field")>
</CFIF>

<CFIF #Form.SDate# is "" OR (#Form.SDate# is not "" and NOT #IsDate(Form.SDate)#)>
	<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Beginning Date & Time</b> field")>
</CFIF>

<CFIF #Form.EDate# is not "" and NOT #IsDate(Form.EDate)#>
	<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Ending Date & Time</b> field")>
</CFIF>

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

	<cfset EndingDate = Form.EDate>
	<cfif Form.EDate is "">
		<cfset EndingDate = DateFormat(CreateODBCDate("#Form.SDate#"), "mm/d/yyyy") + "11:59pm">
	</cfif>

	<!--- ****************************************************** --->
	<!--- Process the Record here 						 --->

	<CFIF Left(Form.Cmd, 4) is "Save">
		<CFQUERY Name="AddRec" Datasource="#Application.DSN#">
			INSERT into Events
				(EventName,
				 BeginDate,
				 Location,
				 Contact,
				 Approved,
				 EndDate,
				 Phone,
				 ContactEmail,
				 URL,
				 Category,
				 <!--- EventGroup, --->
				 DiocesanWide,
				 Highlight,
				 Description
				)
			VALUES
				('#Form.Heading#',
				 #CreateODBCDateTime(Form.SDate)#,
				 '#Form.Location#',
				 '#Form.Contact#',
				 1,
			 	 #CreateODBCDateTime(EndingDate)#,
				 '#Form.Phone#',
				 '#Form.Email#',
				 '#Form.WebURL#',
				 <cfif Form.Category is not "*">'#Form.Category#'<cfelse>NULL</cfif>,
				 <!--- <cfif Form.EGroup is not "*">'#Form.EGroup#'<cfelse>NULL</cfif>, --->
				 1,
				 <cfif IsDefined("Form.DateWatch")>1<cfelse>0</cfif>,
				 '#Form.Description#'
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Event" Status="OK" Message="#Session.FullName# created Event: '#Form.Heading#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your Event has been Entered!</FONT></H3>
	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From Events
				WHERE EventID = #Form.EventID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Event" Status="OK" Message="#Session.FullName# deleted Event: '#Form.Heading#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your Event has been Removed!</FONT></H3>
	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE Events
			SET
				EventName	= '#Form.Heading#',
				BeginDate	= #CreateODBCDateTime(Form.SDate)#,
				Location	= '#Form.Location#',
				Contact		= '#Form.Contact#',
				EndDate		= #CreateODBCDateTime(EndingDate)#,
				Phone		= '#Form.Phone#',
				ContactEmail= '#Form.Email#',
				URL			= '#Form.WebURL#',
				Category	= <cfif Form.Category is not "*">'#Form.Category#'<cfelse>NULL</cfif>,
				<!--- EventGroup	= <cfif Form.EGroup is not "*">'#Form.EGroup#'<cfelse>NULL</cfif>, --->
				Highlight	= <cfif IsDefined("Form.DateWatch")>1<cfelse>0</cfif>,
				Description	= '#Form.Description#'
			WHERE EventID = #Form.EventID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Modify Event" Status="OK" Message="#Session.FullName# updated Event: '#Form.Heading#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your Event has been Updated!</FONT></H3>
	</CFIF>

</cfif>

<p align=center><a href="/Admin/"><font face="Tahoma" color="Maroon" size="+1">Return to Admin Page</font></a></p>

</CFMODULE>

</HTML>
