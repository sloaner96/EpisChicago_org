<CFIF NOT IsDefined("URL.MarketID")>
	<CFLOCATION URL="JobSearch.cfm">
</CFIF>

<CFQUERY Name="GetJob" Datasource="#Application.DSN#">
	SELECT * from MarketJobs
		WHERE MarketID = #URL.MarketID#
</CFQUERY>

<cfquery name="ParishList" datasource="#Application.DSN#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		ORDER BY ParishName
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify Market Job Record</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify MarketPlace Job">

<blockquote>
<font face="Verdana" size="-1">
<p align=center>Use this form to modify or delete the job opening displayed below.</p>
</font>

<CFLOOP Query="GetJob">

<CFFORM Name="UpdJob" Action="JobProcess.cfm">
<CFOUTPUT><input name="MarketID" type="hidden" value="#URL.MarketID#"></CFOUTPUT>

<table width="100%" border=0 cellspacing=1 cellpadding=3>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Title</b></font>:</td>
	<td width=* align=left><cfinput name="Title" value="#Title#" type="text" size=40 maxlength=80 required="Yes" Message="The Title for this position is required"></td>
</tr>

<cfif Location is not "">
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Location</b></font>:</td>
	<td width=* align=left><cfinput name="Location" value="#Location#" type="text" size=40 maxlength=80 required="Yes" Message="Please enter the parish for this opening"></td>
</tr>
<cfelse>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Parish</b></font>:</td>
	<td width=* align=left><cfselect name="Parish" size=1 selected="#DirectID#" query="ParishList" display="PName" value="OrgID" required="no"><option value="*">--- Select a Parish ---</option></cfselect></td>
</tr>
</cfif>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Contact</b></font>:</td>
	<td width=* align=left><cfinput name="Contact" value="#Contact#" type="text" size=30 maxlength=40 required="Yes" Message="A Contact person for this position is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Phone</b></font>:</td>
	<td width=* align=left><cfinput name="Phone" value="#ContactPhone#" type="text" size=20 maxlength=20></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>EMail Address</b></font>:</td>
	<td width=* align=left><cfinput name="EMail" value="#ContactEMail#" type="text" size=30 maxlength=130></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Expires on</b></font>:</td>
	<td width=* align=left><cfinput name="DateExpires" value="#DateFormat(ExpiresOn, 'mm/d/yyyy')#" type="text" size=20 maxlength=20 validate="date"></td>
</tr>

<tr>
	<td colspan=2 align=left>
		<br><font face="Verdana,Arial" size="-1"><b>Description</b></font>:<br>
		<textarea name="JobDesc" cols="50" rows="6" wrap="VIRTUAL"><cfoutput>#Description#</cfoutput></textarea>
	</td>
</tr>

<tr>
	<td colspan=2 align=left><br>
		<input type="submit" name="Cmd" value="Delete Job">
		<input type="Submit" name="Cmd" value="Update Job"> 
		<input type="reset"  name="Cmd" value="Reset Form">
	</td>
</tr>

</table>

</CFFORM>
</CFLOOP>

</blockquote>

</CFMODULE>

</HTML>
