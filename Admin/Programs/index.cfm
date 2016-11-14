<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="Programs" datasource="#Application.DSN#">
	Select * 
	From Programs
	Order By Approved desc,  EndDate Desc, BeginDate, Title
</cfquery>


<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Main Menu">

  <table border="0" cellpadding="4" cellspacing="0" width="100%">
     <tr>
       <td><font face="arial" size="-1"><strong><a href="AddProgram.cfm">Add a New Program</a></strong></font></td>
     </tr>
	 <tr>
	   <td>&nbsp;</td>
	 </tr> 
	   <tr>
	     <td><font face="arial" size="-1">From the admin below you can edit program information, maintain program content, and maintain events for a program. You can not add a program to a group subiste from this admin page, you must add a program to a group subsite, from the group subsite admin.</font></td>
	   </tr>
  </table><br>
  <cfif url.E EQ 1>
    <p><font face="verdana" color="#cc0000" size="-1"><strong>THERE WAS A PROBLEM. PLEASE CLICK THE PROGRAM BELOW TO CONTINUE.</strong></font></p>
  </cfif>
  <table border="0" cellpadding="4" cellspacing="0" width="100%">
   <tr>
     <td><font face="tahoma" color="#003399" size="-1"><strong>Existing Programs</strong></font></td>
   </tr>
  </table>
  <hr noshade size="1">
   <table border="0" cellpadding="4" cellspacing="1" width="90%" bgcolor="eeeeee">
     <tr bgcolor="#006699">
       <td><font face="verdana" color="ffffff" size="-1"><strong>Program Name</strong></font></td>
	   <td><font face="verdana" color="ffffff" size="-1"><strong>Dates</strong></font></td>
	   <td><font face="verdana" color="ffffff" size="-1"><strong>Action</strong></font></td>
     </tr>
	 <cfoutput query="Programs">
		 <tr <cfif EndDate GT Now() or EndDate EQ "">bgcolor="ffffff"</cfif>>
	       <td width="40%"><font face="arial" size="-1"><strong>#Title#</strong></font>
		                   <br><font face="verdana" size="-2">#ShortDesc#</font></td>
		   <td valign="top" align="center"><font face="arial" size="-1">#Dateformat(BeginDate, 'mm/dd/yyyy')#-#DateFormat(EndDate, 'mm/dd/yyyy')#</font></td>
		   <td valign="top" align="center"><font face="verdana" size="-2"><a href="EditProgram.cfm?PID=#Programs.ProgramID#">[EDIT&nbsp;PROGRAM]</a> <a href="EditContent.cfm?PID=#Programs.ProgramID#">[MAINTAIN&nbsp;CONTENT]</a><br> <a href="EditEvents.cfm?PID=#Programs.ProgramID#">[MAINTAIN&nbsp;EVENTS]</a> <a href="UpdateProgram.cfm?Action=confirm&PID=#Programs.ProgramID#" style="color:red;">[REMOVE]</a></font></td>
	     </tr>
	 </cfoutput>
   </table>


</CFMODULE>

</HTML>
