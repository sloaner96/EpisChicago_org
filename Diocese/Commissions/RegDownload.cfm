<cfquery name="ConfNfo" datasource="#Application.DSN#">
	SELECT c.*, d.ParishName, d.Address1, d.Address2, d.City, d.State, d.ZipCode, d.WebSite From Conferences c
		LEFT OUTER JOIN Directory d ON (d.OrgID = c.OrgID)
		WHERE ConfID = 2
</cfquery>

<cfif NOT IsDefined("Form.RegDate")>
	<HTML>
	<HEAD>
		<META HTTP-EQUIV="Content-language" CONTENT="en-US">
		<META NAME="rating" CONTENT="General">
		<META NAME="revisit-after" CONTENT="7 days">
		<META NAME="ROBOTS" CONTENT="ALL">
		<META NAME="keywords" CONTENT="workshops, conferences, seminars, episcopal, episcopal church, diocese, church, apostolic, christianity, christian, chicago, illinois, IL">
		<META NAME="description" CONTENT="">
		<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
		<cfoutput><TITLE>Chicago Diocese -- #ConfNfo.ConfName#</TITLE></cfoutput>
	</head>
	
	<cfmodule template="#Application.header#" NavAlign="Center" Banner="No">
	<blockquote>	
	
	<cfoutput query="ConfNfo">
	<cfif LogoImage neq ""><a href="#HomeURL#"><img src="/images/#LogoImage#" alt="" border="0" align=right></a></cfif>
	<p align=center>
	<font color="Blue" face="Tahoma,Arial" size="+3">
	#ConfName#
	</font><br><br>
	
	<cfif Theme neq "">
		<font color="Navy" face="Tahoma,Arial" size="+1">
		<i>#Theme#</i>
		</font><br><br>
	</cfif>
	
	<font face="Tahoma" color="Maroon" size="+2">Registration Download</font><br>
	<font face="Verdana" color="black" size="-1">
	<a href="#HomeURL#">Home</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<a href="Workshops.cfm">Workshop Descriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;
	<a href="Register.cfm">Register online!</a>
	</font>
	</p><br clear=all>
	
	</cfoutput>
	
	<FONT SIZE="-1" face="Verdana,Arial">
	<p>This page will allow you to download registration information -- individual name, address, phone, parish, workshop, lunch, and daycare preferences -- from the web site to your own computer in Microsoft Excel spreadsheet format.  This data can be used to generate mailing lists, workshop rosters, name tags, determine workshop popularity, or send this information to the Episcopal Center.</p>

	<center>
	<cfform action="RegDownload.cfm" method="POST">
		<b>Download Registrations since</b>
		<cfinput type="text" name="RegDate" value="#DateFormat(now(), 'mm/dd/yyyy')#" size=10 maxlength=10 validate="date" required="Yes" message="A beginning date for incoming registrations must be entered">
		&nbsp;&nbsp;<input type="Submit" value="Start Download!">
	</cfform>
	</center>

	</font>
	</blockquote>

	</CFMODULE>
	</html>

<cfelse>

	<cfquery name="DataRecs" datasource="#Application.DSN#" blockfactor="100">
		SELECT DateEntered, Name, Address1, City, State, ZipCode, Phone, Email, WS1 as Workshop1, WS2 as Workshop2, WS3 as Workshop3, WS4 as Workshop4, Comments as Ministry, MealChoice, DayCare,
			(select ParishName From Directory d where d.OrgID = a.OrgID) as ParishName
			From Applicants a
			WHERE a.ConfID = #ConfNfo.ConfID#
				AND DateEntered >= #CreateODBCDate("#Form.RegDate#")#
			ORDER BY a.AppID
	</cfquery>

	<cfset XlsFile = "#Application.DirPath#\Diocese\Commissions\LayMinistry.XLS">
	<cfif FileExists(XlsFile)>
		<cffile action="DELETE" file="#XlsFile#">
	</cfif>
	<CFX_Excel Query="DataRecs" File="#XlsFile#" Version="95">
	<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Download" Status="OK" Message="The Lay Ministry registration information was downloaded from the web site">

	<CF_Download FileName="#XlsFile#" DestName="layministry.xls" Mime="application/msexcel">

</cfif>

