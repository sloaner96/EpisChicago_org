

<cfif NOT IsDefined("URL.ID")>
	<cflocation url="index.cfm" addtoken="No">
</cfif>

<CFQUERY Name="Cats" Datasource="#Application.DSN#">
	SELECT * From qFAQ
		ORDER BY CodeValue
</CFQUERY>
<cfquery name="GetFAQ" datasource="#Application.DSN#">
	SELECT * From FAQs
		WHERE FaqID = #URL.ID#
</cfquery>
<cfif GetFAQ.RecordCount is 0>
	<cflocation url="index.cfm" addtoken="No">
</cfif>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify a FAQ Entry</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin"  PageTitle="Modify a FAQ Entry">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
			<td valign="Top">
				<blockquote>
				<font face="Verdana,Arial">
				<cfloop query="GetFAQ">
				
				<cfform action="ProcessFAQ.cfm" method="POST" name="UpdFAQ">
				<cfoutput><input name="FaqID" type="hidden" value="#FaqID#"></cfoutput>
				<cfoutput><input name="GroupID" type="hidden" value="#Url.GroupID#"></cfoutput>
				<table border="0" cellspacing="1" cellpadding="3">
				<tr>
					<td width=120 align=left><font size="-1"><b>Question:</b></font></td>
					<td width=448 align=left><cfinput name="Question" type="text" value="#Question#" size=55 maxlength=120 required="Yes" Message="A headline for this announcement is required"></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1"><b>Category:</b></font></td>
					<td width=448 align=left><cfselect name="Category" size=1 query="Cats" Value="CodeValue" display="CodeDesc" selected="#Category#" required="Yes" Message="A Category must be specified"></cfselect></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1"><b>Rank Sequence:</b></font></td>
					<td width=448 align=left><cfinput name="Ranking" type="text" size=2 maxlength=2 value="#Ranking#" validate="integer" range="1,50" required="Yes" Message="A ranking order between 1 and 50 is required"></td>
				</tr>
				
				<tr>
					<td colspan=2 align=center>
						<br><font size="-1"><b>Provide the answer to this Question:</b></font><br>
						<cfoutput><textarea name="Answer" cols="50" rows="8" wrap="VIRTUAL">#HTMLEditFormat(Response)#</textarea></cfoutput>
					</td>
				</tr>
				
				<tr>
					<td colspan=2 align=center><br>
						<input type="submit" name="Cmd" value="Delete FAQ" onClick="return confirm('Are you sure you want to delete this?');">
						<input type="Submit" name="Cmd" value="Update FAQ"> 
						<input type="reset"  name="Cmd" value="Reset Form">
					</td>
				</tr>
				
				</table>
				
				</CFFORM>
				</cfloop>
				</font>
				</blockquote>
	  </td>
	</tr>
</table>
</CFMODULE>

</HTML>
