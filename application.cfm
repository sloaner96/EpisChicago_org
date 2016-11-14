<cfsetting enablecfoutputonly="Yes">

<cfapplication name="DioChicago"
               sessionmanagement="Yes"
               setclientcookies="Yes"
               sessiontimeout="#CreateTimeSpan(0,0,20,0)#"
               applicationtimeout="#CreateTimeSpan(0,1,0,0)#">

<CF_ClearSessionCookies>

<cfset Application.DSN			= "DioChicago">
<cfset Application.CTMapping	= "/DioChicago">
<cfset Application.Header		= "#Application.CTMapping#/DioHeader.cfm">
<cfset Application.Audit		= "#Application.CTMapping#/AuditLog.cfm">
<cfset Application.DirPath		= "d:\InetPub\WWWUsers\EpisChicago_Org">

<cfif NOT IsDefined("Application.Bishops")>
	<cfquery name="Bishops" datasource="#Application.DSN#">
		SELECT BishopID, BishopName From Bishops
			ORDER BY BishopID
	</cfquery>
	<cfset Application.Bishops = ListToArray(ValueList(Bishops.BishopName))>
</cfif>

<cfif NOT IsDefined("Application.SiteNfo")>
	<cfquery Name="Application.SiteNfo" Datasource="#Application.DSN#">
		SELECT * From SiteInfo
	</cfquery>
</cfif>

<!--- Set Session Variable for Diocesan Convention info --->
<cfif NOT IsDefined("Session.ConvNfo")>
	<cfquery name="Session.ConvNfo" datasource="#Application.DSN#">
		SELECT * From Conventions
			WHERE ConvID = 4
	</cfquery>
</cfif>

<!--- Set Handheld Flag to FALSE if first time in --->
<cfif NOT IsDefined("Session.Handheld")>
	<cfset Session.Handheld = 0>
	<cfif Find("PPC;", CGI.HTTP_USER_AGENT) gt 0>
		<cfset Session.Handheld = 1>
	</cfif>
</cfif>

<!--- Set Administrative User Flag to FALSE --->
<cfif NOT IsDefined("Session.AdmActive")>
	<cfset Session.AdmActive = 0>
</cfif>

<cfsetting enablecfoutputonly="No">

<cfif FindNoCase('Admin/', #CGI.SCRIPT_NAME#) gt 0 AND FindNoCase("Admin/Authenticate/Authorize.cfm", #CGI.SCRIPT_NAME#) is 0 >
	<cfif Session.AdmActive is 0>
		<cfinclude template="#Application.CTMapping#/Login.cfm">
		<cfabort>
	</cfif>
</cfif>

