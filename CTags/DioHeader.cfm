<cfsetting enablecfoutputonly="Yes">

<cfif ThisTag.ExecutionMode is "START">

	<CFPARAM Name="Attributes.IsHome"		Default="No">
	<CFPARAM Name="Attributes.Banner"		Default="Yes">
	<CFPARAM Name="Attributes.Section"		Default="Diocese">

	<CFPARAM Name="Attributes.PageTitle"	default="">
	<CFPARAM Name="Attributes.SubTitle"		default="">
	<CFPARAM Name="Attributes.BottomLink"	default="">
	<CFPARAM Name="Attributes.PostDate"		default="">
	<CFPARAM Name="Attributes.Contact"		default="webmaster@episcopalchicago.org">
	<CFPARAM Name="Attributes.TabWidth"		default="100%">
	<CFPARAM Name="Attributes.NavAlign"		Default="right">
	<CFPARAM Name="Attributes.NavLinks"		Default="Bishops:/Bishop/,Staff:/Diocese/DioOffices.cfm,Diocesan Center:/Diocese/,Episcopal Charities:/Ministries/EpisCharities.cfm,Marketplace:/marketplace.cfm,Clergy Openings:/Careers.cfm">
	<cfset FirstTime = 1>
	
	<cfoutput>
<!--- 	<MAP NAME="NavBar">
	<AREA SHAPE="RECT" COORDS="4,1,47,14" HREF="/">
	<AREA SHAPE="RECT" COORDS="56,2,105,15" HREF="/News/">
	<AREA SHAPE="RECT" COORDS="113,2,176,14" HREF="/Calendar.cfm">
	<AREA SHAPE="RECT" COORDS="181,2,252,15" HREF="/Diocese/Directory.cfm">
	<AREA SHAPE="rect" COORDS="260,2,327,14" HREF="http://www.saintjamescathedral.org" target="_blank" alt="">
	<AREA SHAPE="RECT" COORDS="335,1,404,15" HREF="/Ministries/">
	<AREA SHAPE="RECT" COORDS="408,1,456,14" HREF="/Links.cfm">
	<AREA SHAPE="RECT" COORDS="459,1,518,15" HREF="/SiteSearch.cfm">
	<AREA SHAPE="RECT" COORDS="522,1,594,14" HREF="/Contact.cfm">
	</MAP> --->
    <map name="TopNav" id="TopNav">
	    <area alt="Home" coords="13,0,64,20" href="/">
		<area alt="News" coords="65,0,105,14" href="/news">
		<area alt="Events" coords="108,0,176,15" href="/calendar.cfm">
		<area alt="Church Directory" coords="182,0,245,14" href="/diocese/directory.cfm">
		<area alt="Saint James Cathedral" coords="257,0,332,15" href="http://www.saintjamescathedral.org" target="_blank">
		<area alt="Ministries" coords="337,0,401,15" href="/Ministries">
		<area alt="Links" coords="404,0,449,14" href="/links.cfm">
		<area alt="Resources" coords="452,0,521,15" href="/resources.cfm">
		<area alt="Contact US" coords="523,0,600,17" href="/contact.cfm">
	</map>
	<cfif Attributes.Section is "Admin">
	<BODY bgcolor="White" text="Black" VLINK="Teal" LINK="Blue" alink="Navy" leftmargin=3 topmargin=0>
	<cfelse>
	<BODY bgcolor="White" text="Black" VLINK="Teal" LINK="Blue" alink="Navy" leftmargin=3 topmargin=0>
	</cfif>

	<style>
		A:Hover	{
			color : navy;
			background-color : ##F3E9DE;
		}
	</style>

	<center>
	<table width="#Attributes.TabWidth#" border=0 cellpadding=0 cellspacing=0>
		<cfif Attributes.Banner neq "PopUP">
		<tr valign=top>
		    <td align=#Attributes.NavAlign#>
			<table border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/images/Homepage/TopNav.jpg" alt="" name="TopNav" id="TopNav" width="600" height="15" border="0" usemap="##TopNav" ismap></td>
              </tr>
              <!--- <tr>
                <td><img src="/images/Homepage/bottomNav.jpg" alt="" name="BotNav" id="BotNav" width="600" height="15" border="0" usemap="##BotNav" ismap></td>
              </tr> --->
            </table>
			<cfif Attributes.NavLinks is not "">
				<font face="Verdana,Arial" color="Navy" size="-1">
				<cfloop index="Link" list="#Attributes.NavLinks#">
					<cfif FirstTime eq 0><b>&middot;</b></cfif>
					<cfset FirstTime = 0>
					<a href="#ListGetAt('#Link#', 2, ':')#" style="text-decoration: none;"><font color=navy>#ListGetAt('#Link#', 1, ':')#</font></a>
				</cfloop>
				<br></font>
			</cfif>
			</td>
		</tr>
		</cfif>
	</cfoutput>

	<!-- Heading Sections  -->

	<cfif Attributes.IsHome is "No" AND Attributes.Banner is "Yes">
		<cfswitch Expression="#Attributes.Section#">
		<cfcase value="Admin">
		<cfoutput>
		<tr valign=top>
			<td>
			<IMG SRC="/images/TheSealsm.gif" WIDTH=72 hspace=20 vspace=0 HEIGHT=104 BORDER=0 align="left" ALT="">
			<center>
			<br><FONT FACE="Verdana,Arial" SIZE="+1" COLOR="Navy"><b>#Attributes.PageTitle#</b></FONT><br>
			<FONT FACE="Tahoma,Arial" color="Black">#Attributes.SubTitle#</font><br>
			</center>
			<div align=right><FONT FACE="Tahoma,Arial" size="-1"><a href="/Admin" style="text-decoration: none; color: blue;"><b>Admin Home</b></a></FONT></div>
			<HR size=2 align=center  width=90% COLOR="Blue">
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Diocese">
		<cfoutput>
		<tr valign=top>
			<td>
			<IMG SRC="/images/DioLogo.jpg" WIDTH=60 hspace=6 vspace=0 HEIGHT=60 BORDER=0 align="left" ALT="">
			<br><FONT FACE="Verdana,Arial" SIZE="+1" COLOR="##000099"><b>#Attributes.PageTitle#</b></FONT><br>
			<FONT FACE="Tahoma,Arial" color="##a3282c">#Attributes.SubTitle#</font><br>
			<cfif Attributes.PostDate is not ""><div align=right><FONT FACE="Arial" SIZE="-2"><I>Web Posted on #Attributes.PostDate#</I></FONT></div>
			<cfelseif Attributes.BottomLink is not ""><div align=right><FONT FACE="Arial" SIZE="-2">#Attributes.BottomLink#</FONT></div>
			<cfelse><br></cfif>
			<HR size=2 align=right  width=90% COLOR="PURPLE">
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="ConventionHome">
		<cfoutput>
		<tr valign=top align="#Attributes.NavAlign#">
			<td>
			<br>
			<table width=600 border=0 cellpadding=3 cellspacing=0>
			<tr valign="top">
				<td width=100%>
				<IMG SRC="/images/DioLogo.jpg" WIDTH=60 hspace=6 vspace=0 HEIGHT=60 BORDER=0 align="left" ALT="">
				<FONT FACE="Verdana,Arial" SIZE="+1" COLOR="Purple"><b>#Attributes.PageTitle#</b></FONT><br>
				<FONT FACE="Tahoma,Arial" color="Navy">#Attributes.SubTitle#</font><br>
				<cfif Attributes.PostDate is not ""><FONT FACE="Tahoma,Arial" color="Navy"><B>#Attributes.PostDate#</B></font>
				<cfelse><br></cfif>
				<br>&nbsp;
				</td>
			</tr>
			</table>
			</td>
		</tr>
			<tr valign=top align=#Attributes.NavAlign# bgcolor="##f0f0f0">
				<td colspan=3><font face="Arial" size="-1">
				<a href="index.cfm" style="text-decoration: none;"><font color=navy>Welcome</font></a>
				<b>&middot;</b>
				<a href="Schedule.cfm" style="text-decoration: none;"><font color=navy>Schedule</font></a>
				<b>&middot;</b>
				<a href="Registration.cfm" style="text-decoration: none;"><font color=navy>Registration</font></a>
				<b>&middot;</b>
				<a href="Lodging.cfm" style="text-decoration: none;"><font color=navy>Hotel</font></a>
				<b>&middot;</b>
				<a href="MealInfo.cfm" style="text-decoration: none;"><font color=navy>Meals</font></a>
				<b>&middot;</b>
				<a href="Workshops.cfm" style="text-decoration: none;"><font color=navy>Workshops</font></a>
				<b>&middot;</b>
				<a href="Exhibits.cfm" style="text-decoration: none;"><font color=navy>Exhibits</font></a>
				<b>&middot;</b>
				<a href="Worship.cfm" style="text-decoration: none;"><font color=navy>Worship</font></a>
				<b>&middot;</b>
				<a href="Gallery.cfm" style="text-decoration: none;"><font color=navy>Photo Gallery</font></a>
				<br>
				<a href="ConvNominations.cfm" style="text-decoration: none;"><font color=navy>Nominations</font></a>
				<b>&middot;</b>
				<a href="Resolutions.cfm" style="text-decoration: none;"><font color=navy>Resolutions</font></a>
				<b>&middot;</b>
				<a href="Reports.cfm" style="text-decoration: none;"><font color=navy>Reports</font></a>
				<b>&middot;</b>
				<a href="Address.cfm" style="text-decoration: none;"><font color=navy>Presentations/Sermons</font></a>
				<b>&middot;</b>
				<a href="Committee.cfm" style="text-decoration: none;"><font color=navy>Convention Committee</font></a>
				</font></td>
			</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Convention">
		<cfoutput>
		<tr valign=top>
			<td>
			<br>
			<table width=100% border=0 cellpadding=3 cellspacing=0>
			<tr valign="top" bgcolor="##E2A7E9">
				<td width=40 bgcolor="Purple"><img src="/images/blank.gif" height=1 width=40 border=0></td>
				<td width=100%>
				<font face="Verdana,Tahoma,'News Gothic',Arial" color="Purple" size="+2">#Attributes.PageTitle#</font><br>
				<font face="'News Gothic',Arial" color="Navy" size="+1">#Attributes.SubTitle#</font><br>
				<font face="Arial" color="black" size="-1">#Attributes.PostDate#</font>
				</td>
				<td width=72 align=center valign=center>
				<a href="/"><IMG SRC="/images/3dShield.gif" WIDTH=52 hspace=0 vspace=0 HEIGHT=54 BORDER=0 ALT=""></a>
				</td>
			</tr>
			<tr valign=top bgcolor="##f0f0f0">
				<td colspan=3><font face="Arial" size="-1">
				<a href="index.cfm" style="text-decoration: none;"><font color=navy>Welcome</font></a>
				<b>&middot;</b>
				<a href="Schedule.cfm" style="text-decoration: none;"><font color=navy>Schedule</font></a>
				<b>&middot;</b>
				<a href="Registration.cfm" style="text-decoration: none;"><font color=navy>Registration</font></a>
				<b>&middot;</b>
				<a href="Lodging.cfm" style="text-decoration: none;"><font color=navy>Hotel</font></a>
				<b>&middot;</b>
				<a href="MealInfo.cfm" style="text-decoration: none;"><font color=navy>Meals</font></a>
				<b>&middot;</b>
				<a href="Workshops.cfm" style="text-decoration: none;"><font color=navy>Workshops</font></a>
				<b>&middot;</b>
				<a href="Exhibits.cfm" style="text-decoration: none;"><font color=navy>Exhibits</font></a>
				<b>&middot;</b>
				<a href="Worship.cfm" style="text-decoration: none;"><font color=navy>Worship</font></a>
				<b>&middot;</b>
				<a href="Gallery.cfm" style="text-decoration: none;"><font color=navy>Photo Gallery</font></a>
				<br>
				<a href="ConvNominations.cfm" style="text-decoration: none;"><font color=navy>Nominations</font></a>
				<b>&middot;</b>
				<a href="Resolutions.cfm" style="text-decoration: none;"><font color=navy>Resolutions</font></a>
				<b>&middot;</b>
				<a href="Reports.cfm" style="text-decoration: none;"><font color=navy>Reports</font></a>
				<b>&middot;</b>
				<a href="Address.cfm" style="text-decoration: none;"><font color=navy>Presentations/Sermons</font></a>
				<b>&middot;</b>
				<a href="Committee.cfm" style="text-decoration: none;"><font color=navy>Convention Committee</font></a>
				</font></td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Ministry">
		<cfoutput>
		<tr valign=middle>
			<td align=center>
			<br>
			<table width=86% cellspacing=0 cellpadding=0 border=0>
			<tr valign=top>
				<td width=200>
					<img src="/images/photos/OurMinistry.jpg" width=200 height=131 alt="" border="1"><br>
				</td>
				<td width=100% align=center>
					<p><FONT FACE="Tahoma,Arial" SIZE="+2" COLOR="Purple">Ministries within<br>the Diocese of Chicago</FONT></p>
					<p><FONT FACE="Tahoma,Arial" color="Navy" size="+1">#Attributes.PageTitle#</font></p>
					<cfif Attributes.SubTitle is not ""><FONT FACE="Arial" SIZE="-1"><b>#Attributes.SubTitle#</b></FONT></cfif>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Cathedral">
		<cfoutput>
		<tr valign=middle>
			<td align=center>
			<br>
			<table width=86% cellspacing=0 cellpadding=0 border=0>
			<tr valign=top>
				<td width=156>
					<img src="/images/photos/OurCathedral.jpg" width=156 height=192 alt="" border=1><br>
				</td>
				<td width=100% align=center>
					<p><br><FONT FACE="Tahoma,Arial" SIZE="+2" COLOR="Purple">St. James Cathedral<br>The Diocese of Chicago</FONT></p>
					<p><FONT FACE="Tahoma,Arial" color="Navy" size="+1">#Attributes.PageTitle#</font></p>
					<cfif Attributes.SubTitle is not ""><FONT FACE="Arial" SIZE="-1">#Attributes.SubTitle#</FONT></cfif>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Faith">
		<cfoutput>
		<tr valign=middle>
			<td align=center>
			<br>
			<table width=86% cellspacing=0 cellpadding=0 border=0>
			<tr valign=top>
				<td width=130>
					<img src="/images/photos/OurFaith.jpg" width=130 height=174 alt="" border="1"><br>
				</td>
				<td width=100% align=center>
					<p><br><br><FONT FACE="Tahoma,Arial" SIZE="+2" COLOR="Purple">Our Faith and Beliefs within<br>the Episcopal Church</FONT></p>
					<p><FONT FACE="Tahoma,Arial" color="Navy" size="+1">#Attributes.PageTitle#</font></p>
					<cfif Attributes.SubTitle is not ""><FONT FACE="Arial" SIZE="-1">#Attributes.SubTitle#</FONT></cfif>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Heritage">
		<cfoutput>
		<tr valign=middle>
			<td align=center>
			<br>
			<table width=86% cellspacing=0 cellpadding=0 border=0>
			<tr valign=top>
				<td width=160>
					<img src="/images/photos/OurHeritage.jpg" width=160 height=192 alt="" border="1"><br>
				</td>
				<td width=100% align=center>
					<p><br><br><FONT FACE="Tahoma,Arial" SIZE="+2" COLOR="Purple">Our Heritage within<br>the Anglican Communion</FONT></p>
					<p><FONT FACE="Tahoma,Arial" color="Navy" size="+1">#Attributes.PageTitle#</font></p>
					<cfif Attributes.SubTitle is not ""><FONT FACE="Arial" SIZE="-1">#Attributes.SubTitle#</FONT></cfif>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="GenConv">
		<cfoutput>
		<tr valign=middle>
			<td align=center>
			<br>
			<table width=86% cellspacing=0 cellpadding=0 border=0>
			<tr valign=top>
				<td width=160>
					<img src="/images/photos/GenCon/GC2003Logo.gif" alt="" border="0"><br>
				</td>
				<td width=100% align=center>
					<p><br><br><FONT FACE="Tahoma,Arial" SIZE="+2" COLOR="Purple">General Convention<br>of the Episcopal Church</FONT></p>
					<p><FONT FACE="Tahoma,Arial" color="Navy" size="+1">#Attributes.PageTitle#</font></p>
					<cfif Attributes.SubTitle is not ""><FONT FACE="Arial" SIZE="-1">#Attributes.SubTitle#</FONT></cfif>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>

		<cfcase value="Bishops">
		<cfoutput>
		<tr valign=middle>
			<td align=center>
			<br>
			<table width=86% cellspacing=0 cellpadding=0 border=0>
			<tr valign=top>
				<td width=174>
					<img src="/images/photos/OurBishops.jpg" width=175 height=162 alt="" border="1"><br>
				</td>
				<td width=100% align=center>
					<p><br><FONT FACE="Tahoma,Arial" SIZE="+2" COLOR="Purple">The Bishops in<br>the Diocese of Chicago</FONT></p>
					<p><FONT FACE="Tahoma,Arial" color="Navy" size="+1">#Attributes.PageTitle#</font></p>
					<cfif Attributes.SubTitle is not ""><FONT FACE="Arial" SIZE="-1">#Attributes.SubTitle#</FONT></cfif>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		</cfoutput>
		</cfcase>
		</cfswitch>
	</cfif>

	<!-- Contents Section -->

	<cfoutput>
		<tr valign=top>
		<td align=left>
		<br>
	</cfoutput>

