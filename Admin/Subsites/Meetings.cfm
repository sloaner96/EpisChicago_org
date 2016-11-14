

<cfquery name="GetMeetings" datasource="#Application.DSN#">
	SELECT GroupID, Meetings
	From GroupNfo
	Where GroupID = #url.GroupID#
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Group Meeting Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin"  PageTitle="Group Subsite Meetings">
<form name="UpdateMeetings" action="Meetings.cfm" Method="POST">
	<cfoutput>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	  <tr>
	     <td width="200" valign="Top"><cfmodule template="sidenav.cfm"></td>
	     <td valign="Top">
		    <table border="0" cellpadding="4" cellspacing="0" align="center">
	          <tr>
	            <td><font size="-1">Use the form below to update meeting information for this group.</font></td>
	          </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Meetings:</strong></font><br><textarea cols="45" rows="15" name="meetinginfo">#Trim(GetMeetings.Meetings)#</textarea></td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td><input type="submit" name="submit" value="Update Meeting >>"</td>
			  </tr>
	        </table>
		 </td>
	  </tr>
	</table>
	</cfoutput>
</form>
</CFMODULE>
</HTML>