<cfif NOT IsDefined("URL.File")>
	<cflocation url="NewsLoader.cfm">
</cfif>

<cffile action="READ" file="#Application.DirPath#\News\#URL.File#" variable="NewsText">
<cfset SPos = FindNoCase("<TITLE>", NewsText)>
<cfset EPos = FindNoCase("</TITLE>", NewsText, SPos)>
<cfset Headline = "#Mid(NewsText,SPos+26,EPos-(SPos+26))#">
<cfset NewsDate = "#Mid(URL.File,6,2)#" & "/" & "#Mid(URL.File,8,2)#" & "/" & "19#Mid(URL.File,4,2)#">
<cfset NewsText = ReplaceList(NewsText, "<p>,<P>,</p>,</P>", "#chr(13)##chr(10)#,#chr(13)##chr(10)#,#chr(13)##chr(10)#,#chr(13)##chr(10)#")>

<HTML>
<HEAD>
	<TITLE>News Editor for EpisChicago.ORG</TITLE>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="News Article PreProcessing Editor">

<blockquote>
<font face="Verdana" size="-1">

<cfform name="EditArticle" method="POST" action="Article-Load.cfm">
<cfoutput><input type="hidden" name="FileName" value="#URL.File#"></cfoutput>

<table width=100% border=0 cellpadding=2 cellspacing=2>
<tr valign=top>
	<td width=120 align=left><font size="-1"><b>FileName:</b></font></td>
	<td width=*><cfoutput>#URL.File#</cfoutput></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1"><b>Headline:</b></font></td>
	<td width=*><cfinput type="text" name="HeadlineText" value="#Headline#" size=80 maxlength=120 required="Yes" Message="Please enter a headline for this article"></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1"><b>SubHeadline:</b></font></td>
	<td width=*><cfinput type="text" name="SubHeading" value="" size=80 maxlength=100 required="No"></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1"><b>Image:</b></font></td>
	<td width=*><cfinput type="text" name="ImageName" value="" size=40 maxlength=40 required="No"></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1"><b>Posted on:</b></font></td>
	<td width=*><cfinput type="text" name="SubmitDate" value="#NewsDate#" size=20 maxlength=20 validate="date" required="No"></td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1"><b>Article Text:</b></font></td>
	<td width=*><cfoutput><textarea cols=70 rows=20 name="ArticleText" wrap="virtual">#HTMLEditFormat(NewsText)#</textarea></cfoutput></td>
</tr>

<tr valign=top>
	<td colspan=2 align=center>
		<input type="Submit" name="Cmd" value="Load Article">&nbsp;&nbsp;
		<input type="Reset" name="Cmd" value="Reset Form">
	</td>
</tr>

</table>
</cfform>

</font>
</blockquote>

</cfmodule>

</HTML>
