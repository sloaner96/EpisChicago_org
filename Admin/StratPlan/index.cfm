<cfquery name="GetGoals" datasource="#Application.dsn#">
  Select Count(*) as goalcount
  From Goals G
  Where Active = True
</cfquery>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin" SubTitle="Main Menu">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
     <td><font face="arial" size="-1">From the admin below you can edit content on the strategic plan homepage and associated goals &amp; initiatives.</font></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td>
	 <font face="arial" size="-1">
	    <ol>
	       <li><a href="sitecontent.cfm">Edit/Update Goals page content</a></li>
		   <li><a href="goals.cfm">Edit/Update Strategic Goals</a></li>
		   <cfif GetGoals.goalcount GT 0>
		     <li><a href="Initiatives.cfm">Edit/Update Strategic Initiatives</a></li>
		   </cfif>
		</ol>
	 </font>
	 </td>
   </tr>
</table>
</CFMODULE>
