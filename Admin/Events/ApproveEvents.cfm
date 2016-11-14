<cfif IsDefined("form.GroupEvents")>
  <cfif ListLen(form.groupevents) GT 0>
    <cfloop list="#form.groupEvents#" index="i" delimiters=",">
	   <cfquery name="Approve" datasource="#Application.dsn#">
	      Update Events
		   SET Approved = True
		  Where EventID = #i#
	   </cfquery>
	</cfloop>
  </cfif>
</cfif>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Event Search Screen">

<blockquote>
<p><font face="arial" size="-1">Use the form below to approve group events for inclusion into the diocesan calendar.</font></p>
</blockquote>
<cfquery name="GetUnapproved" datasource="#Application.dsn#">
  Select E.*, G.GroupName
  From Events E, GroupNfo G
  Where E.OwningGroupID = G.GroupID
  AND E.DiocesanWide = True
  AND E.Approved = 0
  AND E.EndDate >= #CreateODBCDate(now())#
  Order by G.GroupName, DateSubmitted, E.Begindate
</cfquery>

<form action="ApproveEvents.cfm" method="POST">

<center>

<table border=0 cellspacing=1 cellpadding=4>
<cfif GetUnapproved.recordcount GT 0>
<cfoutput query="GetUnapproved" group="Groupname">
  <tr>
    <td colspan=5><font face="arial" size="-1"><strong>#GetUnapproved.GroupName#</strong></font></td>
  </tr>

<tr bgcolor="##006699">
  <td><font face="verdana" color="ffffff" size="-1"><strong>Approve</strong></font></td>
  <td><font face="verdana" color="ffffff" size="-1"><strong>Date Submitted</strong></font></td>
  <td><font face="verdana" color="ffffff" size="-1"><strong>Event Info</strong></font></td>
  <td><font face="verdana" color="ffffff" size="-1"><strong>Event Dates</strong></font></td>
</tr>
<cfoutput>
 <tr <cfif currentrow MOD(2) EQ 0>bgcolor="eeeee"</cfif>>
    <td valign="top"><input type="checkbox" name="GroupEvents" value="#EventID#"></td>
    <td valign="top"><font face="arial" size="-1">#DateFormat(DateSubmitted, 'mm/dd/yyyy')#</font></td>
	<td valign="top"><font face="arial" size="-1"><strong>#EventName#</strong><br>#Location#</font><br><font face="verdana" size="-2">#SpanExcluding(Description, chr(asc(".")))# ...</font></td>
    <td valign="top"><font face="arial" size="-1">#DateFormat(BeginDate, 'mm/dd/yyyy')# - #DateFormat(EndDate, 'mm/dd/yyyy')#</font></td> 
  </tr>
	  </cfoutput>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan=5 align=left>
		<br><input type="submit" value="Approve Events">
		<input type="reset"  value="Clear Form">
		</td>
	</tr>
<cfelse>
  <tr>
    <td><font face="verdana" color="#b5b5b5" size="+1"><strong>THERE ARE NO EVENTS TO APPROVE AT THIS TIME</strong></font></td>
  </tr>	
</cfif>
</table>
</center>
</form>

</CFMODULE>

</HTML>

