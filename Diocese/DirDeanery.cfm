<cfquery name="DeanList" datasource="#Application.DSN#">
	SELECT * From Deaneries
		ORDER BY Name
</cfquery>
<cfquery name="Parishes" datasource="#Application.DSN#">
	SELECT d.*, c.Prefix, c.FirstName, c.MiddleName, c.LastName, c.Suffix, (select Name From Deaneries n where n.DeaneryID = d.DeaneryID) as Name From Directory d
		LEFT OUTER JOIN Contacts c ON (d.ContactID = c.ContactID)
		WHERE ParishType <> 'D'
		<cfif IsDefined("URL.DID")><cfif URL.DID is not "">AND DeaneryID = #URL.DID#</cfif></cfif>
		ORDER BY d.DeaneryID, d.City, d.ParishName
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
	<TITLE>Chicago Diocese -- Diocesan Directory by Deanery</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Parish Directory"
	subtitle="Diocesan Directory by Deanery"
	postdate="">

<center>
<form method="GET" action="DirDeanery.cfm">
<table width=90% border=0 cellspacing=2 cellpadding=1>
<tr valign=middle>
	<td align=left width=50%>
	<select name="DID" size=1>
	<option value="">All deaneries</option>
	<cfoutput query="DeanList"><option value="#DeaneryID#">#Name#</option></cfoutput>
	</select>&nbsp;<input type="Submit" value="Display Deanery">
	</td>
	<td align=right width=50%><i><font face="Arial" size="-1">(M)=Organized Mission&nbsp;&nbsp;&nbsp;<a href="DirDirectory.cfm">Directory by City</a></font></i></td>
</tr>
</table>
</form>
</center>

<blockquote>

<table border="0" cellpadding="4" cellspacing="0">
<cfoutput query="Parishes" GROUP="DeaneryID">

	<tr valign=top bgcolor="##F3E9DE">
		<td colspan=2><a name="#Replace(Name,' ','','ALL')#"></a><font face="Tahoma,Arial" size="+1" color="Navy">#Name# Deanery</font></td>
	</tr>

	<cfoutput Group="City">
	<tr valign=top>
		<td width=100>
			<font face="Verdana,Arial" size="-1"><b>#UCase(City)#</b></font>
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

</cfoutput>
</table>

</blockquote>
</cfmodule>

</HTML>
