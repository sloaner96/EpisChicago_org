<cfparam name="attributes.formID" default="0">
<cfquery name="GetForms" datasource="#Application.dsn#">
  Select *
  From Forms
  Where GroupID = #Attributes.GroupID#
  AND Active = True
  Order By Category, FileName
</cfquery>
<center>
	<table width="100%" border=0 cellspacing=0 cellpadding=0>
		<tr valign="top">
			<td>
				<font face="Verdana" size="-1">
				<p>This page contains a list of online forms that might be helpful.  Click on the name of the form to display its contents.  To download the form, right-click on the name of the form and choose to "Save Target as".  If you need a form that is not listed below, please feel free to send us an inquiry via our <a href="/Contact.cfm">Contact Us</a> page.</p>
		        <cfif GetForms.recordcount GT 0>
					<table border=0 cellpadding=2 cellspacing=0>
					  <tr>
						 <td><cfoutput><A href="http://www.adobe.com/prodindex/acrobat/readstep2.html" target="_blank"><IMG src="/images/getacro.gif" vspace="4" hspace="4" alt="Get Acrobat Reader" border="0"></A> <font face="arial" size="-2">This section utilizes Adobe Acrobat to view the Forms. Click to the image to download the Acrobat Viewer</font></cfoutput></td>
					  </tr>
					</table><br>
				
				<cfoutput query="GetForms">
					<p><font face="Arial" color="Maroon" size="-1"><a href="/Forms/subsites/#urlencodedformat(FileName)#"><strong>#FormName#</strong></a></font><br>
					#Replace(FormDesc,"#chr(13)##chr(10)#","<br>","ALL")#</p>
				</cfoutput>
				<cfelse>
				    <div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO FORMS FOR THIS GROUP</strong></font></div> 
				</cfif>
				</font>
			</td>
		</tr>
	</table>
</center>

