<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>

<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Forms Upload</TITLE>
	</cfoutput>
</HEAD>
<CFSET Location = "#Application.DirPath#\Forms\Subsites\">

<CFMODULE Template="#Application.Header#"  pagetitle="Forms Uploader">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
<td>
<cfif Not IsDefined("Form.FormName")>
<cfquery name="GetForm" datasource="#Application.Dsn#">
  Select *
  From Forms
  Where FormID = #url.FID#
  AND GroupID = #Url.GroupID#
</cfquery>

	<font face="Verdana" size="-1">
	<p>From this web page, you can update this form that is available on the Group SubSite</p>
	<p>Using this page, to change the pdf form, click on the BROWSE button to find the file you 
	   wish to publish online and press the Upload button.  The server will first transfer the 
	   file and then update the Forms page accordingly. you may also update the information 
	   about this form and click the update for button at the bottom of the page.</p>
	</font>

	<center>
	    <cfif url.e EQ 1>
		  <p><font face="verdana" color="red" size="-1"><strong>Error! You must enter a name for this form.</strong></font></p>
		</cfif> 
		<cfform name="SendFile" Enctype="multipart/form-data" Action="EditForm.cfm">
		<cfoutput>
		   <input type="hidden" name="GroupID" Value="#url.groupID#">
		   <input type="hidden" name="FormID" Value="#GetForm.FormID#">
			<table cellpadding=2 cellspacing=2 border=0>
				<tr>
				  <td><font face="Verdana,Arial" size="-1"><b><cfif getform.active EQ 1>In</cfif>activate Form:</b></font> <input type="checkbox" name="active" value="<cfif getform.active EQ 1>0<cfelse>1</cfif>"></td>
				</tr>
				<tr>
				  <td><font face="Verdana,Arial" size="-1"><b>View Current Form:</b> <a href="\forms\subsites\#GetForm.FileName#" target="_blank">Click Here</a></font></td>
				</tr>
				<tr valign=top>
					<td align=left><font face="Verdana,Arial" size="-1"><b>Form Filename:</b></font></td>
					<td align=left><input type="file" name="FileContents" size="30"></td>
				</tr>
				<tr>
				    <td><font face="Verdana,Arial" size="-1"><b>Form Name:</b></font></td>
				    <td><cfinput type="text" name="FormName" maxlength="45" required="Yes" value="#GetForm.formName#" message="Please enter a name for this form"></td>
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
					      <option value="EN" <cfif getform.Language EQ "EN">Selected</cfif>>English</option>
						  <option value="ES" <cfif getform.Language EQ "EN">Selected</cfif>>Spanish</option>
						</select>
					</td>
				</tr>
				
				<tr>
				    <td><font face="Verdana,Arial" size="-1"><b>Form Description:</b></font></td>
				</tr>
				<tr>
				    <td colspan=2><textarea cols="42" rows="8" name="formDesc">#GetForm.FormDesc#</textarea></td>
				</tr>
				<tr>
					<td colspan=2 align=center><br>
						<input type="Submit" value="Update the Form >>"> 
					</td>
				</tr>
			</table>
		  </cfoutput>
		</cfform>
	</center>

<cfelse>
   
   
   <cfif Len(Trim(form.FormName)) EQ 0>
     <cflocation url="index.cfm?e=2">
   </cfif>
   
   	<cfif Len(Trim(form.filecontents)) GT 0>
	<CFSET Location = "#Application.DirPath#\Forms\Subsites\">
	<cffile action="UPLOAD"
	        filefield="Form.FileContents"
	        destination="#Location#"
	        nameconflict="MakeUnique">
     </cfif>
	<cfset tempDesc = form.formdesc>
	<cfquery name="AddForm" datasource="#Application.dsn#">
	  Update Forms
	     Set 
		     <cfif IsDefined("form.active")>Active = #form.active#,</cfif>
		     FormName = '#Form.FormName#',
		     FormDesc = <cfif tempDesc NEQ "">'#Form.FormDesc#'<cfelse>Null</cfif>,
		     <cfif Len(Trim(form.filecontents)) GT 0> 
				 FileType = '#Right(file.serverfile, 3)#',
			     FileName = '#File.ServerFile#',
		     </cfif>
			 Category =<!--- '#Form.Category#', --->NULL,
		     Language = '#Form.Language#',
		     LastUpdated = #CreateOdbcDateTime(now())#,
		     UpdatedBy = #Session.SubUserid#  
	      Where FormID = #form.FormID#
		  AND GroupID = #Form.GroupID#   
	</cfquery>
	
	<cfoutput>
	<p><font face="arial" size="-1"><strong>The Form has been updated.</strong></font></p>
	<p><font face="arial" size="-1"><strong>Click <a href="index.cfm?GroupID=#Form.GroupID#">Here</a> to go to the homepage</strong></font></p>
	</cfoutput>

</cfif>
</td>
</tr>
</table>
</CFMODULE>

</HTML>
