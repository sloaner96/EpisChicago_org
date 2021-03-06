<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfquery name="GetRes" datasource="#Application.dsn#">
  Select *,
    (Select CodeDesc
	  From Lookups
	   Where CodeGroup = 'RECCONTENT' 
	   AND CodeValue = R.ResourceType) as ResType,
	(Select Firstname+' '+Lastname
	   From Members
	   Where MemberID = R.AddedBy) as MemberAdded,
	(Select GroupName
	   From GroupNfo
	   Where GroupID = G.GroupID) as GroupAdded,   
	(Select CodeDesc
	   From Lookups
	   Where CodeGroup = 'RECCAT'
	   AND CodeValue = R.Category) as GrpCat,
	 (Select CodeDesc
	   From Lookups
	   Where CodeGroup = 'RECSUBCAT'
	   AND CodeValue = G.SubCatID) as GrpSubCat     
  From Resources R, GrpResources G
  Where R.ResourceID = G.ResourceID
  AND R.ResourceID = #Url.ResID#
</cfquery>
<html>
<head>
	<title>Group Resource View</title>
</head>

<body>
<font face="tahoma" size="+1" color="#003399">Group Resources</font><hr color="#003399" size=1 noshade>
<cfoutput query="GetRes">
<table border="0" cellpadding="4" cellspacing="0" align="center" width="98%">
  <tr>
    <td><font face="verdana" size="-2"><strong>Resource Name:</strong></font> <font face="arial" size="-1">#ResourceLabel#</font></td>
  </tr>
  <tr>
    <td><font face="verdana" size="-2"><strong>Type of Resource:</strong></font> <font face="arial" size="-1">#ResType#</font></td>
  </tr>
  <tr>
    <td><font face="verdana" size="-2"><strong>Group Category/Group SubCategory:</strong></font><br> <font face="arial" size="-1">#GrpCat#/#GrpSubCat#</font></td>
  </tr>
  <cfif GetRes.ResourceType EQ "S">
  	  <cfquery name="GetResource" datasource="#Application.dsn#">
	    Select *
		From ListServs
		Where ListID = #GetRes.ContentID#
	  </cfquery> 	
     <cfelseif GetRes.ResourceType NEQ "L"> 
	  <cfquery name="GetResource" datasource="#Application.dsn#">
	    Select *
		From Forms
		Where FormID = #GetRes.ContentID#
	  </cfquery>
    
  <cfelse>
  	  <cfquery name="GetResource" datasource="#Application.dsn#">
	    Select *
		From SiteLinks
		Where LinkID = #GetRes.ContentID#
	  </cfquery>
  </cfif>
     <cfif GetRes.ResourceType EQ "L">
	    <tr>
		  <td><font face="verdana" size="-1"><a href="http://#Replacelist(getResource.SiteURL, 'http://, https://', '')#" target="_blank">#GetResource.SiteName#</a></font></td>
		</tr>
  <cfelseif GetRes.ResourceType EQ "S">
	    <tr>
		  <td><font face="verdana" size="-1"><a href="mailto:#getResource.Emailaddr#" target="_blank">#GetResource.Label#</a></font></td>
		</tr>	
    <cfelse>
	    <tr>
		  <td><font face="verdana" size="-1"><a href="/DownloadResource.cfm?RecID=#GetResource.FormID#" target="_blank">Download the Resource</a></font></td>
		</tr>
 </cfif>
  <tr>
    <td><font face="verdana" size="-2"><strong>Resource Description:</strong></font> <br> <font face="arial" size="-1">#Desc#</font></td>
  </tr>
  <tr>
    <td>
	  <table border="0" cellpadding="2" cellspacing="0">
        <cfif GetRes.ContactName NEQ "">
	    <tr>
		  <td><font face="verdana" size="-2"><strong>Contact Name:</strong></font></td> 
          <td><font face="arial" size="-1">#GetRes.ContactName#</font></td>
        </tr>
		</cfif>
		<cfif GetRes.ContactEmail NEQ "">
		<tr>
		  <td><font face="verdana" size="-2"><strong>Contact Email:</strong></td> 
          <td><font face="arial" size="-1">#GetRes.ContactEmail#</font></td>
        </tr>
		</cfif>
		<cfif GetRes.ContactPhone NEQ "">
		<tr>
		  <td><font face="verdana" size="-2"><strong>Contact Phone:</strong></td>
          <td><font face="arial" size="-1">#GetRes.ContactPhone#</font></td>
        </tr>
      </cfif>
	  </table>
	</td>
  </tr>
</table>
<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
    <td><font face="verdana" size="-2"><strong>Owning Group:</strong></font> <font face="arial" size="-1">#GroupAdded#</font></td>
  </tr>
  <tr>
    <td><font face="verdana" size="-2"><strong>Last Updated:</strong></font> <font face="arial" size="-1">#DateFormat(LastUpdated, 'MM/DD/YYYY')#</font></td>
  </tr>
</table>
</cfoutput>
</body>
</html>
