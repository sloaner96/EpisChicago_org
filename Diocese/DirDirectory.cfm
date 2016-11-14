<cfquery name="Cities" datasource="#Application.DSN#">
	SELECT Distinct(City) From Directory
		WHERE ParishType IN ('M','P')
		ORDER BY City
</cfquery>
<cfquery name="Parishes" datasource="#Application.DSN#">
	SELECT d.*, c.Prefix, c.FirstName, c.MiddleName, c.LastName, c.Suffix From Directory d
		LEFT OUTER JOIN Contacts c ON (d.ContactID = c.ContactID)
		WHERE d.ParishType IN ('M','P')
		ORDER BY d.City, d.ParishName
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
	<TITLE>Chicago Diocese -- Diocesan Directory by City</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Parish Directory"
	subtitle="Diocesan Directory by City"
	postdate="">

<div align=right><i><font face="Arial" size="-1">(M)=Organized Mission&nbsp;&nbsp;&nbsp;<a href="DirDeanery.cfm">Directory by Deanery</a></font></i></div><br>

<table width=125 align=right border=0 bgcolor=#F3F3F3 cellpadding=4>
<tr valign=top>
<td><font face="Verdana,Arial" size="-1">
<p align=center><b>Locate<br>churches in:</b><hr></p>
<cfoutput query="Cities"><a href="###Replace(City,' ','','ALL')#">#City#</a><br><br></cfoutput>
</font></td>
</tr>
</table>

<table border="0" cellpadding="4" cellspacing="0">
<cfoutput query="Parishes" GROUP="City">

	<tr valign=top>
		<td width=100>
			<font face="Verdana,Arial" size="-1">
			<a name="#Replace(City,' ','','ALL')#"></a><b>#UCase(City)#</b>
			</font>
		</td>
		<td>
		<cfoutput>
			<font face="Verdana,Arial" size="-1">
			<b><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse>#ParishName#</cfif></b><cfif ParishType is "M"> (M)</cfif>,
			#Address1#, <cfif Address2 is not "">#Address2#, </cfif>#City#, #State#  #ZipCode#<cfif Phone is not "">, Tel: #Phone#</cfif><cfif FAX is not "">, FAX: #FAX#</cfif><cfif EMail is not "">, <a href="mailto:#EMail#">#EMail#</a></cfif><cfif FirstName is not "">, #Prefix# #FirstName# #MiddleName# #LastName# #Suffix#</cfif><br><br>
			</font>
		</cfoutput>
		</td>
	</tr>

</cfoutput>
</table>

</cfmodule>

</HTML>
