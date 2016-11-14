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
<cfquery name="GetInit" datasource="#Application.dsn#">
  Select I.*, G.Label as GoalLabel, G.Description As GoalDesc, G.Goalnbr
  From Initiatives I, Goals G
  Where I.GoalID = G.GoalID 
  AND I.GoalID = #url.GID#
  order By I.Ranking
</cfquery>
<cfmodule template="#Application.header#" PageTitle="Strategic Plan of the Diocese of Chicago">
<cfoutput query="GetInit">
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><font color="##a3282c" face="tahoma" size="+1">Goal #GetInit.GoalNbr# Initiatives</font></td>
  </tr>
  <tr>
    <td><hr size=1 noshade color="##000066"></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td><font face="arial" color="##000099" size="+1">Goal #GetInit.GoalNbr#. #GetInit.GoalLabel#</font></td>
  </tr>
</table><br>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td colspan=2><font face="Arial" size="-1"><strong>#GetInit.Label#</strong></font></td>
  </tr>
  <tr>
    <td><font face="Arial" size="-1">#Replacenocase(GetInit.Description,"#Chr(13)##chr(10)#", "<br>", "All")# </font></td>
	<td valign="top"><img src="/images/subsite/#getInit.imgpath#" border="0" align="texttop"></td>
  </tr>
</table>
</cfoutput>
</cfmodule>

</HTML>