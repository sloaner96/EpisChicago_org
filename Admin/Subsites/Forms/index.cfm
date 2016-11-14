<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Forms Upload</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="GetForm" datasource="#Application.Dsn#">
  Select *
  From Forms
  Where GroupID = #Url.GroupID#
  order by FormName
</cfquery>
<CFSET Location = "#Application.DirPath#\Forms\Subsites\">
<cfparam name="url.action" default="">



<CFMODULE Template="#Application.Header#"  pagetitle="Forms Uploader">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr> 
     <td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
     <td>
	   <cfoutput>
	    <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
		    <td><font face="arial" size="-1"><strong>Total Forms:</strong> #GetForm.RecordCount#</font></td>
            <td align="right"><strong><font face="verdana" size="-1"><a href="AddForm.cfm?GroupID=#url.GroupID#">Add New Form</a></font></strong></td>
          </tr>
        </table><br>
		<cfif GetForm.recordcount GT 0>
		  <table border="0" cellpadding="1" cellspacing="1" width="100%" >
             <tr>
               <td bgcolor="000000">
					<table border="0" cellpadding="3" cellspacing="0" width="100%" bgcolor="ffffff">
					     <tr>
						   <td>&nbsp;</td>
						   <td align="center"><font face="verdana" size="-2">Active</font></td>
						   <td colspan=3>&nbsp;</td>
						 </tr>
					  <cfloop Query="GetForm">
				          <tr <cfif getform.currentrow Mod 2 EQ 0>bgcolor="eeeeee"</cfif>>
					            <td><font face="arial" size="-1"><strong>#GetForm.FormName#</strong></font><br>
								    <font face="verdana" color="878787" size="-2">#GetForm.FileName#</font></td>	
								<td align="center"><cfif Active EQ 1><img src="/images/check.gif" alt="Active" border="0"></cfif></td>	
								<td align="right"><font face="verdana" size="-1"><a href="\Forms\Subsites\#FileName#" target="_blank">View Form</a></font></td>
								<td align="right"><font face="verdana" size="-1"><a href="DeleteForm.cfm?GroupID=#Url.GroupID#&FID=#FormID#">Delete Form</a></font></td>
								<td align="right"><font face="verdana" size="-1"><a href="EditForm.cfm?GroupID=#Url.GroupID#&FID=#FormID#">Edit Form</a></font></td>
				          </tr>
					  </cfloop>
			        </table>
			    </td>
             </tr>
          </table>
		<cfelse>
		  <p align="center"><font face="arial" color="666666" size="-1"><strong>THERE ARE NO FORMS ASSIGNED TO THIS SITE</strong></font></p>
		</cfif>
	   </cfoutput>
	 </td>
  </tr>
</table>
</CFMODULE>

</HTML>
