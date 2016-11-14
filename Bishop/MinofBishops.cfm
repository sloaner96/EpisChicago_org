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
                      <td><img src="/images/Bishops/MinofBish1.jpg" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td><font face="verdana" size="-2"><em>Bishop Persell blesses the new
						altar at Christ the King, Lansing.</em></font></td>
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
				     <td><font face="arial" color="#996699" size="+1"><strong>The Cathechesis - Ministry of the Bishop</strong></font></td>
				   </tr>
				   <tr>
                      <td><font face="verdana" size="-1"><p>
					        <strong>What is the ministry of a bishop?</strong><br>
							<blockquote>
								The ministry of a bishop is to represent Christ and his
								Church, particularly as apostle, chief priest, and pastor
								of a diocese; to guard the faith, unity, and discipline of
								the whole church; to proclaim the Word of God; to act in
								Christ’s name for the reconciliation of the world and the
								building up of the Church; and to ordain others to continue
								Christ’s ministry.
							</blockquote><br>
							<em>From “An Outline of the Faith”, The Book of Common Prayer</em>
					      </p>
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