<cfquery name="Formlist" datasource="#Application.DSN#">
	SELECT * From Forms
		WHERE Section = 'FIN' AND Active = True
		ORDER BY FormName
</cfquery>

<html>
<head>
	<title>Chicago Diocese - Online Resources and Forms</title>
</head>

<cfmodule template="#Application.header#" PageTitle="Finance and Administration" SubTitle="Online Resources and Forms">

<center>
<table width=580 border=0 cellspacing=0 cellpadding=0>
<tr valign=top>
	<td width=580>
		<font face="Verdana" size="-1">
		<p>This page contains a list of online forms that might be helpful.  Click on the name of the form to display its contents.  To download the form, right-click on the name of the form and choose to "Save Target as".  If you need a form that is not listed below, please feel free to send us an inquiry via our <a href="/Contact.cfm">Contact Us</a> page.</p>
		<p>To contact various church administrators on questions regarding finance, insurance, property and administrative issues, click <a href="Contacts.cfm">here</a> for a list of contact persons and their phone numbers, and web addresses.</p>
		
		<cfoutput query="Formlist">
			<p><font face="Tahoma,Arial" color="Maroon" size="+1"><a href="/Forms#FileName#">#FormName#</a></font><br>
			#Replace(FormDesc,"#chr(13)##chr(10)#","<br>","ALL")#</p>
		</cfoutput>
		
		</font>
	</td>
</tr>
</table>
</center>

</CFMODULE>
</HTML>
