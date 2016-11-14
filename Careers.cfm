<CFQUERY Name="FilledJobs" Datasource="#Application.DSN#">
	SELECT c.*, d.*, l.CodeDesc from ClergyJobs c, Lookups l, Directory d
		WHERE l.CodeGroup = 'CJOBTYPES' AND l.CodeValue = c.JobType
			AND d.OrgID = c.OrgID
			AND Filled = True
		ORDER BY ParishName
</CFQUERY>
<CFQUERY Name="OpenJobs" Datasource="#Application.DSN#">
	SELECT c.*, d.*, l.CodeDesc from ClergyJobs c, Lookups l, Directory d
		WHERE l.CodeGroup = 'CJOBTYPES' AND l.CodeValue = c.JobType
			AND d.OrgID = c.OrgID
			AND Filled = 0
			AND JobType <> '10'
		ORDER BY Receiving, JobType, ParishName
</CFQUERY>
<CFQUERY Name="OtherJobs" Datasource="#Application.DSN#">
	SELECT c.*, d.*, l.CodeDesc from ClergyJobs c, Lookups l, Directory d
		WHERE l.CodeGroup = 'CJOBTYPES' AND l.CodeValue = c.JobType
			AND d.OrgID = c.OrgID
			AND JobType = '10'
		ORDER BY ParishName
</CFQUERY>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Parish and Mission Job Openings</TITLE>
</head>

<cfmodule template="#Application.header#" 
	PageTitle="Parish and Mission Job Openings" 
	SubTitle="Positions Open across the Diocese"
	BottomLink='Click <a href="/MarketPlace.cfm">here</a> for Non clergy positions'>


<font face="Verdana" size="-1">
<p align=center>65 East Huron Street&nbsp;<b>&middot;</b>&nbsp;Chicago, IL  60611<br>
Contact: The Rev. Canon Clarence Langdon<br>Phone: (312) 751-4205&nbsp;<b>&middot;</b>&nbsp;Email: <a href="mailto:clangdon@episcopalchicago.org">clangdon@episcopalchicago.org</a></p>
</font>

<blockquote>

<cfif FilledJobs.RecordCount gt 0>
	<br><br>
	<h3><FONT FACE="Tahoma,Arial" COLOR="Maroon">Positions Filled</FONT><hr align=left width=80% size=1></h3>
	<font face="Verdana,Arial" size="-1">
	<cfoutput query="FilledJobs">
	<p><b><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse>#ParishName#</cfif></b></b>, #Address1#, <cfif Address2 is not "">#Address2#,</cfif> #City#, #State#&nbsp;&nbsp;#ZipCode#: #Description#</p>
	</cfoutput>
	</font>
</cfif>

<cfoutput query="OpenJobs" GROUP="Receiving">
	<cfoutput group="JobType">
	<br><br>
	<h3><FONT FACE="Tahoma,Arial" COLOR="Maroon"><cfif Receiving is False>Not</cfif> Receiving Names - #CodeDesc#</FONT><hr align=left width=80% size=1></h3>
	<font face="Verdana,Arial" size="-1">
	<cfoutput>
	<p><b><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse>#ParishName#</cfif></b></b>, #Address1#, <cfif Address2 is not "">#Address2#,</cfif> #City#, #State#&nbsp;&nbsp;#ZipCode#: #Description#</p>
	</cfoutput>
	</font>
	</cfoutput>
</cfoutput>

<br><br>
<cfif OtherJobs.RecordCount gt 0>
	<h3><FONT FACE="Tahoma,Arial" COLOR="Maroon">Other Positions</FONT><hr align=left width=80% size=1></h3>
	<font face="Verdana,Arial" size="-1">
	<cfoutput query="OtherJobs">
	<p><b><cfif WebSite is not ""><a href="#WebSite#" target="_blank">#ParishName#</a><cfelse>#ParishName#</cfif></b>, #Address1#, <cfif Address2 is not "">#Address2#,</cfif> #City#, #State#&nbsp;&nbsp;#ZipCode#:<br>#Replace(Description, "#chr(13)##chr(10)#","<br>","ALL")#</p>
	</cfoutput>
	</font>
</cfif>


<hr align=center width=80% size=1>
<p>The Diocese of Chicago is now part of the Deployment Ministry Conference.  This is a consortium of 39 dioceses that publish a monthly newsletter. This newsletter is available at the diocesan Office of Ministry Development. In October and March of each year, clergy who wish their names to be presented at the meeting of the diocesan deployment officers of these dioceses will be done. Please contact The Rev. Canon Scott Hayashi at <a href="mailto:shayashi@episcopalchicago.org">shayashi@episcopalchicago.org</a> if interested in either the list or having your name presented.</p>
</blockquote>

</cfmodule>
</HTML>
