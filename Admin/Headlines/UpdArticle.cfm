<CFIF NOT IsDefined("URL.ArticleID")>
	<CFLOCATION URL="/Admin/">
</CFIF>

<CFQUERY Name="GetArticle" Datasource="#Application.DSN#">
	SELECT * from Articles
		WHERE ArticleID = #URL.ArticleID#
</CFQUERY>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify News Article</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Modify News Article">


<CFLOOP Query="GetArticle">
<CFFORM Name="ModHeadline" Action="ProcessArticle.cfm">
<CFOUTPUT><input type="hidden" name="ArticleID" value="#ArticleID#"></CFOUTPUT>

<center>
<table border=0 cellspacing=1 cellpadding=3 bgcolor="#F3F3F3">

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Headline</b></font>:</td>
	<td width=* align=left><cfinput name="Headline" type="text" value="#HTMLEditFormat(Headline)#" size=40 maxlength=65 required="Yes" Message="A headline for this article is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Sub Title:</b></font></td>
	<td width=* align=left><cfinput name="SubHeading" type="text" value="#HTMLEditFormat(SubHeading)#" size=40 maxlength=75></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Submitted by:</b></font></td>
	<td width=* align=left><cfinput name="Author" type="text" value="#SubmittedBy#" size=30 maxlength=30 required="Yes" Message="The Author of this article is required"></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>On NewsWatch?</b></font></td>
	<td width=* align=left><input name="NewsWatch" type="checkbox" value="1" <cfif HighLight is True>checked</cfif> ></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Article Text:</b></font></td>
	<td width=* align=left><cfoutput><textarea name="ArticleText" cols="40" rows="8" wrap="VIRTUAL">#HTMLEditFormat(ArticleText)#</textarea></cfoutput></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Image File:</b></font></td>
	<td width=* align=left><cfinput name="ImgPath" type="text" value="#ImgPath#" size=30 maxlength=40 required="No"></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>Alignment:</b></font></td>
	<td width=* align=left>
		<input type="radio" name="ImgPosition" value="1" <cfif ImgPosition eq 1>checked</cfif> ><font face="Verdana,Arial" size="-1">Right side of Article</font>
		<input type="radio" name="ImgPosition" value="2" <cfif ImgPosition eq 2>checked</cfif> ><font face="Verdana,Arial" size="-1">Left side of Article</font>
		<br>&nbsp;
	</td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>URL:<br>Heading:</b></font></td>
	<td width=* align=left><cfinput name="LR1URL" type="text" value="#LR1URL#" size=40 maxlength=100><br>
		<cfinput name="LR1Head" type="text" value="#LR1Head#" size=40 maxlength=75></td>
</tr>

<tr>
	<td width=120 align=left><font face="Verdana,Arial" size="-1"><b>URL:<br>Heading:</b></font></td>
	<td width=* align=left><cfinput name="LR2URL" type="text" value="#LR2URL#" size=40 maxlength=100><br>
		<cfinput name="LR2Head" type="text" value="#LR2Head#" size=40 maxlength=75></td>
</tr>

<tr>
	<td colspan=2 align=center><br>
		<input type="submit" name="Cmd" value="Delete News Article">
		<input type="Submit" name="Cmd" value="Update News Article"> 
		<input type="reset" value="Reset Form">
	</td>
</tr>

</table>
</center>

</CFFORM>
</CFLOOP>


</CFMODULE>

</HTML>
