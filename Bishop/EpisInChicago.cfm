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
                      <td><img src="/images/Bishops/EpisInChicago1.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Bishop Scantlebury confirms
						a member of SS. George and
						Matthias, Chicago</em></font></td>
				   </tr>
				   <tr>
				      <td>&nbsp;</td>
				   </tr>
				   <tr>
                      <td><img src="/images/Bishops/EpisInChicago2.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Bishop Persell welcomes
						Bishop Scantlebury as
						assistant bishop of
						Chicago at Bishop
						Scantlebury’s installaton
						March 23, 2000.</em></font></td>
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
				     <td><font face="arial" color="#996699" size="+1"><strong>Episcopal Ministry in Chicago</strong></font></td>
				   </tr>
				   <tr>
                      <td><font face="verdana" size="-1"><p>Chicago’s present diocesan, the Rt. Rev. William D. Persell, was
								elected the eleventh bishop of the diocese Nov. 14, 1998 and
								consecrated March 13, 1999. He succeeds Bishop Frank T.
								Griswold who was elected presiding bishop in August 1997.
								Bishop Persell is assisted by the Rt. Rev. Victor A. Scantlebury,
								who was appointed assistant bishop March 1, 2000. Traditionally
								the diocesan has been assisted by suffragan bishops, persons
								elected to the episcopate by the Diocesan Convention and who
								serve without right of succession to the diocesan seat. The last
								suffragan was Bishop Willliam Wiedrich who was elected in 1990
								and served until his retirement in 1996. Five other suffragans
								have served the diocese, including the late Bishop Quintin Primo
								Jr., the first African American bishop of the diocese who served
								under Bishop James Montgomery (1972-1984).</p>
								
								<p>In addition to serving as chief pastor and ecclesiastical authority
								of the diocese, Bishop Persell is presiding officer of the diocese’s
								administrative bodies, including the Diocesan Council (budget
								and program); Bishop and Trustees (property management, gifts
								and endowments) and Diocesan Convention (legislation); and
								serves as ex officio member on the Diocesan Foundation (investments)
								and the boards of the diocese’s 13 Episcopal Charities
								and Community Services agencies.</p>
								
								<p>The bishop’s duties include interviewing and approving postulants
								and candidates for ordination; presiding at confirmations
								and ordinations; providing guidance to clergy; exercising a
								teaching ministry with clergy and congregations; supervising
								mission congregations; representing the diocese at provincial
								and national gatherings and events of the church; representing
								the diocese at civic, ecumenical and interfaith events; and
								supervising a 21-member staff. The diocesan staff is organized in
								six departments: Office of the Bishop, Church Center Operations,
								Christian Formation, Communications and Development, Deployment
								and Congregational Development, and Finance and Administration.</p>
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