<cfelse>

	<cfoutput>

		</td>
		</tr>

	<!-- Copyright Section for every page -->
	</cfoutput>

	<cfif Attributes.IsHome is "Yes">
	<cfoutput>
		<tr valign=top>
			<td align=left>
				<table width="100%" border=0 cellspacing=0 cellpadding=0>
				<tr valign=bottom>
					<td width=50% align=left>
						<font face="arial" size="-1"><br><a href="/WebPolicy.cfm">Web Policy Statement</a></font><br>
						<FONT face="verdana" SIZE="-2">&copy; 2000 - The Diocese of Chicago, all rights reserved</FONT>
					</td>
					<td width=50% align=right>
						<FONT face="verdana" SIZE="-2"><I>This site being maintained by <A HREF="http://www.rlpsolutions.com">RPnet Solutions</A></I></FONT>
					</td>
				</tr>
				</table>
			</td>
		</tr>
	</cfoutput>
	<cfelse>
	<cfoutput>
		<tr valign=top>
			<td align=left>
				<br><hr size=1>
				<table width="100%" border=0 cellspacing=0 cellpadding=0>
				<tr valign=top>
					<td width=52 align=left>
						<IMG SRC="/images/3dShield.gif" WIDTH=52 HEIGHT=54 BORDER=0 alt="">
					</td>
					<td width=100% align=right>
						<FONT FACE="Tahoma" SIZE="-2">
						<a href="/WebPolicy.cfm">Web Policy Statement</a><br><br>
						&copy; 2000 - The Diocese of Chicago, all rights reserved<br>
						<I>This site being maintained by <A HREF="http://www.rlpsolutions.com">RPnet Solutions</A></I></FONT><br>
					</td>
				</tr>
				</table>
			</td>
		</tr>
	</cfoutput>
	</cfif>

	<cfoutput>
	</table>
	</center>

	</BODY>
	</cfoutput>

</cfif>

<cfsetting enablecfoutputonly="No">
