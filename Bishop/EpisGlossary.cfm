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
                      <td><img src="/images/Bishops/EpisSymbols.jpg" alt="" border="0"></td>
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
				     <td><font face="arial" color="#996699" size="+1"><strong>Episcopal Symbols Glossary</strong></font></td>
				   </tr>
				   <tr>
                      <td valign="top">
					    <table border="0" cellpadding="2" cellspacing="3" width="100%">
                           <tr>
                             <td valign="top">
							    <table border="0" cellpadding="0" cellspacing="0" width="100%">
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">CHASUBLE</strong><br>
										Oval shaped garment worn over
										an alb by priests or bishops
										when presiding at the Eucharist.
										Constructed of a variety of
										materials in liturgical colors, and
										often decorated with contrasting
										stripes and liturgical symbols.
										Based on the pluviale (Roman) or
										planeta (Greek), a cloak worn
										outdoors by men and women in
										ancient Greece and Rome. Like
										the cope and miter, it was seldom
										worn in the Church of England
										following the Reformation, until
										the Oxford Movement of the early
										19th century.</font></td>
								  </tr>
								  <tr><td>&nbsp;</td></tr>
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">CHIMERE</strong><br>
										Red or black sleeveless gown
										worn over a rochet and a cassock.
										Worn at liturgical functions
										(except Eucharist) and civic and
										ecumenical ceremonies. Derived
										from the tabard, a blazoned cloak
										worn by medieval knights over
										their armor.</font></td>
								  </tr>
								  <tr><td>&nbsp;</td></tr>
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">COPE</strong><br>
										Semicircular cloak with hood
										shaped extension usually worn
										during the first half of the Eucharist
										and at confirmations and
										ordinations. Used in place of a
										chasuable. Derived from the
										Roman pluviale and first used by
										clergy in the 6th century. Widely
										used as a ceremonial choir habit
										in the Middle Ages.</font></td>
								  </tr>
								  <tr><td>&nbsp;</td></tr>
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">CROSIER</strong><br>
									    Staff that symbolizes the pastoral
										ministry of a bishop. Carried in
										procession and when pronouncing
										episcopal blessings. Crookshaped
										to resemble a shepherd’s
										staff. First mentioned in Spanish
										documents in the 7th century. Two possible origins: a walking stick
										or the divination rod used by
										Roman fortune tellers.</font></td>
								  </tr>
								</table>
							 </td>
							 <td valign="top">
							   <table border="0" cellpadding="0" cellspacing="0" width="100%">
								 <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">MITER</strong><br>
										Liturgical head gear styled as a
										crown in the Eastern church and
										as a shield in the Western
										church. Originally made of white
										linen, but later of embroidered
										silk which frequently was decorated
										with jewels and semiprecious
										stones. The Western miter
										has two peaks, front and back,
										and two fringed lappets that
										hang from the back. Worn during
										processions and when pronouncing
										episcopal blessings. Originated
										in the 11th century and is
										based on the camelaucum, an
										unofficial hat worn by the Pope
										in procession.</font></td>
								  </tr>
								  <tr><td>&nbsp;</td></tr>
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">PECTORAL CROSS</strong><br>
										Cross of gold, silver or other
										precious metal suspended on a
										chain and worn on the chest—
										usually near the pectoral
										muscles. Worn exclusively by
										bishops in the Anglican Communion
										but in the Roman Catholic
										Church worn by cardinals and
										abbots as well as bishops.</font></td>
								  </tr>
								  <tr><td>&nbsp;</td></tr>
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">RING</strong><br>
										Symbolizes the bishop’s betrothal
										to the church. Worn on
										the third finger of the right hand
										and engraved with a signet, or
										bishop’s seal. Usually made of
										gold and set with an amethyst
										stone. First appeared in the 7th
										century and came into general
										use by the 10th century.</font></td>
								  </tr>
								  <tr><td>&nbsp;</td></tr>
								  <tr>
									<td><font face="arial" size="-1"><strong style="color:#996699;">ROCHET</strong><br>
										White linen vestment similar to
										an alb but with balloon sleeves
										gathered at the wrist with red or
										black bands. Worn over the
										cassock and under a chimere.</font></td>
								  </tr>
							   </table>
							 </td>
                           </tr>
                        </table>
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