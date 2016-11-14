<cfset url.groupid = "32">


<cfif Not IsNumeric(url.groupid)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfif Findnocase(";", url.groupid, 1)>
  <cflocation url="/index.cfm?e=1" addtoken="No">
</cfif>

<cfset groupid = url.groupid>

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>


<cfset Today = now()>
<cfset NextThirty = DateAdd('d', 60, today)>

<cfquery name="GroupEvents" datasource="#Application.DSN#">
	SELECT *
	From Events
	Where ((BeginDate >= #CreateODBCDate(Today)# AND BeginDate <= #CreateodbcDate(NextThirty)#)
	OR  EndDate >= #CreateODBCDate(Today)#)
	AND OwningGroupID = #GroupID#
	Order By GrpHighlight, Begindate desc
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
	<TITLE>Chicago Diocese -- Episcopal Charities and Community Services</TITLE>
    </cfoutput>
</head>

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <table border="0" cellpadding="2" cellspacing="0" width="100%">
			<cfoutput>
			 <tr>
			   <td colspan=2><font face="verdana" size="-1">#replacenocase(GetGroupInfo.Purpose, "#chr(13)#", "<br>", "All")#</font></td>
			 </tr>
			 </cfoutput>
			 <tr>
			   <td colspan=2>&nbsp;</td>
			 </tr>
			 <cfif groupEvents.recordcount GT 0>
				 <tr>
				   <td>
				     <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                   <tr>
				         <td width=72><img src="/images/eventsheader.gif" width="63" height="19" border=0></td>
				         <td width="90%" background="/images/eventsheaderBG.gif"></td>
				       </tr> 
	                 </table>
				   </td>
				 </tr>
				 <tr>
				   <td>&nbsp;</td>
				 </tr>
				 <cfoutput query="GroupEvents" group="BeginDate">
				   <tr>
				     <td><font face="verdana" size="-1"><strong>#DateFormat(BeginDate, 'mmmm d, yyyy')#</strong></font></td>
				   </tr>
				   <cfoutput>
					  <tr>
					    <td><font face="verdana" size="-1">
			                 <b><cfif Description is not ""><a href="ListEvents.cfm?EventID=#EventID#&GroupID=#groupID#">#EventName#</a><cfelse>#EventName#</cfif></b><br>
					         <cfif Location is not "">Location: #Location#<br>  </cfif>
			                 <cfif DatePart("h", BeginDate) gt 0>Time: #TimeFormat(BeginDate, 'hh:mm tt')#.  <br></cfif>
			                 <cfif Contact is not "">Contact: <cfif ContactEmail is not ""><a href="mailto:#ContactEmail#">#Contact#</a><cfelse>#Contact#</cfif> <cfif Phone is not "">at #Phone#</cfif><br></cfif>
			                 <cfif URL is not "">  Web: <a href="http://#rereplacenocase(URL, "https?://", "", "ALL")#">#URL#</a><br></cfif></font>
							 <cfif Description is not ""><font face="verdana" size="-1">#Description#</font><br></cfif>

						</td>
					  </tr>
					  <tr><td>&nbsp;</td></tr>
				  </cfoutput>
				   <tr>
				     <td>&nbsp;</td>
				   </tr>
				 </cfoutput>
			</cfif> 
		   </table>
		</td>
		<td width="225" valign="top" align="right">
		   <cf_esidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#" showmembers ="1">
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>
