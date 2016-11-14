<cfquery name="SermonNfo" datasource="#Application.DSN#">
	SELECT * From Sermons s, Bishops b
		WHERE s.SermonID = 23 AND b.BishopID = s.BishopID
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
	<TITLE>Chicago Diocese -- Responding to the Tragedy of September 11, 2001</TITLE>
</head>

<CFMODULE Template="#Application.header#"
	PageTitle="Diocesan News"
	SubTitle="Responding to the Tragedy of September 11, 2001"
	PostDate="September 11, 2002">


<blockquote>
<font face="Verdana,Arial" size="-1">

<p>The Diocese of Chicago encourages our churches to use the following
resources in dealing with the tragic events of Sept. 11. For more
information visit our news pages and those of the <a href="http://www.episcopalchurch.org/ENS">Episcopal News Service</a>.</p>

<table align=right width=220 border=1 cellspacing=0 cellpadding=2 bordercolor=Navy>
<tr valign=top bgcolor="#e6e6e6">
	<th>Anniversary Resources</th>
</tr>
<tr valign=top bgcolor="#f3f3f3">
	<td>
	<font size="-2">
	<li type="square"><a href="/Bishop/Persell/index.cfm?SID=22">Letter from Bishop Persell</a><br>
	<li type="square"><a href="PeacePrayers.cfm">EPF Prayers for Peace</a><br>
	<li type="square"><a href="/Forms/News/911-epfAnniversaryLiturgy.pdf">EPF Anniversary Liturgy</a><br>
	<li type="square"><a href="/Forms/News/911-HymnSuggestions.pdf">Hymn Suggestions</a><br>
	<li type="square"><a href="/Forms/News/911-LectionaryPrayers.pdf">Lectionary Prayers</a><br>
	</font>
	</td>
</tr>
<tr valign=top bgcolor="#e6e6e6">
	<th>Diocesan Headlines</th>
</tr>
<tr valign=top bgcolor="#f3f3f3">
	<td>
	<font size="-2">
	<li type="square"><a href="ViewArticle.cfm?ArticleID=270">A Day for Peace and Reconciliation</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=268">September 11th observance</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=212">Interfaith prayer & healing service</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=211">Episcopal Peace Fellowship responds</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=207">ERD provides support</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=206">Chicago joins in prayer</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=202">Community prayer service</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=201">Diocese remembers victims</a><br>
	<li type="square"><a href="ViewArticle.cfm?ArticleID=200">Bishop responds to attacks</a><br>
	</font>
	</td>
</tr>
<tr valign=top bgcolor="#e6e6e6">
	<th>Resources</th>
</tr>
<tr valign=top bgcolor="#f3f3f3">
	<td>
	<font size="-2">
	<li type="square"><a href="/Bishop/Persell/index.cfm?SID=1">Bishop's letter on Sept 11, 2001</a><br>
	<li type="square"><a href="Prayers-20010911.cfm">Prayers of the People in Time of Terrorism and War</a><br>
	<li type="square"><a href="PrayersSpanish-20010911.cfm">La Oración del Pueblo en tiempo de Terrorismo y Guerra</a><br>
	<li type="square"><a href="/Bishop/Persell/index.cfm?SID=3">Bishop Letter on US Military Action</a><br>
	<li type="square"><a href="/Bishop/Persell/index.cfm?SID=2">Homily for Interfaith Service</a><br>
	<li type="square"><a href="Griswold-20010911.cfm">Presiding Bishop Statement</a><br>
	<li type="square"><a href="LiturgicalResources-20010911.cfm">Liturgical Resources</a><br>
	<li type="square"><a href="ChildrenResources.cfm">Children's Resources</a><br>
	<li type="square"><a href="ForwardDBD-20010911.cfm">Special Forward Day by Day</a><br>
	<li type="square"><a href="Contacts-20010911.cfm">Contact Information</a><br>
	</font>
	</td>
</tr>
<tr valign=top bgcolor="#e6e6e6">
	<th>Agency Links</th>
</tr>
<tr valign=top bgcolor="#f3f3f3">
	<td>
	<font size="-2">
	<li type="square"><a href="http://www.epfonline.org/">Episcopal Peace Fellowship</a><br>
	<li type="square"><a href="http://www.er-d.org/">Episcopal Relief & Development</a><br>
	<li type="square"><a href="http://www.tolerance.org">Teaching Tolerance</a><br>
	<li type="square"><a href="http://www.redcrossdc.org/">American Red Cross</a><br>
	<li type="square"><a href="http://www.helping.org/wtc/11th.adp">September 11th Fund</a><br>
	<li type="square"><a href="http://www.lifesource.org/">LifeSource</a><br>
	<li type="square"><a href="http://www.try-nova.org/">National Organization for Victim Assistance</a><br>
	<li type="square"><a href="http://www.cnn.com/SPECIALS/2001/trade.center/contacts.html">Emergency Contact Information</a>
	</font>
	</td>
</tr>
</table>

<cfoutput query="SermonNfo">
<P><FONT color=Navy SIZE="+2">#SermonTitle#</FONT><br>
#DateFormat(SermonDate, 'mmmm d, yyyy')#</P><br></p>

<img src="/images/photos/PeaceAngel-sm.jpg" width=130 height=223 alt="" border="0" align=left hspace=3>
<p>#Replace(SermonText, "#chr(13)##chr(10)#","<br>","ALL")#</p>

<p><b>#BishopName#</b><br>
<i>Bishop of Chicago</i></p>
</cfoutput>

</font>
</blockquote>

</cfmodule>
</HTML>
