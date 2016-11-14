
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<cfquery name="GetGrouping" datasource="#Application.DSN#">
	Select G.*,
	  (Select Count(*)
	    From ResourceGroupingContent
		Where  RGroupID = G.RgroupID) as ResourceCount
	From ResourceGrouping G
	Order By G.Active, G.DisplayonSite, G.Ranking
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Administer Homepage" SubTitle="Resource Groupings">

<center>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <td><a href="NewGrouping.cfm"><font face="arial" size="-1">Add A New Resource Grouping</font></a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><font face="tahoma" color="#003399" size="-1"><strong>Existing Groupings</strong></font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	  <table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="eeeeee">
        <tr bgcolor="#006699">
          <td><font face="verdana" color="ffffff" size="-1"><strong>Resource Grouping Title</strong></font></td>
		  <td><font face="verdana" color="ffffff" size="-1"><strong># of Resources</strong></font></td>
		  <td><font face="verdana" color="ffffff" size="-1"><strong>Display on Homepage</strong></font></td>
		  <td><font face="verdana" color="ffffff" size="-1"><strong>Admin Resources</strong></font></td>
        </tr>
		<cfoutput query="GetGrouping">
		  <tr bgcolor="ffffff">
		    <td><font face="VERDANA" size="-1">#GetGrouping.Title#<cfif GetGrouping.Active EQ 0><font face="arial">[INACTIVE]</font></cfif></font></td>
		    <td><font face="VERDANA" size="-1">#GetGrouping.ResourceCount#</font></td>
		    <td><font face="VERDANA" size="-1"><cfif GetGrouping.DisplayonSite EQ 1>YES<cfelse>NO</cfif></font></td>
		    <td align="center"><font face="VERDANA" size="-2"><a href="EditGrouping.cfm?RGID=#GetGrouping.RGroupID#">EDIT</a> | <a href="" style="color:##cc0000;">REMOVE</a></font></td>
		  </tr>
		</cfoutput>
      </table>
	</td>
  </tr>
</table>
</center>

</CFMODULE>

</HTML>