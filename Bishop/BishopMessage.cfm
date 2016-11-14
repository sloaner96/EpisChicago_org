<cfset url.groupid = "31">

<cfparam name="url.b" default="0">
<cfparam name="url.Type" default="MESG">
<cfparam name="url.action" default="">

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>

<cfquery name="SermonNfo" datasource="#Application.dsn#">
	SELECT *, year(s.SermonDate) as SermonYear From Sermons s, Bishops b
		WHERE (s.BishopID = #url.b# AND b.BishopID = s.BishopID
		  <cfif url.action EQ "">	
			<cfif IsDefined("URL.SID")>
				AND SermonID = #URL.SID#
			<cfelse>
				AND SermonType = '#url.Type#'
			</cfif>
		  <cfelse>
		    <cfif ISDefined("form.keywords")>
			  AND (SermonTitle like '%#form.keywords#%' 
			  OR SermonText like '%#form.keywords#%' 
			  OR Preacher like '%#form.keywords#%' 
			  OR Organization like '%#form.keywords#%')
			<cfelseif ISDefined("form.Year")>
			  AND Year(SermonDate) = #form.Year#   
			</cfif> 	
		  </cfif>)	
		ORDER BY SermonDate DESC
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


<cfif url.type EQ "Mesg">
<cfset subtitle = "Bishop's Message Archives">
<cfelse>
<cfset subtitle = "Bishop's Sermon/Address Archives">
</cfif>
 
				
<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#" subtitle="#subtitle#"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
			  <td valign="top">
			     <table border="0" cellpadding="3" cellspacing="0" width="100%">
                   <cfoutput>
				   <tr>
				     <td align="right"><font face="arial" size="-1"><a href="/bishop/BishopMessage.cfm?Type=#url.Type#&B=#url.B#">Message Archive</a></font></td>
				     <td align="right"><font face="arial" size="-1"><a href="/bishop/index.cfm">Home Page for Episcopal Ministry</a></font></td>
				   </tr>
				   </cfoutput>
				<cfif sermonNfo.recordcount GT 1>
                 </table><br>
				 <table border="0" cellpadding="0" cellspacing="5">
				    <cfif url.action EQ "search">
					 <cfoutput>
					   <tr>
					      <td colspan=2><font face="arial" size="-1">Your Search Returned <strong style="color:##660000;">#sermonNfo.recordcount#</strong> records</font></td>
					   </tr>
					  </cfoutput>
					</cfif>
                         <tr>
						   <cfform name="Searchkey" action="BishopMessage.cfm?Type=#url.Type#&B=#Url.B#&Action=Search" method="POST">
                           <td><font face="verdana" size="-1"><strong>Search by Keyword </strong></font><cfinput type="text" name="keywords"></td>
						   </cfform>
						   
						   <cfform name="Searchkey" action="BishopMessage.cfm?Type=#url.Type#&B=#Url.B#&Action=Search" method="POST">
                             <td><font face="verdana" size="-1"><strong>Search By year</strong></font> <cfinput type="text" name="year"></td>
						   </cfform>
                           
						 </tr>
						 <tr>
						   <td>&nbsp;</td>
						 </tr>
                     </table>
					 <table width=90% border=0 cellspacing=1 cellpadding=3>
						<cfoutput query="SermonNfo" group="SermonYear">
						   <tr>
						     <td colspan=2><font face="arial" color="##330099" size="3"><strong>#SermonNfo.SermonYear#</strong></font></td>
						   </tr>
							<cfoutput>
							<tr valign=top>
								<td width=100><font face="Arial" size="-1" color="black">#DateFormat(SermonDate, "mm/dd/yyyy")#</td>
								<td width=100%><FONT face="Verdana,Arial" size="-1"><a href="BishopMessage.cfm?SID=#SermonID#&B=#url.B#&type=#url.Type#">#SermonTitle#</a></FONT></td>
							</tr>
							</cfoutput>
							<tr>
							  <td>&nbsp;</td>
							</tr>
						</cfoutput>
					 </table>
				  <cfelseif sermonNfo.recordcount EQ 1>
                 </table><br>
				     <table width="100%" border=0 cellspacing=0 cellpadding=0>
					    <cfoutput query="SermonNfo">
						<tr>
						 <td><font face="tahoma" color="##330099" size="+1"><strong>#SermonNfo.SermonTitle#</strong></font><br><font face="verdana" size="-1">#DateFormat(SermonNfo.SermonDate, 'MMMM D, YYYY')#</font></td>
						</tr>
						<tr>
						  <td>&nbsp;</td>
						</tr>
						<tr>
						  <td><cfif sermonNfo.Imgname NEQ ""><img src="/images/#sermonNfo.Imgname#" border="0" alt="" align="right"></cfif><font face="verdana" size="-1">#replacenocase(SermonNfo.SermonText, "#chr(13)##chr(10)#", "<br>", "ALL")#</font></td>
						</tr>
						<cfif Sermonnfo.SermonType EQ "MESG">
						<tr>
						  <td>&nbsp;</td>
						</tr>
						<tr>
						  <td><font face="arial" size="-1"><strong>#SermonNfo.BishopName#</strong><br>#DateFormat(SermonNfo.SermonDate, 'MMMM D, YYYY')#</font></td>
						</tr>
						
						</cfif>
					    </cfoutput>
					 </table>	
				  <cfelse>
                     </table><br>
				     <table width="100%" border=0 cellspacing=0 cellpadding=0>
					    <tr>
						  <td><font color="#3333CC" size="-1" face="Verdana"><strong>There are currently no <cfif url.type EQ "Mesg">Messages<cfelse>Sermons/Addresses</cfif> for this Bishop.</strong></font></td>
						</tr>
					 </table>	  
				</cfif>	    
			  </td>
			</tr> 
		   </table>
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>