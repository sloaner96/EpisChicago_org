<cfquery name="Cities" datasource="#Application.DSN#">
	SELECT Distinct(City) From Directory
		WHERE ParishType IN ('M','P')
		ORDER BY City
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
	<TITLE>Chicago Diocese -- Diocesan Parish Directory</TITLE>
</head>

<cfmodule template="#Application.header#"
	pagetitle="Diocesan Parish Directory"
	subtitle="Come join us in worship!"
	postdate="">

<blockquote>
<font face="Verdana" size="-1">
<p><IMG SRC="/images/EpisSignpost.jpg" WIDTH=168 HEIGHT=249 align=left hspace=5 vspace=2 BORDER=0 ALT="">
Looking for a parish community? Trying to find the phone number of a parish in the Chicagoland area? You've come to the right place.</p>

<center>
<table width=300 border=1 cellpadding=0 cellspacing=0>
<tr valign=top>
	<td>
		<table width=100% border=0 cellspacing=6 cellpadding=0>
		<tr valign="top" bgcolor="#F3E9DE">
			<th>Diocesan Parish Locator</th>
		</tr>
		<tr valign=middle>
			<td>
			<font size="-1">
			<cfform name="FindCity" method="POST" action="ParishLocator.cfm">
			For parishes in the City of:<br><cfselect query="Cities" name="City" display="City" value="City" size=1 required="Yes"><option selected value="*">--- Select City ---</option></cfselect>
			<input type="Submit" value="Go!">
			</cfform>

			<cfform name="FindKwd" method="POST" action="ParishLocator.cfm">
			Using the search term:<br><cfinput name="Keyword" type="text" size=25 maxlength=45 required="Yes" Message="You must provide a value to search upon">
			<input type="Submit" value="Go!">
			</cfform>

			</font>
			</td>
		</tr>
		<tr valign=bottom>
			<td align=center><hr size=1><font color="Navy" size="-1"><i>Looking for a parish's website? <a href="/Diocese/Parishes/" target="_blank">Click here</a>!</i></font></td>
		</tr>
		</table>
	</td>
</tr>
</table>
</center><br clear=left>

<p>The Diocese of Chicago is made up of 137 parishes and missions covering all of Chicagoland and the northern third of Illinois. With such a diverse community of faith, ethnically rich and liturgically vibrant, you are sure to find a warm and welcoming home in which to worship and celebrate.</p>
<p>For a list all the parishes in our Diocese, or a listing of our deaneries, click on the appropriate button below:</p>
<center>
<A HREF="DirDeanery.cfm"><IMG SRC="/images/btn-bydeanery.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Deanery Directory"></A>
<A HREF="DirDirectory.cfm"><IMG SRC="/images/btn-bycity.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="City Directory"></A>
<A HREF="Deaneries.cfm"><IMG SRC="/images/btn-deaneries.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Deanery Listing"></A><br><br>
</center>

</font>
</blockquote>

</cfmodule>

</HTML>
