<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>

<CFIF NOT IsDefined("Form.Heading")>
	<CFLOCATION URL="EventSearch.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  PageTitle="Site Administration" SubTitle="Event Processing">

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
		<CFQUERY Name="AddRec" Datasource="#Application.dsn#">
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
				 Highlight,
				 GrpHighlight,
				 Description,
				 OwningGroupID,
				 DiocesanWide
				)
			VALUES
				('#Form.Heading#',
				 #CreateODBCDateTime(Form.SDate)#,
				 '#Form.Location#',
				 '#Form.Contact#',
				 <cfif IsDefined("Form.DiocesanWide")>0,<cfelse>1,</cfif>
			 	 #CreateODBCDateTime(EndingDate)#,
				 '#Form.Phone#',
				 '#Form.Email#',
				 '#Form.WebURL#',
				 null,
				  0,
				  <cfif IsDefined("Form.GrpHighlight")>1,<cfelse>0,</cfif>
				  '#Form.Description#',
				   #Form.GroupID#, 
				  <cfif IsDefined("Form.DiocesanWide")>1<cfelse>0</cfif>
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Event" Status="OK" Message="#Session.subUserFullName# created Event: '#Form.Heading#'" User="#Session.SubUserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your Event has been Entered!</FONT></H3>
	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.dsn#">
			DELETE From Events
				WHERE EventID = #Form.EventID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Event" Status="OK" Message="#Session.subUserFullName# deleted Event: '#Form.Heading#'" User="#Session.subUserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your Event has been Removed!</FONT></H3>
	<CFELSE>
		<CFQUERY Name="UpdRec" Datasource="#Application.dsn#">
			UPDATE Events
			SET
				EventName	 = '#Form.Heading#',
				BeginDate	 = #CreateODBCDateTime(Form.SDate)#,
				Location	 = '#Form.Location#',
				Contact		 = '#Form.Contact#',
				EndDate		 = #CreateODBCDateTime(EndingDate)#,
				Phone		 = '#Form.Phone#',
				ContactEmail = '#Form.Email#',
				URL			 = '#Form.WebURL#',
				<cfif IsDefined("Form.DiocesanWide")>
				 DiocesanWide = True,
				 Approved = 0,
				<cfelse>
				 DiocesanWide = 0,
				</cfif>
				<!--- Category	 = <cfif Form.Category is not "*">'#Form.Category#'<cfelse>NULL</cfif>, --->
				GrpHighlight = <cfif IsDefined("Form.GrpHighlight")>1<cfelse>0</cfif>,
				Description	 = '#Form.Description#'
			WHERE EventID = #Form.EventID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Modify Event" Status="OK" Message="#Session.subUserFullName# updated Event: '#Form.Heading#'" User="#Session.subUserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your Event has been Updated!</FONT></H3>
	</CFIF>

</cfif>
<cfoutput>
<p align=center><a href="NewEvents.cfm?GroupID=#Form.groupID#"</a><font face="Tahoma" color="Maroon" size="+1">Add a New Event</font></a></p>
<p align=center><a href="EventSearch.cfm?GroupID=#Form.groupID#"</a><font face="Tahoma" color="Maroon" size="+1">Update Events</font></a></p>
<p align=center><a href="/Diocese/Offices/SiteAdmn/Editsite.cfm?GroupID=#Form.groupID#"</a><font face="Tahoma" color="Maroon" size="+1">Return to Admin Page</font></a></p>
</cfoutput>
</CFMODULE>

</HTML>
