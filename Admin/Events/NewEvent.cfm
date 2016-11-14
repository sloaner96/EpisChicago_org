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

<CFSET CurDate	=	#CreateODBCDate(DateFormat(now(), "mm/dd/yyyy"))#>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: New Event Entry</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Enter new Calendar Event">


<CFFORM Name="AddEvent" Action="EventsProcess.cfm">

<center>
<table border=0 cellspacing=1 cellpadding=3 bgcolor="#F3F3F3">
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event Name</b></font>:</td>
	<td width* align=left><cfinput name="Heading" type="text" size=50 maxlength=80 required="Yes" Message="A Name for this Event is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Category</b></font>:</td>
	<td width=* align=left><cfselect name="Category" query="Cats" display="CodeDesc" value="CodeValue" size=1><option selected value="*">--- Select One ---</option></cfselect></td>
</tr>

<!--- <tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Site Section</b></font>:</td>
	<td width=* align=left><cfselect name="EGroup" query="EGroups" display="CodeDesc" value="CodeValue" size=1></cfselect></td>
</tr> --->

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Beginning on:</b></font></td>
	<td width* align=left><cfinput name="SDate" type="text" size=25 maxlength=25 required="Yes" Message="A Starting Date for this Event is required"> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Ending on:</b></font></td>
	<td width* align=left><cfinput name="EDate" type="text" size=25 maxlength=25> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>On DateWatch?</b></font></td>
	<td width=* align=left><input name="DateWatch" type="checkbox" value="1"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Location:</b></font></td>
	<td width* align=left><cfinput name="Location" type="text" size=40 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact:</b></font></td>
	<td width* align=left><cfinput name="Contact" type="text" size=40 maxlength=40></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact Phone:</b></font></td>
	<td width* align=left><cfinput name="Phone" type="text" size=20 maxlength=30></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact Email:</b></font></td>
	<td width* align=left><cfinput name="Email" type="text" size=40 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event URL:</b></font></td>
	<td width* align=left><cfinput name="WebURL" type="text" size=40 maxlength=130></td>
</tr>

<tr>
	<td colspan=2 align=left>
		<br><font face="Verdana,Arial" size="-1"><b>Event Description:</b></font><br>
		<textarea name="Description" cols="50" rows="8" wrap="VIRTUAL"></textarea>
	</td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="Submit" name="Cmd" value="Save Event"> 
		<input type="reset"  name="Cmd" value="Clear Form">
	</td>
</tr>

</table>
</center>

</CFFORM>

</CFMODULE>

</HTML>
