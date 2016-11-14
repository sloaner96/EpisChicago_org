<cfset EndPeriod = DateAdd("m", 6, now())>
<cfquery name="GetCal" datasource="#Application.DSN#">
	SELECT TOP 3 * From Events e
		WHERE e.Approved = True
			AND (e.HighLight = True OR e.EndDate <= #EndPeriod#)
			AND e.EndDate >= #CreateODBCDateTime(now())#
		ORDER BY e.Highlight, e.GrpHighlight, e.BeginDate
</cfquery>

<cfset BegPeriod = DateAdd("m", -2, now())>
<cfquery name="Articles" datasource="#Application.DSN#">
	SELECT TOP 3 Headline, ArticleID 
	    From Articles
		WHERE Approved = True AND HighLight = True
		ORDER BY DateSubmitted DESC, ArticleID DESC
</cfquery>

<cfquery name="Ministries" datasource="#Application.DSN#">
	Select * 
	From GroupNfo
	Where IsActive = True
	AND HomePageDisplay = True
	Order By GroupName
</cfquery>

<cfquery name="Resources" datasource="#Application.DSN#">
	Select * 
	From ResourceGrouping
	Where Active = True
	AND DisplayOnSite = True
	Order By Ranking
</cfquery>

<cfquery name="ResourceCenter" datasource="#Application.DSN#">
	Select Top 3 * 
	From Resources
	Where Active = True
	AND Highlight = True
	order By ResourceLabel
</cfquery>

<cfquery name="Programs" datasource="#Application.DSN#">
	Select * 
	From Programs
	Where Approved = True
	AND HomepageDisplay = True
	<!--- AND BeginDate <= #CreateOdbcDateTime(now())# --->
	AND EndDate <= #EndPeriod# 
	AND EndDate >= #CreateOdbcDateTime(now())#
	Order By EndDate Desc, BeginDate, Title
</cfquery>

<cfquery name="BannerAds" datasource="#Application.DSN#">
	Select Top 1 *
	From BannerAds
	Where AdStart <= #CreateOdbcDateTime(now())# 
	AND AdFinish >= #CreateOdbcDateTime(now())#
</cfquery>
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Anglican community in Northern Illinois, called by God to new and abundant life in Christ, we celebrate and share our Christian faith and tradition through worship, study, fellowship, social witness and service.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>The Episcopal Diocese of Chicago, Illinois</TITLE>
</head>
<cfmodule Template="#Application.Header#" IsHome="Yes" NavAlign="center" TabWidth="600">
<!--- Search Section --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td>
	   <table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
             <td width="40%">&nbsp;</td>
			 <form name="SiteSrch" method="POST" action="/SiteSearch.cfm"><td align="right"><font face="verdana" color="#003366" size="-2"><strong>SITE SEARCH:</strong> <input type="text" name="Term" size=10 maxlength=60></font></td></form>
			 <form name="FindKwd" method="POST" action="/Diocese/ParishLocator.cfm"><td align="right"><font face="verdana" color="#003366" size="-2"><strong>FIND A CHURCH:</strong> <input type="text" name="Keyword" size=10 maxlength=60></font> </td></form>
          </tr>
       </table>
	 </td>
  </tr>
</table>
<!--- Header Section --->
<table border="0" cellpadding="0" cellspacing="0">
   <tr>
      <td><img src="/images/Homepage/DioLogoMain.jpg" alt="Diocesan Logo" border="0"></td>
	  <td><img src="/images/HomePage/EpisDioHead.gif" alt="The Episcopal Diocese of" border="0"></td>
	  <td><img src="/images/HomePage/ChicagoHead.jpg" alt="Chicago" border="0"></td>
   </tr>
</table>
<!--- Main Content --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
     <!--- Left Watch Box --->
     <td width="168" valign="top">
	    <table border="0" cellpadding="0" cellspacing="0" width="168">
          <tr>
             <td><img src="/images/Homepage/WatchBoxTop.gif" width="168" height="9" alt="" border="0"></td>
          </tr>
		  <tr>
		     <td background="/images/homepage/WatchBoxbg.gif">
			    <table border="0" cellpadding="0" cellspacing="0" width="168">
                   <tr>
                     <td colspan=2><img src="/images/Homepage/NewswatchHead.gif" width="168" height="15" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td colspan="2"><img src="/images/blank.gif" height="15" width="1"></td>
				   </tr>
				   <cfoutput query="Articles">
					<tr valign=top>
					    <td><img src="/images/blank.gif" height="1" width="5"></td>
						<td><font face="verdana" size="-2"><a href="/News/ViewArticle.cfm?ArticleID=#ArticleID#">#Headline#</a></font></td>
					</tr>
					<tr>
					  <td colspan=2><img src="/images/blank.gif" height="10" width="1"></td>
					</tr>
					</cfoutput>
				   <tr>
				      <td colspan="2"><img src="/images/blank.gif" height="30" width="1"></td>
				   </tr>
				   <tr>
                     <td colspan="2"><img src="/images/Homepage/DateWatchHead.gif" width="168" height="15" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td colspan="2"><img src="/images/blank.gif" height="15" width="1"></td>
				   </tr>
				   <cfoutput query="GetCal">
					 <tr valign=top>
					    <td><img src="/images/blank.gif" height="1" width="5"></td>
						<td><font face="verdana" size="-2"><a href="ViewEvent.cfm?EventID=#EventID#">#EventName#</a></font></td>
					 </tr>
					 <tr>
					   <td colspan="2"><img src="/images/blank.gif" height="10" width="1"></td>
					 </tr>
				   </cfoutput>
				   <tr>
				      <td colspan="2"><img src="/images/blank.gif" height="30" width="1"></td>
				   </tr>
				   <cfif ResourceCenter.recordcount GT 0>
				   <tr>
                     <td colspan="2"><img src="/images/Homepage/ResourceCentHead.gif" width="168" height="15" alt="" border="0"></td>
                   </tr>
				   <tr>
				      <td colspan="2"><img src="/images/blank.gif" height="15" width="1"></td>
				   </tr>
				   <cfoutput query="ResourceCenter">
					 <tr valign=top>
					    <td><img src="/images/blank.gif" height="1" width="5"></td>
						<td><font face="verdana" size="-2"><a href="ResourceDetail.cfm?RecID=#ResourceCenter.ResourceID#&CatID=#ResourceCenter.Category#">#ResourceLabel#</a></font></td>
					 </tr>
					 <tr>
					   <td colspan="2"><img src="/images/blank.gif" height="10" width="1"></td>
					 </tr>
				   </cfoutput>
				   </cfif>
				   <tr>
				      <td colspan="2"><img src="/images/blank.gif" height="30" width="1"></td>
				   </tr>
                </table>
			 </td>
		  </tr> 
		  <tr>
		     <td><img src="/images/Homepage/WatchBoxBottom.gif" width="168" height="8" alt="" border="0"></td>
		  </tr>
        </table>
	 </td>
	 <td valign="top">
	    <table border="0" cellpadding="3" cellspacing="0" width="100%">
           <tr>
              <td valign="top">
			     <table border="0" cellpadding="0" cellspacing="0" width="100%">
                   <tr>
                     <td><img src="/images/HomePage/MainPageGraphic.jpg" alt="" border="0"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="verdana" color="#003366" size="-2"><em>The Episcopal Church of Northern Illinois</em></font></td>
                   </tr>
				   <tr>
				     <td><a href="missionvision.cfm"><img src="images/HomePage/stratplan.jpg" alt="Strategic Plan" border="0"></a></td>
				   </tr>
                 </table>
			  </td>
			  <td valign="top">
			   <cfif BannerAds.Recordcount GT 0>
			     <table border="0" cellpadding="0" cellspacing="0" width="100%">
                   <cfoutput> 
				    <cfif BannerAds.ImgPath NEQ ""> 
					 <tr>
					   <td align="center"><a href="AdRedirect.cfm?BID=#BannerAds.BannerID#"><img src="/images/Banners/#BannerAds.ImgPath#" border="0" alt="#BannerAds.AdName#"></a></td>
					 </tr>
					<cfelse>
				     <tr>
					   <td align="center"><a href="AdRedirect.cfm?BID=#BannerAds.BannerID#"><font face="tahoma" color="##cc3300" size="+1"><strong>#BannerAds.AdName#</strong></font></a></td>
					 </tr>
					</cfif>
                    </cfoutput>
				 </table><br> <br>
				 </cfif>
				 <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                      <td><font face="arial" size="-1">
					     Episcopal&nbsp;Church&nbsp;Center<br>
						 65 E. Huron St.<br>
						 Chicago, IL 60611<br>
						 (312) 751-4200<br>
						 fax (312) 787-4534<br>
						 <a href="/Directions.cfm"><i>Map & Directions</i></a></font>
					  </td>
                    </tr>
                 </table>
			  </td>
           </tr>
        </table><br>
		<table border="0" cellpadding="4" cellspacing="0" width="100%">
           <tr>
              <td valign="top" width="215">
			    <table border="0" cellpadding="3" cellspacing="0" width="100%">
                  <cfif Ministries.recordcount GT 0>
				  <tr>
                     <td><font face="tahoma" color="#cc0000" size="-1"><strong>Ministries/Offices</strong></font></td>
                  </tr>
				  <cfoutput query="Ministries">
				   <tr>
				     <td><a href="/diocese/offices/index.cfm?GroupID=#Ministries.GroupID#"><font face="verdana" size="-2">#Ministries.GroupName#</font></a></td>
				   </tr>
				  </cfoutput>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  </cfif>
				  <cfif programs.recordcount GT 0>
					  <tr>
					    <td><font face="tahoma" color="#cc0000" size="-1"><strong>Programs/Events</strong></font></td>
					  </tr>
					  <cfoutput query="Programs">
					   <tr>
					     <td><a href="Programs.cfm?ProgramID=#Programs.ProgramID#"><font face="verdana" size="-2">#programs.Title#</font></a></td>
					   </tr>
					  </cfoutput>
				  </cfif>
                </table>
			  </td>
			  <td>&nbsp;</td> 
			  <cfif resources.recordcount GT 0>
				  <td valign="top" width="215">
				    <table border="0" cellpadding="0" cellspacing="0" width="100%">
	                  <tr>
	                    <td><font face="tahoma" color="#cc0000" size="-1"><strong>Resources</strong></font></td>
	                  </tr>
					   <tr>
					      <td><a href="Resources.cfm"><font face="verdana" size="-2">Resource Directory</font></a></td>
					   </tr>
					  <cfoutput query="Resources">
					   <tr>
					      <td><a href="ResourceGroups.cfm?RGID=#Resources.RGroupID#"><font face="verdana" size="-2">#Resources.Title#</font></a></td>
					   </tr>
					  </cfoutput>
	                </table>
				  </td>
			  </cfif>
           </tr>
        </table>
	 </td>
   </tr>
</table><br><br>
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
  <tr>
    <td align="left" width="200"><a href="/Diocese/DiocesanLogo.cfm"><img src="/images/HomePage/OurLogoMain.jpg" alt="Our Diocesan Logo" border="0"></a></td>
	<td align="center" width="200"><a href="EpiscopalChurch.cfm"><img src="/images/HomePage/epischurchlogoMain.jpg" alt="The Episcopal Church" border="0"></a></td>
	<td align="right" width="200"><a href="/Faith/AboutEpisShield.cfm"><img src="/images/HomePage/episshieldmain.gif" alt="Episcopal Church Shield" border="0"></a></td>
  </tr>
</table>
<br><br>
</cfmodule>
</body>
</html>
