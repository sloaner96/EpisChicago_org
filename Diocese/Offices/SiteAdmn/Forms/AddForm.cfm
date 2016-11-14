<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Forms Upload</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  pagetitle="Forms Uploader">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
<td>

<cfif NOT IsDefined("Form.FileContents")>
	<font face="Verdana" size="-1">
	<p>From this web page, you can upload a PDF file containing forms to be made available on the Group SubSite</p>
	<p>Using this page, click on the BROWSE button to find the file you wish to publish online and press the Upload button.  The server will first transfer the file and then update the Forms page accordingly.</p>
	</font>

	<center>
		<cfform name="SendFile" Enctype="multipart/form-data" Action="addForm.cfm">
		<cfoutput><input type="hidden" name="GroupID" Value="#url.groupID#"></cfoutput>
			<table cellpadding=2 cellspacing=2 border=0>
				<tr valign=top>
					<td align=left><font face="Verdana,Arial" size="-1"><b>Form Filename:</b></font></td>
					<td align=left><input type="file" name="FileContents" size="30"></td>
				</tr>
				<tr>
				    <td><font face="Verdana,Arial" size="-1"><b>Form Name:</b></font></td>
				    <td><cfinput type="text" name="FormName" maxlength="45" required="Yes" message="Please enter a name for this form"></td>
				</tr>
				<tr>
				    <td><font face="Verdana,Arial" size="-1"><b>Category:</b></font></td>
				    <td><select name="Category">
					      <option value="">-- Select One --</option>
						</select>
				    </td>
				</tr>
				<tr>
				    <td><font face="Verdana,Arial" size="-1"><b>Language:</b></font></td>
				    <td><select name="Language">
					      <option value="EN">English</option>
						  <option value="ES">Spanish</option>
						</select>
					</td>
				</tr>
				
				<tr>
				    <td><font face="Verdana,Arial" size="-1"><b>Form Description:</b></font></td>
				</tr>
				<tr>
				    <td colspan=2><textarea cols="42" rows="8" name="formDesc"></textarea></td>
				</tr>
				<tr>
					<td colspan=2 align=center><br>
						<input type="Submit" value="Upload the Form >>"> 
					</td>
				</tr>
			
			</table>
		</cfform>
	</center>

<cfelse>
   <cfif Len(Trim(form.filecontents)) EQ 0>
     <cflocation url="index.cfm?e=1">
   </cfif>
   
   <cfif Len(Trim(form.FormName)) EQ 0>
     <cflocation url="index.cfm?e=2">
   </cfif>
   	
	<CFSET Location = "#Application.DirPath#\Forms\Subsites\">
	<cffile action="UPLOAD"
	        filefield="Form.FileContents"
	        destination="#Location#"
	        nameconflict="MakeUnique">
    
	<cfset tempDesc = form.formdesc>
	<cfquery name="AddForm" datasource="#Application.dsn#">
	  Insert Into Forms(
	       GroupID, 
		   Active, 
		   FormName, 
		   FormDesc, 
		   FileType, 
		   FileName, 
		   Category, 
		   Language, 
		   LastUpdated, 
		   UpdatedBy)
	 Values (
	       #Form.GroupID#,
		   1,
		   '#Form.FormName#',
		   <cfif tempDesc NEQ "">'#Form.FormDesc#'<cfelse>Null</cfif>,
		   '#Right(file.serverfile, 3)#',
		   '#File.ServerFile#',
		   <!--- '#Form.Category#', --->NULL,
		   '#Form.Language#',
		   #CreateOdbcDateTime(now())#,
		   #Session.SubUserid#   
	         )	   
	</cfquery>
	
	<cfoutput>
	<p><font face="arial" size="-1"><strong>The Form has been uploaded.</strong></font></p>
	<p><font face="arial" size="-1"><strong>Click <a href="index.cfm?GroupID=#Form.GroupID#">Here</a> to go to the homepage</strong></font></p>
	</cfoutput>

</cfif>
</td>
</tr>
</table>
</CFMODULE>

</HTML>
