<cfset url.groupid = "31">

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
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
	<cfoutput>
	<TITLE>Chicago Diocese -- Episcopal Ministry</TITLE>
    </cfoutput>
</head>

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
			  <td valign="top">
			     <table border="0" cellpadding="3" cellspacing="0" width="150">
                   <tr>
                      <td><img src="/images/Bishops/EpisHistory1.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Christ as the Good Shepherd
                          mosaic, entry to the mausoleum of
                          Galla Placidia, Ravenna, Italy.</em></font></td>
				   </tr>
				   <tr>
				      <td>&nbsp;</td>
				   </tr>
				   <tr>
                      <td><img src="/images/Bishops/EpisHistory2.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Archbishop of Canterbury Rowan
							Williams taking the oath of office
							at his enthronement as the 104th
							Archbishop of Canterbury.</em></font></td>
				   </tr>
				   <tr>
				      <td>&nbsp;</td>
				   </tr>
				   <tr>
                      <td><img src="/images/Bishops/EpisHistory3.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>In 1989, Bishop Barbara
							Harris, suffragan bishop of
							Massachusetts, was the
							first woman to be elected
							and ordained bishop in the
							Anglican Communion.</em></font></td>
				   </tr>
				   <tr>
				      <td>&nbsp;</td>
				   </tr>
                 </table>
			  </td>
			  <td>&nbsp;</td>
			  <td valign="top">
			     <table border="0" cellpadding="3" cellspacing="0" width="100%">
                   <tr>
				     <td><font face="arial" size="-1"><a href="/bishop/index.cfm">Home Page for Episcopal Ministry</a></font></td>
				   </tr>
				   <tr>
				     <td><font face="arial" color="#996699" size="+1"><strong>Episcopal History</strong></font></td>
				   </tr>
				   <tr>
                      <td><font face="verdana" size="-1">
					    <p>
					    Christ’s words to Simon Peter in Matthew 16 —“. . .on this rock
						I will build my church. . .” — have for centuries served as the
						scriptural charge not only for the papal authority of the Roman
						Catholic Church but also for the institution of the catholic
						church and the office of bishop. In the first century of the
						Christian era, house churches formed around charismatic teachers
						who claimed connection to the original 12 apostles. These
						missionary leaders took the title of <em>episcopus</em> (Latin for “overseer”),
						which in Anglo Saxon usage became <em>bishop.</em></p>
						
						<p>As the faith spread, bishops became overseers of communities
						of Christians in major cities such as Rome, Antioch and Ephesus.
						Conflicting interpretations of the Gospel led bishops to claim
						apostolic succession, meaning they had a direct link to the
						original 12 apostles, and therefore taught with the authority of
						the apostles. Ignatius, bishop of Antioch, was among the first
						to address the role of bishops when he wrote in 107 “Wheresoever
						the bishop appears, let the people be. . ."</p>
						
						<p>By the end of the second century, the three orders of ordained
						ministry were in place: bishops, priests and deacons.</p>
						
						<p>The notion of the bishop of Rome having oversight of the universal
						church gained ground in the second century through the
						writings of Ignatius and Irenaeus. The Apostle Peter is considered
						the first pope by the Roman Catholic Church. When the
						Church of England split from the Roman Catholic Church in the
						16th century, it retained the office of bishop, but assigned
						supreme ecclesiastical authority to the sovereign who appointed
						both the two archbishops, of Canterbury and York, and diocesan
						bishops. Today, the Archbishop of Canterbury serves as primate
						of the Church of England and spiritual leader of the Anglican
						Communion. Every ten years the Archbishop of Canterbury calls
						the bishops of the Anglican Communion to the Lambeth Conference
						(named for the first meeting in 1867 held at Lambeth
						Palace in London), and between conferences chairs meeting of
						the primates, or presiding bishops, of the Communion’s 38
						autonomous provinces.</p>
						
						<p>The Episcopal Church’s first bishop, Samuel Seabury, was consecrated
						in 1784 in Scotland. Bishop William White of Pennsylvania,
						the church’s senior bishop at the time, was named the first
						presiding bishop of the Episcopal Church in 1789. Bishop Frank
						Griswold, former Bishop of Chicago, was elected the 25<sup>th</sup> presiding
						bishop in 1997. The presiding bishop is elected to a nineyear
						term by the House of Bishops, and confirmed by the House
						of Deputies of General Convention. The presiding bishop serves
						as the chief pastor and primate of the church, and as president
						of the House of Bishops and Domestic and Foreign Missionary
						Society (the corporate arm of the Episcopal Church). In 1919
						the seniority system for filling the presiding bishop post was
						changed to an elective process. Until 1946 the presiding bishop
						also functioned as a diocesan bishop.</p>
						</font>
					  </td>
                   </tr>
                 </table>    
			  </td>
			</tr> 
		   </table>
		</td>
		<!---  
		<td width="225" valign="top" align="right">
		   <cf_bsidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#">
		</td>
		--->
	  </tr>
	</table> 

</cfmodule>

</HTML>