<HTML>
<HEAD>
	<TITLE>Submit a News Article</TITLE>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Enter a new News Article">

<font face="Verdana">

<cfform action="ProcessArticle.cfm" method="POST" enablecab="Yes" name="AddHeadline" enctype="multipart/form-data">
<input name="ArticleID" type="hidden" value="*">

<center>
<table border="0" cellspacing="1" cellpadding="3" bgcolor="#F3F3F3">

<tr>
	<td width=120 align=left><font size="-1"><b>Headline:</b></font></td>
	<td width=448 align=left><cfinput name="Headline" type="text" size=55 maxlength=120 required="Yes" Message="A headline for this article is required"></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1"><b>Sub Heading:</b></font></td>
	<td width=448 align=left><cfinput name="SubHeading" type="text" size=50 maxlength=100></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1"><b>Submitted by:</b></font></td>
	<td width=448 align=left><cfinput name="Author" type="text" value="David Skidmore" size=30 maxlength=50 required="Yes" Message="The Author of this article is required"></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1"><b>Posting Date:</b></font></td>
	<td width=448 align=left><cfinput name="SubmitDate" type="text" value="#DateFormat(now(), 'mm/d/yyyy')#" size=20 maxlength=20 required="Yes" Message="Please enter a posting date"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>On NewsWatch?</b></font></td>
	<td width=* align=left><input name="NewsWatch" type="checkbox" value="1"></td>
</tr>

<tr>
	<td colspan=2 align=center>
		<br><font size="-1"><b>Text of the Article:</b></font><br>
		<textarea name="ArticleText" cols="50" rows="8" wrap="VIRTUAL"></textarea></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1"><b>Image File:</b></font></td>
	<td width=* align=left><input type="file" name="FileContents" size="30" accept="image/jpeg,image/gif"></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1"><b>Alignment:</b></font></td>
	<td width=* align=left>
		<cfinput type="radio" name="ImgPosition" value="1" checked="Yes"><font face="Verdana,Arial" size="-1">Right side of Article</font>
		<cfinput type="radio" name="ImgPosition" value="2"><font face="Verdana,Arial" size="-1">Left side of Article</font>
		<br>&nbsp;
	</td>
</tr>


<tr>
	<td colspan=2><br><h3>Links to related items:</h3></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1"><b>URL:<br>Heading:</b></font></td>
	<td width=448 align=left><cfinput name="LR1URL" type="text" size=50 maxlength=100><br>
		<cfinput name="LR1Head" type="text" size=50 maxlength=75></td>
</tr>
<tr>
	<td width=120 align=left><font size="-1"><b>URL:<br>Heading:</b></font></td>
	<td width=448 align=left><cfinput name="LR2URL" type="text" size=50 maxlength=100><br>
		<cfinput name="LR2Head" type="text" size=50 maxlength=75></td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="Submit" name="Cmd" value="Save News Article"> 
		<input type="reset"  name="Cmd" value="Clear Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</font>

</CFMODULE>

</HTML>
