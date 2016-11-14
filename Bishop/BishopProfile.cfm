<cfset url.groupid = "31">

<cfquery name="GetGroupInfo" datasource="#Application.DSN#">
	SELECT * From GroupNfo
		WHERE GroupID = #groupid#
</cfquery>

<cfquery Name="GetBishop" datasource="#Application.dsn#">
  Select *
  From Bishops
  Where BishopID = #url.B#
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
		  <cfoutput>
		   <table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
			  <td valign="top">
			     <table border="0" cellpadding="3" cellspacing="0" width="100%">
                   <tr>
				     <td valign="top">
					   <table border="0" cellpadding="0" cellspacing="0" width="100%">
						 <tr>
						   <td><font face="arial" color="##330099" size="+1">#GetBishop.BishopName#</font></td>
						 </tr>
						 <tr>
						   <td>&nbsp;</td>
						 </tr>
						 <cfif GetBishop.AdminID NEQ "">
						 <cfquery name="GetAdminAsst" datasource="#Application.DSN#">
						   Select *
						   From Members
						   Where MemberID = #GetBishop.AdminID#
						 </cfquery>
						 <tr>
						   <td><font face="verdana" size="-1"><strong>Administrative Assistant:</strong><br>
						         #GetAdminAsst.Firstname# #GetAdminAsst.Lastname#<br>
								 (312) #ReplaceList(GetAdminAsst.Phone, "(312),312-,312.","")#<br>
							   </font>
						   </td>
						 </tr>
						  <tr>
						   <td>&nbsp;</td>
						 </tr>
						 </cfif>
						 <tr>
						   <td><font face="verdana" size="-1"><strong>Contact:</strong><br>
						       Episcopal&nbsp;Church&nbsp;Center<br>
						       65 E. Huron St.<br>
						       Chicago, IL 60611<br></font>
						   </td>
						 </tr>
						 <tr>
						   <td>&nbsp;</td>
						 </tr>
						 <tr>
						   <td><font face="verdana" size="-1">
						       <strong>Installed on:</strong> #DateFormat(GetBishop.InstalledON, 'MM/DD/YYYY')#<br>
							   <cfif GetBishop.ConsecrationSite NEQ "">
							     <strong>Consecration:</strong> <a href="#GetBishop.ConsecrationSite#">Click Here to View</a>
							   </cfif>
							   </font>
						   </td>
						 </tr>
						 
						</table>
					 </td>
					 <td valign="top" align="right">
					   <table border="0" cellpadding="0" cellspacing="0" width="100%">
						 <tr>
						   <td><img src="#GetBishop.BishopImage#" border="0" alt="#GetBishop.BishopName#" width="200" height="238" align="right"></td>
						 </tr>
						 <tr>
						   <td></td>
						 </tr>
						</table>
					 </td>
				   </tr>
                 </table>    
			  </td>
			</tr> 
			<tr><td>&nbsp;</td></tr>
			<tr>
			  <td>
				 <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                <tr>
				       <td><img src="/images/bishopsProfile.gif" alt="" border="0"></td>
				       <td width="90%" background="/images/eventsheaderBG.gif"></td>
				    </tr> 
	             </table>
			  </td>
			</tr>
			<tr>
			  <td><font face="verdana" size="-1">#replaceNoCase(GetBishop.Profile, "#Chr(13)##Chr(10)#", "<br>", "All")#</font></td>
			</tr>
		   </table>
		  </cfoutput>
		</td>
		<td width="225" valign="top" align="right">
		   <cf_bsidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#" b="#url.B#">
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>