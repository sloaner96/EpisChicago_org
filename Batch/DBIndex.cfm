<HTML>
<HEAD>
	<TITLE>Site Index for EpisChicago.ORG</TITLE>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Sitewide Index Processing">

<br>
<cfoutput>
<p>EpisChicago.ORG Indexing began on #DateFormat(now(), "mmmm d, yyyy")# at #TimeFormat(now(), "hh:mm:ss TT")#</p>
</cfoutput>
<blockquote>

<CFINDEX ACTION="PURGE" COLLECTION="DioChicago">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#"
         type="PATH"
		 URLpath="http://www.epischicago.org/"
		 Extensions=".cfm"
		 Recurse="No">

<cfindex action="update"
         collection="DioChicago"
         key="#Application.DirPath#\Forms"
         type="PATH"
         urlpath="http://www.epischicago.org/Forms/"
         extensions=".pdf"
         recurse="Yes">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\Bishop"
         type="PATH"
		 URLpath="http://www.epischicago.org/Bishop/"
		 Extensions=".cfm,.pdf"
		 Recurse="Yes">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\Cathedral"
         type="PATH"
		 URLpath="http://www.epischicago.org/Cathedral/"
		 Extensions=".cfm,.pdf"
		 Recurse="Yes">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\Diocese"
         type="PATH"
		 URLpath="http://www.epischicago.org/Diocese/"
		 Extensions=".cfm,.pdf"
		 Recurse="Yes">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\Faith"
         type="PATH"
		 URLpath="http://www.epischicago.org/Faith/"
		 Extensions=".cfm,.pdf"
		 Recurse="Yes">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\Ministries"
         type="PATH"
		 URLpath="http://www.epischicago.org/Ministries/"
		 Extensions=".cfm,.pdf"
		 Recurse="Yes">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\Albums"
         type="PATH"
		 URLpath="http://www.epischicago.org/Albums/"
		 Extensions=".cfm"
		 Recurse="No">

<cfindex action="Update"
         collection="DioChicago"
         key="#Application.DirPath#\News"
         type="PATH"
		 URLpath="http://www.epischicago.org/News/"
		 Extensions=".cfm"
		 Recurse="Yes">

<cfoutput><p>#TimeFormat(now(), "hh:mm:ss TT")#: Static Web files have been indexed!</p></cfoutput>

<cfquery name="GetArticles" datasource="#Application.DSN#">
	SELECT * From Articles
		WHERE Approved = True
</cfquery>

<cfindex action="REFRESH"
         collection="DioNews"
         key="ArticleID"
         type="CUSTOM"
         title="Headline"
         query="GetArticles"
         body="Headline,SubHeading,ArticleText"
		 custom2="http://www.epischicago.org/News/ViewArticle.cfm?ArticleID=">

<cfoutput><p>#TimeFormat(now(), "hh:mm:ss TT")#: News Headlines have been indexed!</p></cfoutput>

<cfquery name="GetEvents" datasource="#Application.DSN#">
	SELECT * From Events
		WHERE Approved = True
</cfquery>

<cfindex action="REFRESH"
         collection="DioEvents"
         key="EventID"
         type="CUSTOM"
         title="EventName"
         query="GetEvents"
         body="EventName,Location,Contact,Description"
		 custom2="http://www.epischicago.org/ViewEvent.cfm?EventID=">

<cfoutput><p>#TimeFormat(now(), "hh:mm:ss TT")#: Events have been indexed!</p></cfoutput>


<cfquery name="GetParish" datasource="#Application.DSN#">
	SELECT d.OrgID, d.DeaneryID, d.ParishName, d.City, c.FirstName, c.LastName From Directory d
		LEFT OUTER JOIN Contacts c ON (c.ContactID = d.ContactID)
</cfquery>

<cfindex action="REFRESH"
         collection="DioParish"
         key="OrgID"
         type="CUSTOM"
         title="ParishName"
         query="GetParish"
         body="ParishName,City,FirstName,LastName"
		 custom2="http://www.epischicago.org/Diocese/DirParishInfo.cfm?PID=">

<cfoutput><p>#TimeFormat(now(), "hh:mm:ss TT")#: #GetParish.RecordCount# Parishes have been indexed!</p></cfoutput>

<cfquery name="GetConv" datasource="#Application.DSN#">
	SELECT * From Conventions
		WHERE ConvID <= #Session.ConvNfo.ConvID#
</cfquery>

<cfindex action="REFRESH"
         collection="DioConv"
         key="ConvID"
         type="CUSTOM"
         title="Title"
         query="GetConv"
         body="Title,ThemeLine,Intro,PresidedBy,RegistrationInfo,NominationInfo,ResolutionInfo,MealInfo"
		 custom2="http://www.epischicago.org/Diocese/Convention/index.cfm?ConvID=">

<cfoutput><p>#TimeFormat(now(), "hh:mm:ss TT")#: Convention Info have been indexed!</p></cfoutput>

<cfquery name="GetSermon" datasource="#Application.DSN#">
	SELECT * From Sermons
		WHERE BishopID is not NULL
</cfquery>

<cfindex action="REFRESH"
         collection="DioSermon"
         key="SermonID"
         type="CUSTOM"
         title="SermonTitle"
         query="GetSermon"
         body="SermonTitle,SermonText"
		 custom2="http://www.epischicago.org/Bishop/Persell/index.cfm?SID=">

<cfoutput><p>#TimeFormat(now(), "hh:mm:ss TT")#: Bishop Sermons have been indexed!</p></cfoutput>

</blockquote>
<br>

<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Site Index" Status="OK" Message="Site ReIndex completed">

<cfoutput>
<p>EpisChicagp.ORG Indexing ended on #DateFormat(now(), "mmmm d, yyyy")# at #TimeFormat(now(), "hh:mm:ss TT")#</p>
</cfoutput>

</cfmodule>

</HTML>
