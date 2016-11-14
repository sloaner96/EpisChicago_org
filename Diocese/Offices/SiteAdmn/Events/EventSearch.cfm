<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Group Event Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  PageTitle="Site Administration" SubTitle="Event Search Screen">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="200" valign="top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td> 
		<td valign="top">
			<blockquote>
			<cfoutput><div align="right"><font face="verdana" size="-1"><a href="NewEvent.cfm?GroupID=#URL.GroupID#">Add New Event</a></font></div> </cfoutput>
			<p><font face="arial" size="-1">Search the Events calendar for a list of events for this group that you may want to modify or delete by using the form below.</font></p>
			</blockquote>
			
			
			<form action="ListEvents.cfm" method="POST">
			<cfoutput><input type="hidden" name="groupID" value="#URL.GroupID#"></cfoutput>
			<center>
			<table border=0 cellspacing=8 cellpadding=1>
				<tr>
					<td width=120 align=left><font face="Verdana" size="-1"><b>Keywords:</b></font></td>
					<td width=*><input type="text" name="keywords" value="" size=40 maxlength=40></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font face="Verdana" size="-1"><b>Events since:</b></font></td>
					<td width=*><input name="EventDate" value="" type="text" size=25 maxlength=25> <font size="-1"><i>(Format: mm/dd/yyyy)</i></font></td>
				</tr>
				
				<tr>
					<td colspan=2 align=left>
					<br><input type="submit" value="Search the Events">
					<input type="reset"  value="Clear Form">
					</td>
				</tr>
			
			</table>
			</center>
			</form>
		</td>
	</tr>
</table>
</CFMODULE>

</HTML>
