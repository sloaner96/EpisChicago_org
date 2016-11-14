<CFQUERY Name="Cats" Datasource="#Application.DSN#">
	SELECT * From qFAQ
		ORDER BY CodeValue
</CFQUERY>
<CFQUERY Name="FAQsites" Datasource="#Application.DSN#">
	SELECT * From Lookups
		WHERE CodeGroup = 'FAQSITES'
		ORDER BY CodeValue
</CFQUERY>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Enter a new FAQ</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Enter a new FAQ">

<blockquote>
<font face="Verdana,Arial">

<cfform action="ProcessFAQ.cfm" method="POST" enablecab="Yes" name="AddFAQ" enctype="multipart/form-data">
<input name="FaqID" type="hidden" value="*">

<table border="0" cellspacing="1" cellpadding="3">
<tr>
	<td width=120 align=left><font size="-1"><b>FAQ Site:</b></font></td>
	<td width=448 align=left><cfselect name="Section" size=1 query="FAQsites" Value="CodeValue" display="CodeDesc" required="Yes" Message="A Site for these FAQs must be specified"><option selected value="*">--- Select Site ---</option></cfselect></td>
</tr>

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

</CFMODULE>

</HTML>
