<CFIF NOT IsDefined("URL.OrgID")>
	<CFLOCATION URL="index.cfm">
</CFIF>
<cfparam name="URL.Action" default="">
<CFQUERY Name="GetParish" Datasource="#Application.DSN#">
	SELECT * from Directory
		WHERE OrgID = #URL.OrgID#
</CFQUERY>

<CFQUERY Name="GetMinistries" Datasource="#Application.DSN#">
	SELECT * from FaithExplorerMinistrty
		WHERE OrgID = '#URL.OrgID#'
</CFQUERY>

<cfset Thisaction = "ADD">
<cfset Ministry = "">
<cfset ContactName = "">
<cfset Phone = "">
<cfset Email = "">


<cfif url.action EQ "EDIT">
	<CFQUERY Name="GetThisMinistry" Datasource="#Application.DSN#">
		SELECT * from FaithExplorerMinistrty
			WHERE MinistryID = #URL.MinID#
	</CFQUERY>
	
	<cfset Thisaction = "ADD">
	<cfset Ministry = GetThisMinistry.Desc>
	<cfset ContactName = GetThisMinistry.ContactName>
	<cfset Phone = GetThisMinistry.Phone>
	<cfset Email = GetThisMinistry.Email>
</cfif>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify Parish Information</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Parish Information">


<p align=center>Use this form to modify or delete the parish information displayed below.</p>


<center>
<table border=0 cellspacing=1 cellpadding=3 style="font-family:verdana; size:11px;">
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
  <td><strong>UPDATE #UCASE(GetParish.ParishName)# MINISTRIES</strong> </td>
</tr>
</cfoutput>
<tr>
  <td><CFOUTPUT>
    <form name="AddMinistry" action="ParishMinistries_action.cfm?action=#ThisAction#" METHOD="POST">
	 
	   <input name="OrgID" type="hidden" value="#URL.OrgID#">
	   <cfif url.action EQ "EDIT"><input name="MinistryID" type="hidden" value="#GetThisMinistry.MinistryID#"></cfif>
	
		<table border="0" cellpadding="2" cellspacing="3" style="font-family:verdana; font-size:10px;">
	      <tr>
	        <td><strong>Ministry Name:</strong></td>
			<td><input type="text" name="MinDesc" size="35" maxlength="100" value="#Ministry#"></td>
	     </tr>
		 <tr>
	        <td><strong>Contact Name:</strong></td>
			<td><input type="text" name="Contact" size="25" maxlength="75" value="#ContactName#"></td>
	     </tr>
		 <tr>
	        <td><strong>Phone:</strong></td>
			<td><input type="text" name="Phone" size="25" maxlength="25" value="#Phone#"></td>
	     </tr>
		 <tr>
	        <td><strong>Email:</strong></td>
			<td><input type="text" name="Email" size="25" maxlength="75" value="#Email#"></td>
	     </tr>
		 <tr>
		   <td colspan="2">&nbsp;</td>
		 </tr>
		 <tr>
		   <td colspan="2" align="center"><input type="submit" name="submit" value="#Action# Ministry >>"></td>
		 </tr>
	    </table>
	  
	</form></CFOUTPUT>	
  </td>
</tr>
<tr>
  <td>
  <cfif GetMinistries.Recordcount GT 0>
    <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="#eeeeee" style="font-family:verdana; font-size:10px;">
      <tr bgcolor="#444444">
	    <td></td>
        <td><strong style="color:#fff;">Ministry Name</strong></td>
		<td><strong style="color:#fff;">Contact</strong></td>
		<td><strong style="color:#fff;">Phone</strong></td>
		<td><strong style="color:#fff;">Email</strong></td>
     </tr>
	 <cfoutput query="GetMinistries">
		  <tr bgcolor="##ffffff">
	        <td><a href="ParishMinistries.cfm?orgID=#URL.ORGID#&Action=EDIT&MINID=#GetMinistries.MinistryID#">[EDIT]</a> <a href="ParishMinistries_action.cfm?orgID=#URL.ORGID#&Action=REMOVE&MINID=#GetMinistries.MinistryID#" style="color:##CC0000;">[REMOVE]</a></td>
			<td>#GetMinistries.Desc#</td>
			<td>#GetMinistries.ContactName#</td>
			<td>#GetMinistries.Phone#</td>
			<td><a href="MAILTO:#GetMinistries.Email#">#GetMinistries.Email#</a></td>
	     </tr>
	 </cfoutput>
    </table>
   <cfelse>
     <strong style="color:#CC0000;font-size:11px;">There are currently no ministries associated with this parish</strong>	
   </cfif>	
  </td>
</tr>

</table>
</center>


</CFMODULE>

</HTML>