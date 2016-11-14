<cfquery name="GetCal" datasource="#Application.DSN#">
	SELECT e.*, Month(e.BeginDate) as EMonth, Day(e.BeginDate) as EDay, Year(e.BeginDate) as EYear, (select CodeDesc From Lookups l Where l.CodeValue = e.Category AND l.CodeGroup = 'EVENT') as CategoryName
		From Events e
		WHERE e.Approved = True
			AND e.EndDate >= #CreateODBCDateTime(now())#
			AND e.EventGroup = 'C'
		ORDER BY e.BeginDate
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
	<TITLE>Chicago Diocese -- Events at the Cathedral</TITLE>
</head>

<CFMODULE Template="#Application.header#" Section="Cathedral" PageTitle="Activities at the Cathedral">

<blockquote>

<cfoutput query="GetCal" group="EYear">
	<cfoutput group="EMonth">
	<cfoutput group="EDay">

	<center>
	<table width=550 border=0 cellspacing=2 cellpadding=2>
	<cfoutput>
	<tr valign=top>
		<td colspan=2 bgcolor="##f3f3f3">
		<font face="Tahoma,Verdana,Arial" size="+1" color="Navy">#DateFormat(BeginDate, "dddd, mmmm d, yyyy")#</font>
		</td>
	</tr>
	<tr valign=top>
		<td width=80>
		<img src="/images/blank.gif" width=80 height=1 alt="" border="0"><br>
		<font face="Arial" size="-1">#TimeFormat(BeginDate, "h:mm TT")#</font>
		</td>
		<td width=470>
		<font face="Tahoma,Arial" color="Blue" size="+1">#EventName#<br></font>
		<font face="Arial" size="-1">
		<cfif Location is not ""><b>Location</b>: #Location#<br></cfif>
		<cfif Contact is not ""><b>Contact</b>: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif><br></cfif>
		<cfif URL is not "">Visit <a href="#URL#">#URL#</a> for more information<br></cfif>
		</font>
		<cfif Description is not ""><font face="Verdana,Arial" size="-1"><br>#Replace(Description, '#chr(13)##chr(10)#', '<br>', 'ALL')#</font></cfif>
		</td>
	</tr>
	</cfoutput>
	</table>
	</center>
	<br>

	</cfoutput>
	</cfoutput>
</cfoutput>

<br>
</blockquote>

</cfmodule>
</HTML>
