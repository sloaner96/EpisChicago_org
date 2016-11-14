<cfif NOT IsDefined("URL.PID")>
	<cflocation url="/Diocese/Directory.cfm" addtoken="No">
</cfif>

<cfquery name="Parish" datasource="#Application.DSN#">
	SELECT	d.*, (select Name From Deaneries d1 where d1.DeaneryID = d.DeaneryID) as DeaneryName,
			c.Prefix, c.FirstName, c.MiddleName, c.LastName, c.Suffix, c.Email as ClergyEmail From Directory d
		LEFT OUTER JOIN Contacts c ON (c.ContactID = d.ContactID)
		WHERE d.OrgID = #URL.PID#
</cfquery>
<cfif Parish.RecordCount is 0>
	<cflocation url="/Diocese/Directory.cfm" addtoken="No">
</cfif>
	
<cfquery name="DeaneryList" datasource="#Application.DSN#">
	SELECT ParishName, OrgID, City From Directory d
		WHERE ParishType IN ('M','P')
			AND DeaneryID = #Parish.DeaneryID#
		ORDER BY d.ParishName
</cfquery>
<cfquery name="CityList" datasource="#Application.DSN#">
	SELECT Distinct City From Directory d
		WHERE ParishType IN ('M','P')
			AND DeaneryID = #Parish.DeaneryID#
		ORDER BY d.City
</cfquery>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese --Parish Information Page</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Parish Directory"
	subtitle="Diocesan Parish Information for #Parish.ParishName#"
	postdate="">

<table width=200 align=right border=0 bgcolor=#F3F3F3 cellpadding=4>
<tr valign=top>
	<td>
		<font face="Verdana,Arial" size="-1">
		<p align=center>Parishes located in the following cities of the<br><b><cfoutput>#Parish.DeaneryName# Deanery</cfoutput></b><hr></p>
		<cfoutput query="CityList">#City#<cfif CurrentRow lt CityList.RecordCount>,&nbsp;</cfif> </cfoutput><br>
		<p align=center><i><cfoutput>(#DeaneryList.RecordCount# parishes in Deanery)</cfoutput></i></p>
		</font>
	</td>
</tr>
</table>

<dir>
<div align=left>
<form method="GET" action="DirParishInfo.cfm">
<select name="PID" size=1>
<cfoutput query="DeaneryList"><option value="#OrgID#" <cfif OrgID eq #URL.PID#>selected</cfif>>#ParishName#</option></cfoutput>
</select>
<input type="Submit" value="View">
</form>
</div>

<cfoutput query="Parish">
<font face="Verdana,Arial">

<small>
<p><font color="Blue" face="Tahoma,Arial" size="+1">#ParishName#</font><br>
<cfif FirstName is not "">#Prefix# #FirstName# #MiddleName# #LastName# #Suffix# <cfif ClergyEmail neq "" AND ClergyEmail neq Email><small>(<a href="mailto:#ClergyEmail#">email</a>)</small></cfif></cfif></p>

<p><b>Parish Address</b><br>
#Address1#<br>
<cfif Address2 is not "">#Address2#<br></cfif>
#City#, #State#  #ZipCode#</p>

<cfif Phone is not "">Phone: #Phone#<br></cfif>
<cfif FAX is not "">FAX: #FAX#<br><br></cfif>
<cfif EMail is not "">Email:<br><a href="mailto:#EMail#">#EMail#</a><br><br></cfif>
<cfif WebSite is not "">Web Site:<br><a href="#WebSite#" target="_blank">#WebSite#</a><br></cfif>
</small>

</font>
</cfoutput>
</dir>

</cfmodule>
</HTML>
