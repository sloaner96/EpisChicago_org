
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Article Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Article Processing">


<cfset ErrorList = ArrayNew(1)>

<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.HeadlineText# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Headline</b> field")>
	</CFIF>
	
	<CFIF #Form.ArticleText# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Article Text</b> field")>
	</CFIF>
</cfif>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<CFQUERY Name="AddRec" Datasource="#Application.DSN#">
		INSERT into Articles
			(DateSubmitted,
			Headline,
			SubHeading,
			SubmittedBy,
			ImgPath,
			ImgPosition,
			ArticleText,
			Approved
			)
		VALUES
			(#CreateODBCDate(Form.SubmitDate)#,
			 '#Form.HeadlineText#',
			 '#Form.Subheading#',
			 'David Skidmore',
			 '#Form.ImageName#',
			 1,
			 '#Form.ArticleText#',
			 1
			)
	</CFQUERY>
	<cffile action="DELETE" file="#Application.DirPath#\News\#Form.FileName#">

	<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Article Load" Status="OK" Message="#Session.FullName# loaded Article: '#Form.HeadlineText#'" User="#Session.UserID#">

	<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your news article has been Entered!</FONT></H3>

</cfif>

<p align=center><a href="NewsLoader.cfm"><font face="Tahoma" color="Maroon" size="+1">Return to Loader Page</font></a></p>

</CFMODULE>

</HTML>
