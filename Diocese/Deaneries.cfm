<cfquery name="DeanList" datasource="#Application.DSN#">
	SELECT d.Name, p.*, (select c.Prefix+' '+c.FirstName+' '+c.LastName+' '+c.Suffix from Contacts c where c.ContactID = d.ContactID) as RevName
		From Deaneries d, Directory p
		WHERE p.OrgID = d.OrgID
		ORDER BY Name
</cfquery>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Diocesan Deanery Listing</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Parish Directory"
	subtitle="Deaneries of the Diocese"
	postdate="">

<blockquote>

<center>
<table width=90% border=0 cellspacing=3 cellpadding=3>

<cfoutput query="DeanList">
	<cfif CurrentRow eq 0>
	<tr valign=top>
	</cfif>

	<td valign=top width=50%>
		<table width=85% border=0 cellpadding=0 cellspacing=0>
			<tr valign=bottom>
				<td><font face="Tahoma,Arial" SIZE="+1" COLOR="Purple">#Name#</font></td>
				<td align=right><font face="Arial" SIZE="-2"><a href="DirDeanery.cfm?DID=#DeaneryID#">View Parishes</a></font></td>
			</tr>
		</table>
		<hr align=left width=85% size=1>
		<FONT face="Verdana,Arial" SIZE="-1"><cfif Trim(RevName) is not ""><i>#Trim(RevName)#</i><br></cfif>
		<cfif WebSite is not ""><a href="#WebSite#">#ParishName#</a><cfelse>#ParishName#</cfif><br>
		#Address1#<br>
		<cfif Address2 is not "">#Address2#<br></cfif>
		#City#,  #State#  #ZipCode#<br>
		<cfif Phone is not "">#Phone#<br></cfif>
		<cfif Email is not ""><a href="mailto:#Email#">#Email#</a></cfif></p>
		</font>
	</td>

	<cfif (CurrentRow MOD 2) eq 0>
	</tr>
	<tr valign=top>
	</cfif>
</cfoutput>
<cfif (DeanList.RecordCount MOD 2) neq 0>
	</tr>
</cfif>

</table>
</center>

</blockquote>
</cfmodule>

</HTML>
