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
                      <td><img src="/images/Bishops/EpisMinistry1.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Bishop Persell exercising
							episcopal ministry at the 1999
							Evanston Deanery confirmation</em></font></td>
				   </tr>
				   <tr>
				      <td>&nbsp;</td>
				   </tr>
				   <tr>
                      <td><img src="/images/Bishops/EpisMinistry2.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>The bishop’s chair at
							St. James Cathedral.</em></font></td>
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
				     <td><font face="arial" color="#996699" size="+1"><strong>Episcopal Ministry</strong></font></td>
				   </tr>
				   <tr>
                      <td><font face="verdana" size="-1"><p>Bishops exercise general oversight of a diocese through their
								ministry as chief priest and pastor, prophet, and teacher. In the
								Episcopal Church (which takes its name from the Latin word for
								bishop episcopus) bishops symbolize the unity of the church.
								Two sacramental functions are reserved for bishops: confirmation
								and ordination. Bishops can serve in four capacities: as
								diocesan, coadjutor, suffragan or assistant.</p>
								
								<p>Diocesan bishops function as the ecclesiastical authority in a
								diocese, and usually as the chief executive officer of the diocesan
								corporation. Their canonical duties include serving as chief
								pastor to all clergy, visiting all congregations in their jurisdiction
								at least once every three years, presiding at meetings of the
								diocesan convention, supervising diocesan staff and programs,
								and issuing guidance to the diocese on the church’s doctrine,
								discipline and worship.</p>
								
								<p>Coadjutors are elected to succeed the diocesan, and usually
								serve as assistant until the diocesan leaves office. Suffragan
								bishops are elected by the diocese as assistants to the diocesan,
								and do not have the right to succeed the diocesan.
								Candidates for suffragan do not have to be ordained. Assistant
								bishops are active bishops appointed by the diocesan with the
								consent of the diocesan Standing Committee.</p>
								
								<p>Candidates for Episcopal office must be 30 years of age to be
								ordained and consecrated bishop. Lay persons as well as deacons
								and priests are eligible for election and ordination to the
								office of bishop. All candidates for episcopal office must have
								the consent of a majority of the church’s diocesan standing
								committees before they can be ordained and consecrated.
								Bishops are ordained for life. A minimum of three bishops is
								required for the ordination of a bishop. Bishops must have the
								consent of the House of Bishops before resigning their jurisdictions.
								At age 72 all bishops must resign their jurisdiction (age 70
								for the presiding bishop).</p>
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