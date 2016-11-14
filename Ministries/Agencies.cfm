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

<cfmodule template="#Application.header#" PageTitle="#GetGroupInfo.GroupName#" subtitle="Agency Listings"> 

	<table border="0" cellpadding="3" cellspacing="0" width="100%">
	  <tr>
		<td valign="top">
		   <table border="0" cellpadding="2" cellspacing="0" width="100%">
			 <tr>
			   <td>
			     <font face="arial" size="-1">

                 <H4><B>Bishop Anderson House</B></H4>
					<blockquote>
					Pastoral care, lay pastoral chaplaincy training, services to hearing
					impaired persons.<BR><br>
					707 S. Wood St., Chicago 60612<BR>
					(312) 563-4825<br>
					<I>The Rev. James Risk, director</I></blockquote>
					
					<H4><B>Cathedral Counseling Center</B></H4>
					<blockquote>
					Psychotherapeutic services for individuals, couples, families,
					and groups on a sliding fee scale basis.<BR><br>
					671 North Wabash Avenue<BR>
					(312) 337-5874<br>
					<i>Maureen Kelly, director</i></blockquote>
					
					<H4><B>Cathedral Shelter</B> <FONT SIZE="-1"><I>(<a href="http://www.cathedralshelter.org" target="_blank">web site</a>)</i></font></H4>
					<blockquote>
					Residential and outpatient addiction treatment; food distribution,
					emergency social services and supportive housing for single adults
					and mothers with children.<br><BR>
					1668 W. Ogden, Chicago 60612<BR>
					(312) 997-2222<br>
					<i>The Rev. Glenn Chalmers, director</i></blockquote>
					
					<H4><B>Lawrence Hall Youth Services</B> <FONT SIZE="-1"><I>(<a href="http://www.lawrencehall.org" target="_blank">web site</a>)</i></font></H4>
					<blockquote>
					Residential, special, and alternative education programs, employment
					training and job placement, assistance with independent living,
					foster care and early childhood intervention.<BR><br>
					4833 N. Francisco, Chicago 60625<BR>
					(773) 769-3500<br>
					<i>Mary Hollie, director</i></blockquote>
					
					<H4><B>The Church Home at Montgomery Place</B></H4>
					<blockquote>
					A ministry of Pastoral Care to the Elderly and a ministry of Pastoral
					Education (CPE).
					<BR><br>
					5550 South Lake Shore Drive, Chicago 60637<BR>
					(773) 753-4118<br>
					<i>The Rev. Dr. Robert Petite, executive director</i></blockquote>
					
					<H4><B>St. Gregory Episcopal School</B> <FONT SIZE="-1"><I>(<a href="http://www.sges.net" target="_blank">web site</a>)</i></font></H4>
					<blockquote>
					Independent elementary school for boys grades K-8.<BR><br>
					2130 S. Central Park Ave., Chicago, IL 60623-3113<BR>
					(773) 277-4447<br>
					<a href="mailto:anita@sges.net">anita@sges.net</a><br>
					<I>Dennis Wozniak, headmaster</I></blockquote>
					
					<H4><B>St. Leonard's Ministries</B></H4>
					<blockquote>
					St. Leonard's House, rehabilitation center for male ex-offenders; Grace House, residential center for female ex-offenders<BR><br>
					2100 W. Warren Blvd., Chicago 60612<BR>
					St. Leonard's House (312) 738-1414<br>
					<I>Robert Dougherty, director</I><br>
					Grace House (312) 733-5363<br>
					<i>Sr. Mary Dolan, director</i></blockquote>
					
					<H4><B>St. Mary's Services</B> <FONT SIZE="-1"><I>(<A HREF="http://homepage.interaccess.com/~stmary/home.htm" target="_blank">web site</A>)</I></FONT></H4>
					<blockquote>
					Domestic and international adoption services; placement and maternity
					counseling; birth parent support groups.<BR><br>
					717 W. Kirchoff Rd., Arlington Heights 60005<BR>
					(847) 870-8181<br>
					<i>Juanita Burdick, director</i></blockquote>
					
					<H4><B>Shelter Care Ministries</B> <FONT SIZE="-1"><I>(<A HREF="http://www.shelter-care.org" target="_blank">web site</A>)</I></FONT></H4>
					<blockquote>
					Emergency and temporary housing, counseling, and advocacy for homeless families; drop-in center for the mentally ill and homeless; and a community soup kitchen.
					<BR><br>
					412 N. Church St., Rockford 61103<BR>
					(815) 964-5520<br>
					<i><a href="mailto:crogers@shelter-care.org">Cheryl Rogers</a>, executive director</i></blockquote>
					
					<H4><B>Urban Family and Community Centers</B></H4>
					<blockquote>
					Food distribution; employment counseling, medical services and
					community center for low-income families and individuals.<BR><br>
					4241 Washington Blvd., Chicago 60624<BR>
					(773) 722-8333<br>
					<i>Chandra Libby, executive director</i></blockquote>
					
					<H4><B>Youth Guidance</B> <FONT SIZE="-1"><I>(<A HREF="http://www.youth-guidance.org/aboutyg.html" target="_blank">web site</A>)</I></FONT></H4>
					<blockquote>
					Employment development, vocational education, counseling and creative
					arts, crisis intervention, and individual, group and family counseling.<BR><br>
					122 S. Michigan Ave., Suite #1510, Chicago 60603<BR>
					(312) 253-4900<br>
					<i>Nancy Johnstone, director</i></blockquote>
					
					</font>
					</blockquote>
                  </font>			   
                 </td>
			 </tr>
		   </table>
		</td>
		<td width="225" valign="top" align="right">
		   <cf_esidenav imgname="#GetGroupInfo.ImgName#" groupname="#GetGroupInfo.GroupName#" showmembers ="1">
		</td>
	  </tr>
	</table> 

</cfmodule>

</HTML>