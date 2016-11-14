<HTML>
<HEAD>
	<TITLE>News Loader for EpisChicago.ORG</TITLE>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="News Archive Loader">

<blockquote>
<font face="Verdana" size="-1">

<cfdirectory action="LIST" directory="#Application.DirPath#\News" name="NewsFiles" filter="nb*.*" sort="Name DESC">

<table border=0 cellspacing=4 cellpadding=2>
<tr>
	<th>Action</th>
	<th>News File</th>
	<th align=left>Article Title</th>
</tr>

<cfoutput query="NewsFiles">
	<cffile action="READ" file="#Application.DirPath#\News\#Name#" variable="NewsText">
	<cfset SPos = FindNoCase("<TITLE>", NewsText)>
	<cfset EPos = FindNoCase("</TITLE>", NewsText, SPos)>
	<tr valign=top>
		<td width=50><a href="LoadArticle.cfm?File=#Name#">Load</a></td>
		<td width=140><font size="-1">#Name#</font></td>
		<td width=*><font size="-1">#Mid(NewsText,SPos+7,EPos-(SPos+7))#</font></td>
	</tr>
</cfoutput>
</table>

</font>
</blockquote>

</cfmodule>

</HTML>
