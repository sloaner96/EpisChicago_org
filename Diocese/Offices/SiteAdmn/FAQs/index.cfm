<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>

<cfquery name="Cats" datasource="#Application.DSN#">
	SELECT Distinct CodeValue, CodeDesc From qFAQ C, FAQs F
	Where F.Category = C.CodeValue
	AND F.GroupID = #Url.GroupID#
		ORDER BY CodeValue
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: FAQ Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  PageTitle="Group Subsite FAQ Maintenance">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
			<td width="1" bgcolor="#000000"></td> 
			<td valign="Top">
				<blockquote>
					<font face="Verdana,Arial">
					<font size="-1">
					<div align=right><cfoutput><a href="NewFAQ.cfm?GroupID=#Url.GroupID#">Add new FAQ</a></cfoutput></div>
					<p>Search the database for Frequently Asked Questions that you may want to modify or delete by searching by keyword/phrase or listing them by their category.</p>
					</font>
				</blockquote>
				
				<cfform name="KwdFind" action="ListFAQs.cfm" method="POST">
				<cfoutput><input name="GroupID" type="hidden" value="#Url.GroupID#"></cfoutput>
				<center>
				<table border="0" cellspacing="1" cellpadding="3">
				<tr valign=top>
					<td align=left>
						<font size="-1"><b>Search for FAQs containing:</b></font><br>
						<cfinput type="text" name="keywords" value="" size=30 maxlength=40 required="No"><br><br>
				
						<cfif Cats.recordcount GT 0>
						<font size="-1"><b>List all FAQs pertaining to:</b></font><br>
						<cfselect name="category" query="Cats" display="CodeDesc" value="CodeValue" size=1>
						<option value="*" selected>--- ALL ---</option>
						</cfselect><br>
						</cfif>
						<br><input type="submit" value="Search FAQs!">
						</cfform>
					</td>
				</tr>
				</table>
				</center>
				
				</font>
	  </td>
	</tr>
</table>
</CFMODULE>
</HTML>
