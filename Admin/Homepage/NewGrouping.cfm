<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Administer Homepage" SubTitle="Add New Resource Grouping">

<center>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
   <tr>
     <td></td>
	 <td align="right"><a href="GroupResources.cfm"><font face="verdana" size="-2">Back to Resource Grouping Admin</font></a></td>
   </tr>
</table><br><br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td><font face="arial" size="-1">Use the form below to setup the grouping, You will need to enter a title for the resource and click Next, you will then be asked to add resources to this grouping. When you are finished you must activate the grouping.</font></td>
  </tr>
</table><br><br>
<cfif url.e EQ 1>
<p><font face="arial" color="#cc0000" size="-1"><strong>Error! You must Enter a Resource Title to Continue</strong></font></p>
<br>
</cfif>
<cfform name="addRes" action="UpdateGrouping.cfm?action=Create" method="POST">
<table border="0" cellpadding="5" cellspacing="0" width="100%">
  <tr>
     <td><font face="verdana" size="-1"><strong>Please enter a Title for this Resource Grouping:</strong></font> <cfinput type="text" name="ResourceTitle" size="15" maxlength="20" required="yes" message="You Must Enter a Title for the Resource Grouping"></td>
  </tr>
  <tr>
     <td><input type="submit" name="submit" value="Next >>"></td>
  </tr>
</table>
</cfform>
</center>

</CFMODULE>

</HTML>