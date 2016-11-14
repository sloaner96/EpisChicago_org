<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Ministries across the Diocese</TITLE>
</head>
<cfquery name="Ministries" datasource="#Application.DSN#">
	Select * 
	From GroupNfo
	Where IsActive = True
	AND GroupType = 'M'
	Order By GroupName
</cfquery>
<cfmodule template="#Application.header#" Section="Ministry" PageTitle="Ministries across Chicagoland">

<blockquote>
<font face="Verdana" size="-1">

<P>The Diocese of Chicago is very active in the Chicagoland area, providing shelter, nourishment, support, and caring.</P>

<!---
<font face="Tahoma,Arial" size="+1">
<h3><font color="Navy">Upcoming Events</font></h3>
<ul type=disc>
<li>Ministry Workshop: Gateways to Evangelism (<a href="/Diocese/Offices/CongDev/InvMinistry.cfm"><font size="-1">learn more</font></a>)
<li>Diocesan Summer Camp 2000 (<a href="YMinistry/SummerCamp.cfm"><font size="-1">learn more</font></a>)
</ul>
</font>
<br>
--->

<center>

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">


 <cfif Ministries.recordcount GT 0>
  <cfoutput query="Ministries">
   <tr>
     <td align="center"><a href="/diocese/offices/index.cfm?GroupID=#Ministries.GroupID#"><font face="verdana" size="+1">#Ministries.GroupName#</font></a></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
  </cfoutput>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <cfelse>
  <tr>
    <td align="center"><font face="arial" color="#cc0000" size="+1"><strong>THERE ARE NO MINISTRY SUBSITES CURRENTLY DEFINED</strong></font></td>
  </tr>
  </cfif>

</table>
</strong></font>
<!--- <A HREF="YMinistry/"><IMG SRC="/images/btn-youth.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Youth Ministries"></A>&nbsp;&nbsp;&nbsp;
<A HREF="CYAM/"><IMG SRC="/images/btn-cyam.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Campus Ministries"></A>&nbsp;&nbsp;&nbsp;
<A HREF="EpisCharities.cfm"><IMG SRC="/images/btn-epc.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Episcopal Charities"></A><br><br>
<A HREF="/Diocese/Offices/CongDev/"><IMG SRC="/images/btn-congdev.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Congregational Development"></A>&nbsp;&nbsp;&nbsp;
<A HREF="/Diocese/Offices/PastoralCare/"><IMG SRC="/images/btn-pastoralcare.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Office of Pastoral Care"></A><br><br>
<A HREF="Asian/"><IMG SRC="/images/btn-asian.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Asian Ministries"></A>&nbsp;&nbsp;&nbsp;
<A HREF="Hispanic/"><IMG SRC="/images/btn-hispanic.gif" WIDTH=130 HEIGHT=25 BORDER=0 ALT="Hispanic Ministries"></A><br> --->
</center>


</font>
</blockquote>

</cfmodule>
</HTML>
