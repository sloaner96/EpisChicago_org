
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ, and to invite other into our fellowship, and to serve the world in Christ's name.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese - Site-Wide Search</TITLE>
</head>

<CFMODULE Template="#Application.header#"
	PageTitle="Diocesan Site Search"
	SubTitle=""
	PostDate="">


<blockquote>
<font face="Verdana,Arial" size="-1">


<cfif NOT IsDefined("Form.Term")>

	<p>Use this page to search the Diocesan web site by a specific key word or phrase.  This process will search the entire web site looking for pages which match your criteria.  Matches will be displayed to you for review.</p>

	<cfform name="SiteSearch" action="SiteSearch.cfm">
	<font face="arial" size="+1" color="Navy">Search Term</font>: <cfinput name="term" size=25 type="text" value="" required="Yes" Message="A Search Term must be specified">
	<input type="Submit" value="Search!"> 
	</cfform>

<cfelse>

	<cfsearch collection="DioChicago,DioNews,DioEvents,DioParish,DioConv,DioSermon"
	          name="GetResults"
	          type="SIMPLE"
	          criteria="#Form.Term#"
	          startrow="1">

	<center>
	<p>This search engine has found web pages matching your given criteria.</font></p>

	<cfform name="SiteSearch" action="SiteSearch.cfm">
	<font face="arial" size="+1" color="Navy">Search Term</font>: <cfinput name="term" size=25 type="text" value="#Form.term#" required="Yes" Message="A Search Term must be specified">
	<input type="Submit" value="Search!"> 
	</cfform>
	</center>

	<CFIF GetResults.RecordCount gt 0>

		<TABLE width="90%" border=0 cellspacing=0 cellpadding=6>

		<!--- table header --->
		<TR bgcolor="cccccc" valign=top>
			<TD width=40 align="center"><font face="Arial" size="-1"><B> No</B></font></TD>
			<TD width=40 align="center"><font face="Arial" size="-1"><B>Score</B></font></TD>
			<TD width=*><font face="Arial" size="-1"><B>Title</B></font></TD>
		</TR>

		<CFOUTPUT query="GetResults">
		<TR valign=top bgcolor="#IIf(CurrentRow Mod 2, DE('white'), DE('F3E9DE'))#">

			<!--- current row information --->
			<TD align="center"><font face="Arial" size="-1">#CurrentRow#</font></TD>

			<!--- score --->
			<TD align="center"><font face="Arial" size="-1">#Round(Score * 100)#%</font></TD>

			<!--- title for HTML files --->
			<TD>
				<CFIF Title is "">
					<CFSET TitleStr = "No Title">
				<CFELSE>
					<CFSET Titlestr = Title>
				</CFIF>
				
				<CFIF NOT IsNumeric(Key)>
					<CFSET href = Replace(URL, " ", "%20", "ALL")>
					<font face="Arial" size="-1"><A href="#href#"><b>#TitleStr#</b></A><br><font size="-1">(#href#)</font></font>
				<CFELSE>
					<font face="Arial" size="-1"><a href="#custom2##Key#"><b>#TitleStr#</b></a><br><font size="-1">(#custom2##Key#)</font></font>
				</CFIF>
			</TD>

		</TR>
		</CFOUTPUT>

		</TABLE>
		<br>

	<CFELSE>
		<font face="Arial" size="-1"><h3 align=center>** No records matched your search criteria **</h3></font>
	</CFIF>

</cfif>

</font>
</blockquote>

</CFMODULE>
</HTML>
