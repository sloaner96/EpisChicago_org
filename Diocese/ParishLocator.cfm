<cfif NOT IsDefined("Form.City") AND NOT IsDefined("Form.Keyword") >
	<cflocation url="/Diocese/Directory.cfm" addtoken="No">
</cfif>
<cfif IsDefined("Form.City") AND Form.City is "*">
	<cflocation url="/Diocese/Directory.cfm" addtoken="No">
</cfif>
<cfif IsDefined("Form.Keyword") AND Form.Keyword is "">
	<cflocation url="/Diocese/Directory.cfm" addtoken="No">
</cfif>

<cfquery name="Parishes" datasource="#Application.DSN#">
	SELECT d.*, c.Prefix, c.FirstName, c.MiddleName, c.LastName, c.Suffix From Directory d
		LEFT OUTER JOIN Contacts c ON (d.ContactID = c.ContactID)
		<cfif IsDefined("Form.City")>
		WHERE d.City = '#Form.City#'
		<cfelse>
		WHERE (d.City LIKE '%#Form.Keyword#%'
			OR d.ParishName LIKE '%#Form.Keyword#%'
			OR c.FirstName LIKE '%#Form.Keyword#%'
			OR c.LastName LIKE '%#Form.Keyword#%'
			OR d.Address1 LIKE '%#Form.Keyword#%')
		</cfif>
		AND d.ParishType IN ('M','P')
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
	<TITLE>Chicago Diocese -- Diocesan Directory</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Parish Directory"
	subtitle="Diocesan Directory Listing"
	postdate="">

<blockquote>
<font face="Verdana,Arial" size="-1">

<cfif IsDefined("Form.City")>
	<cfoutput>
	<font face="Tahoma,Arial" size="+1" color="blue"><p align=center>There are <b>#Parishes.RecordCount#</b> parish/mission congregations<br>located within the '<font color="black">#Form.City#</font>' area.</p></font>
	</cfoutput>
	
	<cfoutput query="Parishes">
	<b><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse>#ParishName#</cfif></b><cfif ParishType is "M"> (M)</cfif>,
	#Address1#, <cfif Address2 is not "">#Address2#, </cfif>#City#, #State#  #ZipCode#<cfif Phone is not "">, Tel: #Phone#</cfif><cfif FAX is not "">, FAX: #FAX#</cfif><cfif EMail is not "">, <a href="mailto:#EMail#">#EMail#</a></cfif><cfif FirstName is not "">, #Prefix# #FirstName# #MiddleName# #LastName# #Suffix#</cfif><br><br>
	</cfoutput>
	
<cfelse>
	<cfoutput>
	<font face="Tahoma,Arial" size="+1" color="blue"><p align=center>There are <b>#Parishes.RecordCount#</b> parish/mission congregations<br>matching the criteria: '<font color="black">#Form.Keyword#</font>'.</p></font>
	</cfoutput>
	
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
	
</cfif>

<p>Click <a href="Directory.cfm">here</a> to perform another search</p>
</font>
</blockquote>

</cfmodule>
</HTML>
