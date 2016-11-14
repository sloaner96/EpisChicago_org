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
                      <td><img src="/images/Bishops/EpisSymbol1.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>St. James Cathedral</em></font></td>
				   </tr>
				   <tr>
				      <td>&nbsp;</td>
				   </tr>
				   <tr>
                      <td><img src="/images/Bishops/EpisSymbol2.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Mitre and chasuble</em></font></td>
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
				     <td><font face="arial" color="#996699" size="+1"><strong>Episcopal Symbols</strong></font></td>
				   </tr>
				   <tr>
                      <td><font face="verdana" size="-1"><p>
					       The bishop’s seat of jurisdiction is symbolized in the bishop’s
							throne (cathedra) in the cathedral of the diocese. The community
							in which the cathedral is located is known as the see city
							(Latin for “seat”). Not all Episcopal dioceses have cathedrals.
							St. James Cathedral is the cathedral of the Diocese of Chicago,
							which takes its name from the diocese’s see city. St. James,
							which was designated the cathedral in 1955, is the diocese’s
							second cathedral. The first, the Cathedral of Saints Peter and
							Paul, became the first cathedral in the Episcopal Church in 1861.
							It was destroyed by fire in 1921.</p>
							
							<p>Bishops are differentiated from other clergy by titles: The Rt.
							Rev. for bishops, or The Most Rev. for archbishops and primates—
							and dress: purple is the traditional color for bishops’
							cassocks and clerical shirts. Bishop’s are distinguished in liturgical
							roles by various dress and insignia, including the miter,
							crosier, cope, pectoral cross, ring, and rochet and chimere.</p>
							<br>
							<p>For a description of vestments and insignia see <a href="EpisGlossary.cfm">glossary</a></p>
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