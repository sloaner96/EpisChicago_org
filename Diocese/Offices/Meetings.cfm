<cfparam name="Attributes.GroupID" default="0">

<cfquery name="GetMeetings" datasource="#Application.dsn#">
  Select Meetings
  From GroupNfo
  Where GroupID = #Attributes.GroupID#
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
 <cfoutput query="GetMeetings">
   <tr>
      <td><font face="Verdana" size="-1">#GetMeetings.Meetings#</a></td>
   </tr>
 </cfoutput>
</table>