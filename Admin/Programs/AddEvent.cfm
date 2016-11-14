<CFSET CurDate	=	#CreateODBCDate(DateFormat(now(), "mm/dd/yyyy"))#>
<cfquery name="Programs" datasource="#Application.DSN#">
	Select * 
	From Programs
	Where ProgramID = #URL.PID#
	Order By Approved desc,  EndDate Desc, BeginDate, Title
</cfquery>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: New Program Event Entry</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  Section="Admin" PageTitle="Programs Admin" SubTitle="New Program Event">
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
     <tr>
       <td align="right"><font face="arial" size="-2"><strong><a href="index.cfm">Back to Program Home</a></strong></font></td>
     </tr>
  </table><br>
  <table border="0" cellpadding="1" cellspacing="0">
    <tr>
      <td>
	    <table border="0" cellpadding="0" cellspacing="0" width="600" align="center" bgcolor="eeeeee">
		<tr>
			<td valign="Top"> 
						<CFFORM Name="AddEvent" Action="UpdateProgram.cfm?action=AddEvent&PID=#Url.PID#">
						<cfoutput><input type="hidden" name="ProgramID" value="#URL.PID#"></cfoutput>
						<center>
					<table border=0 cellspacing=1 cellpadding=3 >
						<tr>
							<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Event Name</b></font>:</td>
							<td width* align=left><cfinput name="Heading" type="text" size=50 maxlength=80 required="Yes" Message="A Name for this Event is required"></td>
						</tr>
			
						<tr>
							<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Beginning on:</b></font></td>
							<td width* align=left><cfinput name="SDate" type="text" size=25 maxlength=25 required="Yes" Message="A Starting Date for this Event is required"> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
						</tr>
						
						<tr>
							<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Ending on:</b></font></td>
							<td width* align=left><cfinput name="EDate" type="text" size=25 maxlength=25> <font size="-1"><i>(Format: mm/dd/yyyy hh:mm)</i></font></td>
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
				  </td>
				</tr>
			</table>
	  </td>
    </tr>
  </table>
</CFMODULE>

</HTML>