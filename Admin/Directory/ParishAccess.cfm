<CFIF NOT IsDefined("URL.OrgID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<CFQUERY Name="GetParish" Datasource="#Application.DSN#">
	SELECT * from Directory
		WHERE OrgID = #URL.OrgID#
</CFQUERY>

	  <cfquery name="chuchDetail" datasource="#application.dsn#">
	    SELECT M.GroupID, M.CatID, 
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FEACCGRP'
			  AND CodeValue = M.GroupID) as GroupName,
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FEACCCAT'
			  AND CodeValue = M.CatID) as CatName,
			(Select AccessID
			  From FaithAccesability
			  Where OrgID = #URL.OrgID#
			  AND GroupID = M.GroupID 
			  AND CatID = M.CatID) as CatExists  
		 from FaithAccessMatrix M
		 
		 order By M.GroupID, M.CatID 
	  </cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify Parish Information</TITLE>
	</cfoutput>
</HEAD>
<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Parish Information">


<p align=center>Use this form to modify or delete the parish information displayed below.</p>


<CFFORM Name="UpdParish" Action="ParishAccess_action.cfm">
<CFOUTPUT><input name="OrgID" type="hidden" value="#URL.OrgID#"></CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3 style="font-family:arial; size:11px;">
<tr>
  <td colspan="2">
     <cfoutput>
	 <table border="0" cellpadding="3" cellspacing="1" width="100%" style="font-family:arial;">
	   <tr bgcolor="##000066">
	      <td><strong style="color:##ffffff;"><a href="UpdParish.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Parish Home</a></strong></td>
		  <td><strong style="color:##ffffff;"><a href="Parishaccess.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Accessibility Options</a></strong></td>
		  <td><strong style="color:##ffffff;"><a href="ParishMinistries.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Parish Ministries</a></strong></td>
		  <!--- <td><strong style="color:##ffffff;"><a href="ParishLeadership.cfm?OrgID=#url.OrgID#" style="color:##ffffff;">Parish Leadership</a></strong></td> --->
	   </tr>
     </table>
	 </cfoutput>
  </td>
</tr>
<tr>
 <td>&nbsp;</td>
</tr>
<cfoutput>
  <tr>
  <td><strong>UPDATE #UCASE(GetParish.ParishName)# ACCESS OPTIONS</strong> </td>
</tr>
</cfoutput>

<tr>
 <td>&nbsp;</td>
</tr>
<tr>
  <td>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-family:arial;">
      <cfoutput query="chuchDetail" group="GroupID">
	     <tr>
		    <td width="2%">&nbsp;</td>
                     <td colspan="3"><strong>#chuchDetail.GroupName#</strong></td>
                  </tr>
		 <cfoutput>
		  <tr>
            <td width="2%">&nbsp;</td>
			<td width="6%"></td>
			<td width="2%"><input type="checkbox" name="churchaccess" value="#chuchDetail.CatID#" <cfif chuchDetail.CatExists NEQ "">checked</cfif>></td>
			<td width="80%">#chuchDetail.CatName#</td>
          </tr>
		 </cfoutput>
		 <tr><td colspan="4">&nbsp;</td></tr>
	  </cfoutput>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
      <tr>
	    <td colspan="4"><input type="submit" name="submit" value="Update Accessibility >>"></td>
	  </tr>
	</table>
  </td>
</tr>
<tr>
  
</tr>
</table>
</center>

</CFFORM>


</CFMODULE>

</HTML>