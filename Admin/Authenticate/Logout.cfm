
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Logout</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Administrator Logout">

<CFSET Session.LoggedIn = 0>
<cfset Session.AdmActive = 0>
<CFSET Session.UserID   = 0>
<CFSET Session.FullName = "">

<cflocation url="../" addtoken="No">

</CFMODULE>
</HTML>
