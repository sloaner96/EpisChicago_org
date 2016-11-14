<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Resource Directory</TITLE>
</head>
<cfmodule template="#Application.header#" PageTitle="Resource Directory">
<cfquery name="GetCats" datasource="#Application.dsn#">
   Select Codevalue, Codedesc as CatName  
	   From Lookups
	   where CodeGroup = 'RECCAT'
	   AND exists (Select Distinct Category From Resources where category = codevalue AND Active = true)
	   Order By CodeDesc
</cfquery>
<cfset NRows = Round(GetCats.RecordCount / 1)>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td valign="top">
	  <table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
	    <td colspan=2><font face="arial" size="-1"><p>Our church and diocese are gifted with many talented,
	resourceful and inspirational leaders, ministers, and
	ministries. This directory of resources provides a portal
	to the many organizations, programs, media & publications,
	and services of particular interest to Anglicans
	and the wider Christian community. Some of these are
	produced and distributed through offices and committees
	and organizations of the Diocese of Chicago; others
	are through the national offices of the Episcopal Church,
	other dioceses, and other denominations and organizations.
	Many of these can be accessed and downloaded
	from this site, while others can be accessed through
	links to other websites or ordered by mail.</p>
	
	<p>To locate a resource you can click on any of the category
	headings below or use the keyword search feature. Each
	category can be searched by subcategory or topic.</p></font></td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td colspan=2>
		  <cfform name="Search" action="ResourceSearch.cfm" Method="POST">
			  <table border="0" cellpadding="0" cellspacing="0" width="100%">
	            <tr>
				   
	               <td valign="top"><font face="arial" color="#003366" size="-1"><strong>Search</strong></font><br><cfinput type="text" name="search" required="yes" message="You must enter a search term." size="10" maxlength="100">&nbsp;&nbsp;<input type="submit" name="submit" value="GO"></td>
				   
				   <td align="center" valign="bottom"><a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="http://www.adobe.com/images/get_adobe_reader.gif" alt="Download Adobe Reader" border="0"></a></td>
	            </tr>
	         </table>
		 </cfform>
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td colspan=2><font face="arial" color="#990000" size="+1"><strong>Resource Categories</strong></font></td>
	  </tr>
	  <cfset Lines = 0>
	 <cfset Lines = 0>
	  <tr valign=top align="center">
		 <td align=left width="50%">
			<table cellpadding=1 cellspacing=0 border=0>
				<CFOUTPUT Query="GetCats">
				   <cfset Category = Getcats.CodeValue>
				   <cfquery name="GetSubs" datasource="#Application.dsn#">
				      Select Distinct L.Codevalue, L.Codedesc as SubCatName  
					   From Resources R, lookups L
					     where R.Category = '#Getcats.CodeValue#'
					      AND R.subcategory = L.Codevalue
					      AND L.CodeGroup = 'RECSUBCAT'
						  AND R.Active = true
					   Order By CodeDesc 
				    </cfquery> 

					<cfset Lines = Lines + 1>
					<cfif (Lines MOD NRows) eq 0>
							</table>
						</td>
						<td  width="50%" align=left>
							<table cellpadding=1 cellspacing=0 border=0>
					</cfif>
					<tr>
						<td><a href="ResourceDetail.cfm?CatID=#GetCats.Codevalue#" style="font-family:arial; font-size: 3;color:##000099;"><font face="arial" size="3"><strong>#GetCats.Catname#</strong></font></a></td>
					</tr>
	
				<cfset Lines = Lines + 1>
				
				   <tr>
	                  <td>
					    <cfloop query="GetSubs">
						    <font face="verdana" size="-2"><a href="ResourceDetail.cfm?CatID=#Category#&SubCatID=#GetSubs.Codevalue#">#GetSubs.SubCatName#</a><cfif getsubs.currentrow NEQ Getsubs.recordcount>,</cfif></font>
						    <cfif Getsubs.currentrow MOD(3) EQ 0><br></cfif>
						</cfloop>
					  </td>
			       </tr>
				   <tr>
				     <td>&nbsp;</td>
				   </tr>
				<cfif (Lines MOD NRows) eq 0>
						</table>
					</td>
					<td width="50%" align=left>
						<table cellpadding=1 cellspacing=0 border=0>
				</cfif>
				</CFOUTPUT>
		   </table>
		</td>
	  </tr>
	</table>
</td>
<td valign="top" align="right" size="180" bgcolor="#feefd0">
  <table border="0" cellpadding="0" cellspacing="0" width="180">
    <tr>
      <td><img src="/images/resourcehead.jpg" border="0" alt="Resource Directory"></td>
    </tr>
  </table>
  <table border="0" cellpadding="4" cellspacing="0" width="180">
	<tr>
	 <td><font face="arial" color="#003366" size="+1"><strong>Staff</strong></font></td>
	</tr>
	<tr>
	  <td><font face="arial" color="#003366" size="-1"><strong>Director of Communications</strong><br>David Skidmore<br><a href="mailto:dskidmore@episcopalchicago.org">dskidmore@episcopalchicago.org</a><br>(312) 751-4207</font></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td><font face="arial" color="#003366" size="-1"><strong>Director of Christian Formation</strong><br>Vickey Garvey<br><a href="mailto:vgarvey@episcopalchicago.org">vgarvey@episcopalchicago.org</a><br>(312) 751-4204</font></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td><font face="arial" color="#003366" size="-1"><strong>Administrative Assistant for Christian Formation</strong><br>Anne Cothran<br><a href="mailto:acothran@episcopalchicago.org">acothran@episcopalchicago.org</a><br>(312) 751-4206</font></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td><font face="verdana" color="#003366" size="-2">To recommend resources:<br><a href="mailto:resources@episcopalchicago.org">resources@episcopalchicago.org</a></font></td>
	</tr>
</table>
</td>
</tr>
</table>


</cfmodule>
</HTML>
