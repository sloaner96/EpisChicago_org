<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">

<!-- set these to the month/year of
	the calendar you want to display --->

<cfparam name="Attributes.CurrentMonth"	default="#DatePart('m',Now())#">
<cfparam name="Attributes.CurrentYear"	default="#DatePart('yyyy',Now())#">
<cfparam name="Attributes.ActiveDays"	default="Yes">
<cfparam name="Attributes.TitleBar"		default="Yes">
<cfparam name="Attributes.EventCFM"		default="Calendar.cfm">
<cfparam name="Attributes.MaxWidth"		default="160">
<cfparam name="Attributes.BgColor"		default="##E0CC98">
<cfparam name="Attributes.PastDayColor"	default="##cccccc">
<cfparam name="Attributes.ShowPrev" 	default="no">
<cfparam name="Attributes.GroupID" 	    default="0">
<cfparam name="Attributes.ContentID" 	    default="0">
<cfsetting enablecfoutputonly="No" showdebugoutput="Yes">

<cfoutput>
<table border="0" width="#Attributes.MaxWidth#" cellspacing="0">
</cfoutput>

<cfif Attributes.TitleBar eq "Yes">
<cfoutput>
<tr>
	<td colspan="8" bgcolor="#Attributes.BGColor#" align="center">
		<font color="black" face="arial,helvetica,sans-serif" size="2">
		<b>#MonthAsString(DatePart('m', CreateDate(Attributes.CurrentYear,Attributes.CurrentMonth,1)  ))#</b>
		</font>
	</td>
</tr>
</cfoutput>
</cfif>

<tr>
	<td align="right"><font size="1" color="black" face="Arial"><b>S</b></font></td>
	<td align="right"><font size="1" color="black" face="Arial"><b>M</b></font></td>
	<td align="right"><font size="1" color="black" face="Arial"><b>T</b></font></td>
	<td align="right"><font size="1" color="black" face="Arial"><b>W</b></font></td>
	<td align="right"><font size="1" color="black" face="Arial"><b>T</b></font></td>
	<td align="right"><font size="1" color="black" face="Arial"><b>F</b></font></td>
	<td align="right"><font size="1" color="black" face="Arial"><b>S</b></font></td>
	<td align="right"><img border="0" src="images/blank.gif" width="6" height="1"></td>
</tr>
<cfset DaysinMonth = DaysInMonth(Attributes.CurrentMonth)>
<cfset DayinProcess = 1>
	
<cfloop index="x" from="1" to="6">
	<cfset firstDayofNewWeek = x * 7 - 6>
	<cfif DayinProcess lt firstDayofNewWeek>
	<tr>
	<cfloop index="i" from="1" to="7" step="1">
		<cfif IsDate("#Attributes.CurrentMonth#/#DayinProcess#/#Attributes.CurrentYear#")>
			<cfset PlaceinWeekofDayinProcess = DayofWeek("#Attributes.CurrentMonth#/#DayinProcess#/#Attributes.CurrentYear#")>
			<cfoutput>
			<cfif i is PlaceinWeekofDayinProcess>
				<td align="right">
					<cfif DateAdd('d',-1,Now()) lte CreateDate(Attributes.CurrentYear, Attributes.CurrentMonth, DayinProcess)>
						<a href="#Attributes.EventCFM#?m=#DatePart('m',CreateDate(Attributes.CurrentYear, Attributes.CurrentMonth, DayinProcess))#&d=#DatePart('d',CreateDate(Attributes.CurrentYear, Attributes.CurrentMonth, DayinProcess))#&y=#Attributes.CurrentYear#<cfif attributes.GroupID NEQ 0>&GroupID=#Attributes.groupID#</cfif><cfif attributes.ContentID NEQ 0>&GCID=#Attributes.ContentID#</cfif>">
					</cfif>
					<font <cfif DateAdd('d',-1,Now()) lte CreateDate(Attributes.CurrentYear, Attributes.CurrentMonth, DayinProcess)>color="navy"<cfelse>color="#Attributes.PastDayColor#"</cfif> size="1">#DayinProcess#</font>
					<cfif DateAdd('d',-1,Now()) lte CreateDate(Attributes.CurrentYear, Attributes.CurrentMonth, DayinProcess)></a></cfif>
				</td>
				<cfset DayinProcess = DayinProcess + 1>
			<cfelse>
				<td align="right"><font size="1">&nbsp;</font></td>
			</cfif>
			</cfoutput>
		<cfelse>
			<td align="right"><font size="1">&nbsp;</font></td>
		</cfif>
	</cfloop>
		<td align="right"><font size="1">&nbsp;</font></td>
	</tr>
	</cfif>
</cfloop>

<tr>
	<td colspan="8" align="right"><cfoutput><img border="0" src="images/blank.gif" width="#Attributes.MaxWidth#" height="3"></cfoutput></td>
</tr>

</table>

