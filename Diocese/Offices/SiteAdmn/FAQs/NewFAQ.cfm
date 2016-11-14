<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>

<CFQUERY Name="Cats" Datasource="#Application.DSN#">
	SELECT * From qFAQ
		ORDER BY CodeValue
</CFQUERY>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Enter a new FAQ</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  PageTitle="Enter a new FAQ">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
			<td width="1" bgcolor="#000000"></td> 
			<td valign="Top">
				<blockquote>
				<font face="Verdana,Arial">
				
				<cfform action="ProcessFAQ.cfm" method="POST" enablecab="Yes" name="AddFAQ" enctype="multipart/form-data">
				<cfoutput><input name="GroupID" type="hidden" value="#Url.GroupID#"></cfoutput>
				<input name="FaqID" type="hidden" value="*">
				
				<table border="0" cellspacing="1" cellpadding="3">
				<tr>
					<td width=120 align=left><font size="-1"><b>Question:</b></font></td>
					<td width=448 align=left><cfinput name="Question" type="text" size=55 maxlength=120 required="Yes" Message="A headline for this announcement is required"></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1"><b>Category:</b></font></td>
					<td width=448 align=left><cfselect name="Category" size=1 query="Cats" Value="CodeValue" display="CodeDesc" required="Yes" Message="A Category must be specified"><option selected value="*">--- Select a Category ---</option></cfselect></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1"><b>Rank Sequence:</b></font></td>
					<td width=448 align=left><cfinput name="Ranking" type="text" size=2 maxlength=2 value="5" validate="integer" range="1,50" required="Yes" Message="A ranking order between 1 and 50 is required"></td>
				</tr>
				
				<tr>
					<td colspan=2 align=center>
						<br><font size="-1"><b>Provide the answer to this Question:</b></font><br>
						<textarea name="Answer" cols="50" rows="8" wrap="VIRTUAL"></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan=2 align=center><br>
						<input type="Submit" name="Cmd" value="Save FAQ"> 
						<input type="reset"  name="Cmd" value="Clear Form">
					</td>
				</tr>
				
				</table>
				
				</CFFORM>
				</font>
				</blockquote>
	  </td>
	</tr>
</table>
</CFMODULE>

</HTML>
