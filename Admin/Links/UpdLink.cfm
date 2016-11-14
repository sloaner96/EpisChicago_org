<CFIF NOT IsDefined("URL.LinkID")>
	<CFLOCATION URL="default.cfm">
</CFIF>

<CFQUERY Name="GetLink" Datasource="#Application.DSN#">
	SELECT * from SiteLinks
		WHERE LinkID = #URL.LinkID#
</CFQUERY>
<cfquery name="Cats" datasource="#Application.DSN#">
	SELECT * From qLinkCat
		ORDER BY CodeValue
</cfquery>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify New Web Site Link</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE TEMPLATE="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify a New Web Site Link">

<blockquote>
<font face="Verdana" size="-1">

<p align=center>Use this form to modify or delete the staff information displayed below.</p>


<CFLOOP Query="GetLink">

<CFFORM Name="UpdLink" Action="LinkProcess.cfm">
<CFOUTPUT><input name="LinkID" type="hidden" value="#URL.LinkID#"></CFOUTPUT>

<table width="100%" border=0 cellspacing=1 cellpadding=3>
<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Web Site</b></font>:</td>
	<td width=* align=left><cfinput name="SiteName" type="text" value="#SiteName#" size=30 maxlength=80></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Web URL</b></font>:</td>
	<td width=* align=left><cfinput name="WebURL" type="text" value="#SiteURL#" size=40 maxlength=130></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Category</b></font>:</td>
	<td width=* align=left><cfselect name="Category" query="Cats" selected="#Category#" display="CodeDesc" value="CodeID" size=1></cfselect></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Description</b></font>:</td>
	<td width=* align=left><cfoutput><textarea cols=40 rows=3 name="Description" wrap="virtual">#HTMLEditFormat(Description)#</textarea></cfoutput></td>
</tr>

<tr valign=bottom>
	<td align=center><br><input type="submit" name="Cmd" value="Delete Link" onClick="return confirm('Are you sure you want to delete this?');"></td>
	<td width=* align=left>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="Submit" name="Cmd" value="Update Link"> 
			<input type="reset"  name="Cmd" value="Reset Form">
		</td>
	</td>
</tr>

</table>

</CFFORM>
</CFLOOP>

</font>
</blockquote>

</CFMODULE>

</HTML>
