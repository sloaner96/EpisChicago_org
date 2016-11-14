
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="Programs" datasource="#Application.DSN#">
	Select * 
	From Programs
	Where ProgramID = #URL.PID#
	Order By Approved desc,  EndDate Desc, BeginDate, Title
</cfquery>

<cfquery name="ProgramEvents" datasource="#Application.DSN#">
	Select * 
	From Events
	Where ProgramID = #URL.PID#
	Order By BeginDate, EndDate, EventName
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Maintain Events">

  <table border="0" cellpadding="3" cellspacing="0" width="100%">
     <tr>
       <td align="right"><font face="arial" size="-2"><strong><a href="index.cfm">Back to Program Home</a></strong></font></td>
     </tr>
  </table><br>
  <cfoutput>
  <p><font face="verdana"  size="-1"><strong><a href="AddEvent.cfm?PID=#url.PID#">Add New Event</a></strong></font></p>
  </cfoutput>
  <br>
  <table border="0" cellpadding="4" cellspacing="0" width="100%">
   <tr>
     <td><font face="tahoma" color="#003399" size="-1"><strong>Existing Program Events</strong></font></td>
   </tr>
  </table>
  <hr noshade size="1">
  <cfif ProgramEvents.recordcount GT 0>
   <table border="0" cellpadding="4" cellspacing="1" width="90%" bgcolor="eeeeee">
     <tr bgcolor="#006699">
       <td><font face="verdana" color="ffffff" size="-1"><strong>Event Name</strong></font></td>
	   <td><font face="verdana" color="ffffff" size="-1"><strong>Location</strong></font></td>
	   <td><font face="verdana" color="ffffff" size="-1"><strong>Dates</strong></font></td>
	   <td><font face="verdana" color="ffffff" size="-1"><strong>Action</strong></font></td>
     </tr>
	 <cfoutput query="ProgramEvents">
		 <tr bgcolor="ffffff">
	       <td width="40%"><font face="arial" size="-1"><strong>#EventName#</strong></font></td>
		   <td><font face="verdana" size="-2">#Location#</font></td>
		   <td valign="top" align="center"><font face="arial" size="-1">#Dateformat(BeginDate, 'mm/dd/yy')# - #DateFormat(EndDate, 'mm/dd/yy')#</font></td>
		   <td valign="top" align="center"><font face="verdana" size="-2"><a href="UpdateEvent.cfm?PID=#url.PID#&EventID=#EventID#">EDIT</a> | <a href="UpdateProgram.cfm?action=RemoveEvent&PID=#url.PID#&EventID=#EventID#" style="color:##cc0000;">REMOVE</a></font></td>
	     </tr>
	 </cfoutput>
   </table>
  <cfelse>
    <p><font face="verdana" color="#b9b9b9" size="-1"><strong>THERE ARE NO EVENTS FOR THIS PROGRAM</strong></font></p> 
  </cfif> 

</CFMODULE>

</HTML>