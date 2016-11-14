<cfquery name="GetLinks" datasource="#Application.DSN#">
 Select * From faithExplorerLinks F
</cfquery>
<cfquery name="getAllSiteLinks" datasource="#Application.DSN#">
  Select F.LinkID, F.CatId, S.LinkID as SiteLinkID, S.SiteName, S.SiteURL, S.Description,
     (Select CodeDesc
	  From Lookups
	  Where CodeGroup = 'FELINKCAT'
	  AND CodeValue = F.catID) as Catname
  From faithExplorerLinks F, SiteLinks S
  Where F.SiteLinkID = S.LinkID
  Order By F.CatID, S.SiteName
</cfquery>

<cfquery name="GetCategory" datasource="#Application.DSN#">
    Select Codevalue, CodeDesc
	  From Lookups
	  Where CodeGroup = 'FELINKCAT'
    Order By CodeValue
</cfquery>

<cfquery name="GetDioLinks" datasource="#Application.DSN#">
    Select S.*, C.CodeDesc as CatName
	From SiteLinks S, qLinkCat c
	Where c.CodeID = S.Category 
	AND S.LinkID NOT IN (#ValueList(getAllSiteLinks.SiteLinkID)#)
	Order By S.Category, S.SiteName
</cfquery>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify FaithExplorer.Org Text</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify FaithExplorer.Org Site Links">
<form name="addlink" action="Sitelinks_action.cfm?action=Add" method="POST">
	<table border="0" cellpadding="4" cellspacing="0" width="100%" style="font-family:verdana; font-size:11px;">
	   <tr bgcolor="##009900">
	       <td colspan="2"><strong>ADD LINKS</strong></td>
	   </tr>
	   <tr>
	       <td><strong>Select a Category:</strong></td>
	       <td><select name="catID">
		         <option value="">--Select One --</option>
				 <cfoutput query="GetCategory"> 
		         <option value="#GetCategory.CodeValue#">#GetCategory.CodeDesc#</option>
				 </cfoutput>
			   </select>
		   </td> 
	   </tr> 
	   <tr>
	       <td><strong>Select a Link:</strong></td>
	       <td><select name="Link">
		         <option value="">--Select One --</option>
				 <cfoutput query="GetDioLinks">
		             <option value="#GetDioLinks.LinkID#">(#GetDioLinks.CatName#) - #GetDioLinks.Sitename#</option>
			     </cfoutput> 
			   </select>
		   </td> 
	   </tr>
	   <tr>
	     <td colspan="2"><input type="submit" name="submit" value="Add Link"></td>
	   </tr>
	</table>  <br>      
</form>   
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-family:verdana; font-size:11px;">
   <tr bgcolor="#000066">
       <td><strong style="color:#ffffff;">Existing Site Links</strong></td>
   </tr>
   <cfif getAllSiteLinks.recordcount GT 0>
	   <tr>
	     <td>
		    <table border="0" cellpadding="4" cellspacing="1" width="100%" style="font-family:verdana; font-size:11px;" bgcolor="#444444">
			  <cfoutput query="getAllSiteLinks" group="CatID">
			     <tr bgcolor="##eeeeee">
					<td colspan="4"><strong>#getAllSiteLinks.CatName#</strong></td>
				 </tr>
			    <cfoutput>
			      <tr bgcolor="##ffffff">
				    <td><a href="SiteLinks_Action.cfm?action=Remove&LinkID=#getAllSiteLinks.LinkID#" style="color:##990000;">[REMOVE]</a></td>
				    <td>#getAllSiteLinks.SiteName#<br><font size="-2">#getAllSiteLinks.Description#</font></td>
					<td><a href="#getAllSiteLinks.SiteURL#" target="_blank">#getAllSiteLinks.SiteURL#</a></td>
				  </tr>
			   </cfoutput>
			  </cfoutput>
            </table>           
		 </td>
	   </tr>
   <cfelse>
      <tr>
	    <td align="center"><strong style="color:#cc0000;">You currently do not have any Links for this site</strong></td>
	  </tr>	   
   </cfif>
 </table>           
</CFMODULE>

</HTML>
