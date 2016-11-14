<CFIF NOT IsDefined("URL.OrgID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<CFQUERY Name="GetParish" Datasource="#Application.DSN#">
	SELECT * from Directory
		WHERE OrgID = #URL.OrgID#
</CFQUERY>
<cfquery name="Contacts" datasource="#Application.DSN#">
	SELECT Left(Prefix+' '+FirstName+' '+LastName, 35) as ContactName, ContactID From Contacts
		ORDER BY LastName, FirstName
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify Parish Information</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Parish Information">


<p align=center>Use this form to modify or delete the parish information displayed below.</p>


<CFLOOP Query="GetParish">
<CFFORM Name="UpdParish" Action="ParishProcess.cfm">
<CFOUTPUT><input name="OrgID" type="hidden" value="#URL.OrgID#"></CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3>
<tr>
  <td colspan="2">
     <cfoutput>
	 <table border="0" cellpadding="3" cellspacing="1" width="100%">
	   <tr bgcolor="##000066">
	      <td><strong style="color:##ffffff;"><a href="UpdParish.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Parish Home</a></strong></td>
		  <td><strong style="color:##ffffff;"><a href="Parishaccess.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Accessibility Options</a></strong></td>
		  <td><strong style="color:##ffffff;"><a href="ParishMinistries.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Parish Ministries</a></strong></td>
		  
		  <td><strong style="color:##ffffff;"><a href="ParishLeadership.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Parish Leadership</a></strong></td>
		  
	   </tr>
     </table>
	 </cfoutput>
  </td>
</tr>
</table>
</center>

</CFFORM>
</CFLOOP>

</CFMODULE>

</HTML>