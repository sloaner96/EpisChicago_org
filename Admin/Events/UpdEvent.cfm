<CFIF NOT IsDefined("URL.EventID")>
	<CFLOCATION URL="EventSearch.cfm">
</CFIF>

<CFQUERY Name="GetEvent" Datasource="#Application.DSN#">
	SELECT * from Events
		WHERE EventID = #URL.EventID#
</CFQUERY>
<cfquery name="Cats" datasource="#Application.DSN#">
	SELECT * From Lookups
		WHERE CodeGroup = 'EVENT'
		ORDER BY CodeValue
</cfquery>
<cfquery name="EGroups" datasource="#Application.DSN#">
	SELECT * From Lookups
		WHERE CodeGroup = 'EVNTGROUP'
		ORDER BY CodeValue
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Record Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Event Information">

<p align=center>Use this form to modify or delete the event information displayed below.</p>


<CFLOOP Query="GetEvent">
<CFSET SDate = #DateFormat(BeginDate, "mm/d/yyyy")# & " " & #TimeFormat(BeginDate, "h:mm TT")#>
<cfif EndDate is not "">
	<CFSET EDate = #DateFormat(EndDate, "mm/d/yyyy")# & " " & #TimeFormat(EndDate, "h:mm TT")#>
<cfelse>
	<CFSET EDate = #DateFormat(BeginDate, "mm/d/yyyy")# & " 11:59 PM">
</cfif>

<CFFORM Name="ModEvent" Action="EventsProcess.cfm">
<CFOUTPUT><input name="EventID" type="hidden" value="#URL.EventID#"></CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3 bgcolor="#F3F3F3">

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event Name:</b></font></td>
	<td width=* align=left><cfinput name="Heading" type="text" value="#EventName#" size=50 maxlength=80 required="Yes" Message="A Name for this Event is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Category</b></font>:</td>
	<td width=* align=left><cfselect name="Category" query="Cats" selected="#Category#" display="CodeDesc" value="CodeValue" size=1><option <cfif Category is "">selected</cfif> value="*">--- Select One ---</option></cfselect></td>
</tr>

<!--- <tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Site Section</b></font>:</td>
	<td width=* align=left><cfselect name="EGroup" query="EGroups" selected="#EventGroup#" display="CodeDesc" value="CodeValue" size=1></cfselect></td>
</tr> --->

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Beginning on:</b></font></td>
	<td width=* align=left><cfinput name="SDate" type="text" value="#SDate#" size=25 maxlength=25 required="Yes" Message="A Starting Date for this Event is required"> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Ending on:</b></font></td>
	<td width=* align=left><cfinput name="EDate" type="text" value="#EDate#" size=25 maxlength=25> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>On DateWatch?</b></font></td>
	<td width=* align=left><input name="DateWatch" type="checkbox" value="1" <cfif HighLight is True>checked</cfif> ></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Location:</b></font></td>
	<td width=* align=left><cfinput name="Location" type="text" value="#Location#" size=40 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact:</b></font></td>
	<td width=* align=left><cfinput name="Contact" type="text" value="#Contact#" size=40 maxlength=40 required="No"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact Phone:</b></font></td>
	<td width* align=left><cfinput name="Phone" type="text" value="#Phone#" size=20 maxlength=30></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact Email:</b></font></td>
	<td width* align=left><cfinput name="Email" type="text" value="#ContactEmail#" size=40 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event URL:</b></font></td>
	<td width* align=left><cfinput name="WebURL" type="text" value="#URL#" size=40 maxlength=130></td>
</tr>

<tr>
	<td colspan=2 align=left>
		<br><font face="Verdana,Arial" size="-1"><b>Event Description:</b></font><br>
		<CFOUTPUT><textarea name="Description" cols="50" rows="8" wrap="VIRTUAL">#HTMLEditFormat(Description)#</textarea></CFOUTPUT></td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="submit" name="Cmd" value="Delete Event">
		<input type="Submit" name="Cmd" value="Update Event"> 
		<input type="reset" value="Reset Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</CFLOOP>

</CFMODULE>

</HTML>
