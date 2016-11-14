
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Main Menu">


<table width=100% border=0 cellpadding=0 cellspacing=0>
<tr>
	<td width=50% align=left><font size="-1"><cfoutput>User: <b>#Session.FullName#</b> logged in</cfoutput></font></td>
	<td width=50% align=right><font size="-1"><a href="Authenticate/ChgPassword.cfm">Modify your Password</a> | <a href="Authenticate/Logout.cfm">Logout</a></font></td>
</tr>
</table>
<br>
<cfif Session.ULevel eq 1>
	<table border="1" cellspacing="0" cellpadding="3" align="right" bordercolor=silver>
	<tr bgcolor="Blue">
		<th><font face="Tahoma,Verdana,Arial" color="white">Security Options</font></th>
	</tr>
	<tr valign=top>
		<td>
			<font face="Verdana,Arial" size="-1" color=#356837>
			<a href="Authenticate/AddUser.cfm">Add</a> a User<br>
			<a href="Authenticate/ListUsers.cfm">Display</a> all Users<br>
			<a href="Authenticate/DeleteUser.cfm">Delete</a> a User<br>
			<a href="Authenticate/LogViewer.cfm">View</a> Activity Logs
			</font>
		</td>
	</tr>
	<tr bgcolor="Blue">
		<th><font face="Tahoma,Verdana,Arial" color="white">Admin Tools</font></th>
	</tr>
	<tr valign=top>
		<td>
			<font face="Verdana,Arial" size="-1" color=#356837>
			<a href="http://mail.epischicago.org:8383">Configure</a> Mail Services<br>
			<a href="Stats/">View</a> Web Statistics<br>
			<a href="/Batch/DBindex.cfm">Index</a> Web Site
			</font>
		</td>
	</tr>
	</table>
</cfif>

<center>
<table width=440 border=0 cellspacing=6 cellpadding=2>
<tr bgcolor="#F3F3F3">
	<th width=50%><font face="Tahoma,Arial" color="Navy">News Briefs</font></th>
	<th width=50%><font face="Tahoma,Arial" color="Navy">Calendar of Events</font></th>
</tr>
<tr valign=top>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="Headlines/NewArticle.cfm">Enter</a> a new News Article<br>
		<a href="Headlines/ArticleSearch.cfm">Modify/Delete</a> an Article
		</font>
	</td>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="Events/NewEvent.cfm">Enter</a> a new Event<br>
		<a href="Events/EventSearch.cfm">Modify/Delete</a> an Event<br>
		<a href="Events/ApproveEvents.cfm">Approve</a> Group Events<br>
		<a href="Albums/">Create/Modify</a> Photo Albums
		</font>
	</td>
</tr>

<tr bgcolor="#F3F3F3">
	<th><font face="Tahoma,Arial" color="Navy">Parish Directory</font></th>
	<th><font face="Tahoma,Arial" color="Navy">Staff/Parish Info</font></th>
</tr>
<tr valign=top>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="Directory/">Modify/Delete</a> a Parish<br>
		Maintain Clergy Database<br>
		Configure Parish Web Pages
		</font>
	</td>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="Jobs/JobSearch.cfm">Maintain</a> MarketPlace Openings<br>
		<a href="ClergyJobs/">Maintain</a> Clergy Openings<br>
		</font>
	</td>
</tr>

<tr valign=top>
	<th bgcolor="#F3F3F3"><font face="Tahoma,Arial" color="Navy">Site Maintenance</font></th>
	<th bgcolor="#F3F3F3"><font face="Tahoma,Arial" color="Navy">Episcopal Ministry</font></th>
</tr>
<tr>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="eNotice.cfm">Send eEmail Notice</a><br>
		<a href="FAQ/">Define FAQs</a><br>
		<a href="Lookup/">Site Categories</a><br>
		<a href="Homepage/GroupResources.cfm">Maintain Resource Groupings</a><br>
		<a href="Programs/">Diocesan Programs</a><br>
		<a href="Resources/">Diocesan Resources</a><br>
		<a href="StratPlan/index.cfm">Strategic Plan</a><br>
		<a href="Links/">Site Links</a>
		</font>
	</td>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="Subsites/EditSite.cfm?GroupID=31">Maintain</a> Homepage<br>
		<a href="Visitation/VisitSearch.cfm">Maintain</a> Visitation Schedule<br>
		<a href="EpisMin/Profiles.cfm">Maintain</a> Bishops Profile<br>
		<a href="EpisMin/Sermons.cfm?Type=S">Maintain</a> Bishops Message<br>
		<a href="EpisMin/Sermons.cfm?Type=M">Maintain</a> Bishops Addresses/Sermons<br>
		</font>
	</td>
</tr>
<tr valign=top>
	<th bgcolor="#F3F3F3"><font face="Tahoma,Arial" color="Navy">Group Subsites</font></th>
	
	<th bgcolor="#F3F3F3"><font face="Tahoma,Arial" color="Navy"><cfif Session.UserID EQ 190>Faith Explorer</cfif></font></th>
	
</tr>
<tr>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="subsites/">Group Sub Sites</a><br>
		</font>
	</td>
	<td>
		<font face="Verdana,Arial" size="-1">
		<a href="Directory/">Maintain Parish Info</a><br>
		<a href="FaithExplorer/SiteText.cfm">Maintain Site Text</a><br>
		<a href="FaithExplorer/SiteLinks.cfm">Maintain Site Links</a><br>
		
		</font>
	</td>
</tr>
</table>
</center>

</CFMODULE>

</HTML>
