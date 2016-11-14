<CFIF NOT IsDefined("URL.OrgID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<CFQUERY Name="GetParish" Datasource="#Application.DSN#">
	SELECT * from Directory
		WHERE OrgID = #URL.OrgID#
</CFQUERY>
<cfquery name="Contacts" datasource="#Application.DSN#">
	SELECT Left(Prefix+' '+FirstName+' '+LastName, 35) as ContactName, ContactID From Contacts
		ORDER BY LastName, FirstName
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify Parish Information</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify Parish Information">


<p align=center>Use this form to modify or delete the parish information displayed below.</p>


<CFLOOP Query="GetParish">
<CFFORM Name="UpdParish" Action="ParishProcess.cfm" enctype="multipart/form-data">
<CFOUTPUT><input name="OrgID" type="hidden" value="#URL.OrgID#"></CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3>
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
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Company</b></font>:</td>
	<td width=* align=left><cfinput name="Parish" type="text" value="#ParishName#" size=40 maxlength=80 required="Yes" Message="A Parish Name is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish Type</b></font>:</td>
	<td width=* align=left>
		<select name="PType" size="1">
		<option value="*" <cfif ParishType is "">selected</cfif> >--- Type of Parish ---</option>
		<option value="P" <cfif ParishType is "P">selected</cfif> >Self Standing Parish</option>
		<option value="M" <cfif ParishType is "M">selected</cfif> >Mission Congregation</option>
		</select>
	</td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact</b></font>:</td>
	<td width=* align=left>
		<cfif ContactID is not "">
			<cfselect name="ContactID" selected="#ContactID#" size=1 query="Contacts" display="ContactName" value="ContactID"><option value="*">--- Select Rector/Vicar ---</option></cfselect>
		<cfelse>
			<cfselect name="ContactID" size=1 query="Contacts" display="ContactName" value="ContactID"><option selected value="*">--- Select Rector/Vicar ---</option></cfselect>
		</cfif>
	</td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Address 1</b></font>:</td>
	<td width=* align=left><cfinput name="Addr1" type="text" value="#Address1#" size=30 maxlength=40></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Address 2</b></font>:</td>
	<td width=* align=left><cfinput name="Addr2" type="text" value="#Address2#" size=30 maxlength=40></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>City</b></font>:</td>
	<td width=* align=left><cfinput name="City" type="text" value="#City#" size=20 maxlength=20></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>State</b></font>:</td>
	<td width=* align=left><cfinput name="State" type="text" value="#State#" size=2 maxlength=2></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>ZipCode</b></font>:</td>
	<td width=* align=left><cfinput name="ZipCode" type="text" value="#ZipCode#" size=10 maxlength=10></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Phone</b></font></td>
	<td width=* align=left><cfinput name="Phone" type="text" value="#Phone#" size=25 maxlength=25></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>FAX</b></font></td>
	<td width=* align=left><cfinput name="FAX" type="text" value="#FAX#" size=25 maxlength=25></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Email Address</b></font>:</td>
	<td width=* align=left><cfinput name="Email" type="text" value="#Email#" size=40 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Website</b></font>:</td>
	<td width=* align=left><cfinput name="WebURL" type="text" value="#WebSite#" size=40 maxlength=130></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Password</b></font>:</td>
	<td width=* align=left><cfinput name="Password" type="text" value="#Pswd#" size=15 maxlength=15></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Annual Pledge</b></font>:</td>
	<td width=* align=left><cfinput name="Pledge" type="text" value="#Trim(NumberFormat(AnnualPledge, 'L999,999.99'))#" size=10 maxlength=10></td>
</tr>
<cfoutput>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish Photo</b></font>:</td>
	<td width=* align=left><input name="ParishImg" type="file" value="" size=25 maxlength=75>&nbsp;<cfif imgPath NEQ ""><a href="/images/parishes/#imgPath#" style="font-size:10px; font-family:verdana;" target="_blank">[VIEW EXISTING]</a></cfif></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Programs</b></font>:</td>
	<td width=* align=left><textarea name="programs" cols="45" rows="10" wrap="virtual">#Trim(Programs)#</textarea></td>
</tr>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Worship Services</b></font>:</td>
	<td width=* align=left><textarea name="Worship" cols="45" rows="10" wrap="virtual">#Trim(WorshipServices)#</textarea></td>
</tr>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish Profile</b></font>:</td>
	<td width=* align=left><textarea name="parishProfile" cols="45" rows="10" wrap="virtual">#Trim(parishProfile)#</textarea></td>
</tr>
</cfoutput>
<tr>
	<td align=center><br><input type="submit" name="Cmd" value="Delete Parish" onClick="return confirm('Are you sure you want to delete this?');"></td>
	<td align=left><br>
		<input type="Submit" name="Cmd" value="Update Parish"> 
		<input type="reset"  name="Cmd" value="Clear Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</CFLOOP>

</CFMODULE>

</HTML>
