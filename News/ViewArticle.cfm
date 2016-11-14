<CF_NoCache>

<CFIF NOT IsDefined("URL.ArticleID")>
	<CFLOCATION URL="/News/">
</CFIF>


<CFQUERY Name="Viewer" Datasource="#Application.DSN#">
	SELECT * from Articles
		WHERE ArticleID = #URL.ArticleID# AND Approved = True
</CFQUERY>

<CFIF #Viewer.RecordCount# eq 0>
	<CFLOCATION URL="/News/">
</CFIF>


<HTML>
<HEAD>
	<CFOUTPUT Query="Viewer">
	<TITLE>Chicago Diocese -- #Headline#</TITLE>
	</CFOUTPUT>
</HEAD>

<cfmodule template="#Application.header#"
	pagetitle="#Viewer.Headline#"
	PostDate="#DateFormat(Viewer.DateSubmitted, 'mmm d, yyyy')#">

<blockquote>
<font face="Verdana" size="-1">

<CFOUTPUT Query="Viewer">

<CFIF #ImgPosition# is 1>
	<CFSET Alignment = "Right">
<CFELSE>
	<CFSET Alignment = "Left">
</CFIF>

<h3><font face="Tahoma" color="Navy">#SubHeading#</font></h3>

<CFIF #ImgPath# is not "">
	<img src="#ImgPath#" align="#Alignment#" hspace=3 vspace=3>
</CFIF>

<p><font face="Tahoma" size="-1">#ParagraphFormat(ArticleText)#</font></p>

<cfif ImgPath is not "">
<br clear=#Alignment#>
</cfif>

<CFIF #LR1Head# is not "" OR #LR2Head# is not "">

	<h4><font face="Tahoma" color="Maroon">Links related to this story:</font></h4>
	<ul>
	<CFIF #LR1Head# is not "">
		<li><font size="-1"><a href="#LR1URL#">#LR1Head#</a></font><br>
	</CFIF>
	<CFIF #LR2Head# is not "">
		<li><font size="-1"><a href="#LR2URL#">#LR2Head#</a></font><br>
	</CFIF>
	</ul>

</CFIF>

</CFOUTPUT>

</font>
</blockquote>

</CFMODULE>

</HTML>
