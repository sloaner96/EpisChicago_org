<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: - Clergy File Transfer</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Clergy File Maintenance">

<br>
<blockquote>
<font face="Verdana,Arial" size="-1">
<p>From this web page, you can upload a data file created by the <b>Diocesan Database</b> to the Diocesan web site.  This file should be created using the customized download program created by <i>Great Spirit Systems</i>.  The file will contain clergy contact information necessary to provide content for various sections of the Diocesan web site.</p>
<p>Using this page, click on the BROWSE button to find the file you created and press the Upload button.  The server will first transfer the file and then process each entry in the file against the existing online database.  All clergy records in the uploaded file will be added or updated as necessary,</p>
</font>
</blockquote>


<center>
<cfform name="SendFile" Enctype="multipart/form-data" Action="ProcessClergyFile.cfm">
<table cellpadding=2 cellspacing=2 border=0>
<tr valign=top>
	<td width=125 align=left><font face="Verdana,Arial" size="-1"><b>Clergy Data File:</b></font></td>
	<td width=* align=left><input type="file" name="FileContents" size="35"></td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="Submit" value="Upload Clergy File"> 
		<input type="reset" value="Clear Form"><br>&nbsp;
	</td>
</tr>

</table>
</cfform>
</center>

</CFMODULE>

</HTML>
