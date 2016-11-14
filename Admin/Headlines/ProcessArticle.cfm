<CFIF NOT IsDefined("Form.ArticleID")>
	<CFLOCATION URL="/Admin/">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Article Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Article Processing">


<cfset ErrorList = ArrayNew(1)>

<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.Headline# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Headline</b> field")>
	</CFIF>
	
	<CFIF #Form.Author# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Submitted by</b> field")>
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

	<!--- ****************************************************** --->
	<!--- Process the Record here 						 --->

	<CFIF Left(Form.Cmd, 4) is "Save">
		<cfif Form.FileContents is not "">
			<cfset FullName = GetFileFromPath("#Form.FileContents#")>
			<cfset FullName = Replace(Fullname, '.tmp', '.jpg')>
			<cffile action="UPLOAD"
		        filefield="Form.FileContents"
		        destination="#Application.DirPath#\images\News\#FullName#"
		        nameconflict="OVERWRITE">
			<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Image Upload" Status="OK" Message="#Session.FullName# uploaded image: '#FullName#'" User="#Session.UserID#">
		<cfelse>
			<cfset FullPath = "">
		</cfif>

		<CFQUERY Name="AddRec" Datasource="#Application.DSN#">
			INSERT into Articles
				(DateSubmitted,
				Headline,
				SubHeading,
				SubmittedBy,
				ImgPath,
				ImgPosition,
				ArticleText,
				Approved,
				HighLight,
				LR1Head,
				LR1URL,
				LR2Head,
				LR2URL
				)
			VALUES
				(#CreateODBCDate(Form.SubmitDate)#,
				 '#Form.Headline#',
				 '#Form.Subheading#',
				 '#Form.Author#',
				 <cfif IsDefined("FullName")>
				 '/images/News/#FullName#',
				 <cfelse>
				 NULL,
				 </cfif>
				 #Form.ImgPosition#,
				 '#Form.ArticleText#',
				 1,
				 <cfif IsDefined("Form.NewsWatch")>1<cfelse>0</cfif>,
				 '#Form.LR1Head#',
				 '#Form.LR1URL#',
				 '#Form.LR2Head#',
				 '#Form.LR2URL#'
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Article" Status="OK" Message="#Session.FullName# added Article: '#Form.Headline#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">Your news article has been Entered!</FONT></H3>

	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From Articles
				WHERE ArticleID = #Form.ArticleID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Article" Status="OK" Message="#Session.FullName# deleted Article: '#Form.Headline#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Arial Black" COLOR="Blue">Your news article has been Removed!</FONT></H3>

	<CFELSE>
		<CFQUERY Name="UpdInfo" Datasource="#Application.DSN#">
			UPDATE Articles
			SET
			Headline 	= '#Form.Headline#',
			SubHeading	= '#Form.SubHeading#',
			SubmittedBy	= '#Form.Author#',
			HighLight	= <cfif IsDefined("Form.NewsWatch")>1<cfelse>0</cfif>,
			ImgPath		= '#Form.ImgPath#',
			ImgPosition = #Form.ImgPosition#,
			ArticleText	= '#Form.ArticleText#',
			LR1Head		= '#Form.LR1Head#',
			LR1URL		= '#Form.LR1URL#',
			LR2Head		= '#Form.LR2Head#',
			LR2URL		= '#Form.LR2URL#'
			WHERE ArticleID = #Form.ArticleID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Article" Status="OK" Message="#Session.FullName# updated Article: '#Form.Headline#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Arial Black" COLOR="Blue">Your news article has been Updated!</FONT></H3>
	</CFIF>

</cfif>

<p align=center><a href="/Admin/"><font face="Tahoma" color="Maroon" size="+1">Return to Admin Page</font></a></p>

</CFMODULE>

</HTML>
