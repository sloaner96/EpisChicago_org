<CFSET CurDate	=	#CreateODBCDate(DateFormat(now(), "mm/dd/yyyy"))#>
<cfquery name="Programs" datasource="#Application.DSN#">
	Select * 
	From Programs
	Where ProgramID = #URL.PID#
	Order By Approved desc,  EndDate Desc, BeginDate, Title
</cfquery>

<cfquery name="Event" datasource="#Application.DSN#">
	Select * 
	From Events
	Where ProgramID = #URL.PID#
	AND EventID = #url.EventID#
</cfquery>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Edit Program Event</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  Section="Admin" PageTitle="Programs Admin" SubTitle="Edit Program Event">
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
     <tr>
       <td align="right"><font face="arial" size="-2"><strong><a href="index.cfm">Back to Program Home</a></strong></font></td>
     </tr>
  </table><br>
<CFFORM Name="AddEvent" Action="UpdateProgram.cfm?action=UpdateEvent&PID=#Url.PID#">
	<cfoutput>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" >
		   <tr>
		     <td>
			    <table border="0" cellpadding="1" cellspacing="0" align="center" bgcolor="000000">
				<tr>
					<td valign="Top"> 
							<input type="hidden" name="EventID" value="#Event.EventID#">
							<input type="hidden" name="ProgramID" value="#URL.PID#">
							<center>
							<table border=0 cellspacing=4 cellpadding=3 bgcolor="ffffff">
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event Name</b></font>:</td>
								<td width* align=left><cfinput name="Heading" type="text" size=50 maxlength=80 value="#Event.EventName#" required="Yes" Message="A Name for this Event is required"></td>
							</tr>
				
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Beginning on:</b></font></td>
								<td width* align=left><cfinput name="SDate" type="text" size=25 maxlength=25 value="#DateFormat(Event.BeginDate, 'MM/DD/YYYY')# #TimeFormat(Event.BeginDate, 'hh:mm tt')#" required="Yes" Message="A Starting Date for this Event is required"> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
							</tr>
							
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Ending on:</b></font></td>
								<td width* align=left><cfinput name="EDate" type="text" size=25 maxlength=25 value="#DateFormat(Event.EndDate, 'MM/DD/YYYY')# #TimeFormat(Event.EndDate, 'hh:mm tt')#"> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
							</tr>
				
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Location:</b></font></td>
								<td width* align=left><cfinput name="Location" type="text" size=40 maxlength=80 value="#Event.Location#"></td>
							</tr>
							
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact:</b></font></td>
								<td width* align=left><cfinput name="Contact" type="text" size=40 maxlength=40 value="#Event.Contact#"></td>
							</tr>
							
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact Phone:</b></font></td>
								<td width* align=left><cfinput name="Phone" type="text" size=20 maxlength=30 value="#Event.Phone#"></td>
							</tr>
							
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact Email:</b></font></td>
								<td width* align=left><cfinput name="Email" type="text" size=40 maxlength=80 value="#Event.ContactEmail#"></td>
							</tr>
							
							<tr>
								<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event URL:</b></font></td>
								<td width* align=left><cfinput name="WebURL" type="text" size=40 maxlength=130 value="#Event.Url#"></td>
							</tr>
							
							<tr>
								<td colspan=2 align=left>
									<br><font face="Verdana,Arial" size="-1"><b>Event Description:</b></font><br>
									<textarea name="Description" cols="50" rows="8" wrap="VIRTUAL">#Trim(Event.Description)#</textarea>
								</td>
							</tr>
							
							<tr>
								<td colspan=2 align=center><br>
									<input type="Submit" name="Cmd" value="Update Event"> 
									<input type="reset"  name="Cmd" value="Clear Form">
								</td>
							</tr>
							
							</table>
							
							
					  </td>
					</tr>
				</table>
			 </td>
		   </tr>
		</table>
	</cfoutput>
</CFFORM>
</CFMODULE>

</HTML>