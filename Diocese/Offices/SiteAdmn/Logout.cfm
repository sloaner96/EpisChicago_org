
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Logout</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" PageTitle="Administrator Logout">

<CFSET StructClear(#session#)>

<cflocation url="/index.cfm" addtoken="No">

</CFMODULE>
</HTML>
