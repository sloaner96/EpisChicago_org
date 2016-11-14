<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Strategic Plan of the Diocese of Chicago</TITLE>
</head>
<cfquery name="GetPageContent" datasource="#Application.dsn#">
  Select *
  From PageText
  Where PSection = '1'
  order By Ranking
</cfquery>
<cfmodule template="#Application.header#" PageTitle="Strategic Plan of the Diocese of Chicago">
<cfoutput query="GetPageContent">
<table border="0" cellpadding="4" cellspacing="0">
  <tr>
    <td><font color="##a3282c" face="tahoma" size="+1">#GetPageContent.Heading#</font></td>
  </tr>
  <tr>
    <td><hr size=1 noshade color="##000066"></td>
  </tr>
</table>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td><font face="Arial" size="-1">#Replacenocase(GetPageContent.InfoText,"#Chr(13)##chr(10)#", "<br>", "All")#</font></td>
  </tr>
</table>
</cfoutput>
<br>
<cfquery name="GetGoals" datasource="#Application.dsn#">
  Select G.*, 
    (Select Count(*)
	  From Initiatives I
	  Where I.GoalID = G.GoalID) as InitExists 
  From Goals G
  Where Active = 1
  Order By GoalNbr
</cfquery>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <cfoutput query="GetGoals">
    <tr>
      <td>&nbsp;</td>
      <td style="font-family:verdana; font-size:12px;">#Goalnbr#.)</td>
	  <td style="font-family:verdana; font-size:12px;">#Label#</td>
	</tr>
	<cfif InitExists GT 0>
	  <tr>
	     <td>&nbsp;</td>
		 <td>&nbsp;</td>
	     <td style="font-family:verdana; font-size:12px;"><a href="initiatives.cfm?GID=#GoalID#">View Initiatives</a></td>
	  </tr>
	</cfif>
  </cfoutput>	  
</table>
</cfmodule>

</HTML>