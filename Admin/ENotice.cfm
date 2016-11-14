<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Parish/Clergy Email Broadcast</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Parish/Clergy Email Broadcast">

<cfif NOT IsDefined("Form.Message")>
	<cfquery name="Parishes" datasource="#Application.DSN#">
		SELECT Count(*) as NParishes From Directory
			WHERE Email is not NULL AND Email <> ''
	</cfquery>
	<cfquery name="Clergy" datasource="#Application.DSN#">
		SELECT Count(*) as NClergy From Contacts
			WHERE Email is not NULL AND Email <> ''
	</cfquery>

	<blockquote>
	<font face="Verdana" size="-1">
	<cfoutput><p>Use this page to send an electronic mail message to <b>#NumberFormat(Parishes.NParishes)# parishes</b> and <b>#NumberFormat(Clergy.NClergy)# clergy contacts</b> in the online database.  This is a quick way to communicate (with those who have email) about news and events happening within the Diocese.</p></cfoutput>
	</font>
	</blockquote>

	<cfform name="SendMsg" action="ENotice.cfm" method="POST">
	<center>
	<table border="0" cellspacing="0" cellpadding="1">
	<tr>
		<td width=120 align=left><font size="-1" face="Verdana"><b>Subject:</b></font></td>
		<td width=*><cfinput type="text" name="Subject" size=30 maxlength=80 required="Yes" Message="A subject for your message must be provided"></td>
	</tr>
	
	<tr valign=top>
		<td width=120 align=left><font size="-1" face="Verdana"><b>Notice Text:</b></font></td>
		<td width=*><textarea name="Message" cols="45" rows="10" wrap="VIRTUAL"></textarea></td>
	</tr>
	
	<tr valign=top>
		<td align=center colspan=2><br><input type="Submit" value="Send Broadcast!">&nbsp;&nbsp;&nbsp;<input type="Reset" value="Clear Form"></td>
	</tr>
	</table>
	</center>
	
	</cfform>

<cfelse>

	<cfset ErrorList = ArrayNew(1)>

	<CFIF #Form.Subject# is "">
		<cfset x = ArrayAppend(ErrorList, "You must supply a <b>Subject</b> for your message.")>
	</CFIF>

	<CFIF #Form.Message# is "">
		<cfset x = ArrayAppend(ErrorList, "You have neglected to provide the text of your message on the form!")>
	</CFIF>

	<cfset NErrors = ArrayLen(ErrorList)>
	<cfif NErrors gt 0>
		<cfoutput>
		<h4><font color="Black">#NErrors# problem(s) encountered with your Broadcast</font></h4>
		</cfoutput>
		<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
		<ol>
		<cfloop INDEX="i" FROM="1" TO="#NErrors#">
		<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
		</cfloop>
		</ol>
		<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

	<cfelse>
		<cfquery name="Parishes" datasource="#Application.DSN#">
			SELECT ParishName, City, Email From Directory
				WHERE Email is not NULL AND Email <> ''
				ORDER BY Email
		</cfquery>
		<cfquery name="Clergy" datasource="#Application.DSN#">
			SELECT Prefix, FirstName, LastName, Suffix, Email From Contacts
				WHERE Email is not NULL AND Email <> ''
				ORDER BY Email
		</cfquery>

		<cfmail query="Parishes" to="#Email#" from="announcements@epischicago.org" subject="Diocesan eNotice regarding '#Form.Subject#'" server="mail.epischicago.org">
To: #ParishName#, #City#

#Form.Message#

---------------------------------------------------------------
You have received this email as a Parish within the Diocese of Chicago and this is the email address we have on file for your parish.  If you feel you have received this email message in error, please send an email to info@epischicago.org and let us know.  Replying to this dispatch announcement will not result in a response.

		</cfmail>
		<cfmail query="Clergy" to="#Email#" from="announcements@epischicago.org" subject="Diocesan eNotice regarding '#Form.Subject#'" server="mail.epischicago.org">
To: #Prefix# #FirstName# #LastName# #Suffix#

#Form.Message#

---------------------------------------------------------------
You have received this email as a cleric or agency head within the Diocese of Chicago and this is the email address we have on file for you.  If you feel you have received this email message in error, please send an email to info@epischicago.org and let us know.  Replying to this dispatch announcement will not result in a response.

		</cfmail>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="eNotice" Status="OK" Message="#Session.FullName# sent an electronic mail message regarding '#Form.Subject#' to #Parishes.RecordCount# Parishes and #Clergy.RecordCount# clergy contacts" User="#Session.UserID#">

		<cfoutput>
		<font face="Verdana,Arial" color="Maroon">Your Email Notification has been distributed to #Parishes.RecordCount# Parishes and #Clergy.RecordCount# clergy contacts!</font><br><br>

		<font face="Tahoma,Arial" color="Blue" size="+1">Subject:</font> <font face="Arial">#Form.Subject#</font><br><br>
		<font face="Tahoma,Arial" color="Blue" size="+1">Message Contents</font><br>
		#Replace(Form.Message,"#chr(13)##chr(10)#","<br>","ALL")#<br>
		---------------------------------------------------------------<br>
		You have received this email as a Parish within the Diocese of Chicago and this is the email address we have on file for your parish.  If you feel you have received this email message in error, please send an email to info@epischicago.org and let us know.  Replying to this dispatch announcement will not result in a response.
		</cfoutput>

	</cfif>

</cfif>

</CFMODULE>
</HTML>
