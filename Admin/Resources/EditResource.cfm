<cfparam name="url.ResID" default="0">
<cfparam name="url.E" default="0">
<cfquery name="GetRes" datasource="#Application.dsn#" >
  Select R.*,
    (Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.Category
	   AND CodeGroup = 'RECCAT') as CatName,
	(Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.SubCategory
	   AND CodeGroup = 'RECSUBCAT') as SubCatName,
	(Select CodeDesc 
	   From Lookups
	   Where CodeValue = R.ResourceType
	   AND CodeGroup = 'RECCONTENT') as RecTypeName
  From Resources R
  where R.ResourceID = #url.ResID#
  Order by 3, R.ResourceLabel 
</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Diocesan Resources Admin" SubTitle="Edit Resource">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
     <td valign="top" width="150"><cf_ResourceNav></td>
	 <td valign="top">&nbsp;</td>
	 <td valign="top">
	    <br>
		<p><font face="arial" size="-1">Use the form below to edit diocesan resources.</font></p> 
		<hr noshade size=1>
		<cfoutput>
		<cfif Url.E EQ 1>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td align="center"><font face="arial" color="##990000" size="-1"><strong>Error! You did not include a label for this resource.</strong></font></td>
          </tr>
         </table>
		<cfelseif url.e Eq 2>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td align="center"><font face="arial" color="##990000" size="-1"><strong>Error! You did not select a type for this resource.</strong></font></td>
          </tr>
         </table>
		<cfelseif url.e Eq 3>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td align="center"><font face="arial" color="##990000" size="-1"><strong>Error! You did not select a category for this resource.</strong></font></td>
          </tr>
         </table>
		<cfelseif url.e Eq 4>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td align="center"><font face="arial" color="##990000" size="-1"><strong>Error! You did not specify a label or an address for the link.</strong></font></td>
          </tr>
         </table>
		<cfelseif url.e Eq 5>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td align="center"><font face="arial" color="##990000" size="-1"><strong>Error! You did not specify a label or an address for this listserv.</strong></font></td>
          </tr>
         </table>
		</cfif>
		<cfform action="UpdateResource.cfm?action=Update" method="POST" name="editrec" enctype="multipart/form-data">
		<input type="hidden" name="ResourceID" value="#GetRes.resourceID#">
		<input type="hidden" name="CurrentRecType" value="#GetRes.ResourceType#">
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
           <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Resource Name:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="RecLabel" value="#GetRes.ResourceLabel#" size="30" maxlength="200" required="Yes" message="You must include a name for this resource"></td>
		   </tr>
		    <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
		     <td><font face="verdana" size="-1"><strong>Active Resource:</strong></font> <input type="checkbox" name="IsActive" value="1" <cfif GetRes.Active is true>Checked</cfif>></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
		     <td><font face="verdana" size="-1"><strong>Highlight Resource on Homepage:</strong></font> <input type="checkbox" name="IsHighlight" value="1" <cfif GetRes.Highlight is true>Checked</cfif>></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Type of Resource :</strong></font></td>
           </tr>
		   <cfquery name="GetResType" datasource="#application.dsn#">
		     Select *
			   From Lookups
			   Where CodeGroup = 'RECCONTENT'
			   AND CodeValue = '#getRes.Resourcetype#'
		   </cfquery>
		   <input type="hidden" name="ResType" value="#getRes.Resourcetype#">
		   <tr>
		     <td><font face="verdana" size="-1">#GetResType.CodeDesc#</font></td>
		   </tr>
		    <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Edit Resource File/Link:</strong></font></td>
           </tr>
		    <cfif GetRes.ResourceType EQ "L" > 
				  <cfquery name="GetResource" datasource="#Application.dsn#">
				    Select *
					From SiteLinks
					Where LinkID = #GetRes.ContentID#
				  </cfquery>
				<tr>
				  <td><font face="verdana" size="-2"><strong>Current Website Resource:</strong> #GetResource.SiteName# <a href="#GetResource.SiteURL#" target="_blank">#GetResource.SiteURL#</a></font></td>
				</tr> 
				<tr>
				  <td><font face="verdana" size="-2"><strong>Update Website Name:</strong></font> <input type="text" name="RecLinkLabel" size="25" value="#GetResource.SiteName#" maxlength="70"></td>
				</tr> 
				<tr>
				  <td><font face="verdana" size="-2"><strong>Update Website Resource:</strong></font> <input type="text" name="RecLink" size="25" value="#GetResource.SiteURL#" maxlength="70"></td>
				</tr> 
			<cfelseif getRes.ResourceType EQ "S">
			    <cfquery name="GetResource" datasource="#Application.dsn#">
				    Select *
					From ListServs
					Where ListID = #GetRes.ContentID#
				  </cfquery>
                <tr>
				  <td><font face="verdana" size="-2"><strong>Current ListServ:</strong> <a href="mailto:#GetResource.EmailAddr#">#GetResource.EmailAddr#</a></font></td>
				</tr> 
				<tr>
				  <td><font face="verdana" size="-2"><strong>Update ListServ Name:</strong></font> <input type="text" name="RecEmailLabel" size="25" value="#GetResource.Label#" maxlength="70"></td>
				</tr> 
				<tr>
				  <td><font face="verdana" size="-2"><strong>Update ListServ:</strong></font> <input type="text" name="RecEmail" size="25" value="#GetResource.EmailAddr#" maxlength="70"></td>
				</tr>  
			<cfelse>
			  	  <cfquery name="GetResource" datasource="#Application.dsn#">
				    Select *
					From Forms
					Where FormID = #GetRes.ContentID#
				  </cfquery>
                <tr>
				  <td><font face="verdana" size="-2"><strong>Current File:</strong> <a href="/Forms#GetResource.FileName#" target="_blank">#GetResource.FileName#</a></font> </td>
				</tr> 
				<tr>
				  <td><font face="verdana" size="-2"><strong>Update File:</strong></font> <input type="file" name="RecFile" size="25"></td>
				</tr>    
			</cfif>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Resource Category:</strong></font></td>
           </tr>
		   <cfquery name="GetCat" datasource="#application.dsn#">
		     Select *
			   From Lookups
			   Where CodeGroup = 'RECCAT'
			   order by codedesc
		   </cfquery>
		   <tr>
		     <td><select name="CatID">
			       <option value="">-- Select Category --</option>
				   <cfloop query="GetCat">   
				     <option value="#CodeValue#" <cfif GetRes.Category EQ GetCat.CodeValue>Selected</cfif>>#CodeDesc#</option>
				   </cfloop>
				 </select>
			 </td>
		   </tr>
		    <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Resource Sub-Category:</strong></font></td>
           </tr>
		   <cfquery name="GetSubCat" datasource="#application.dsn#">
		     Select *
			   From Lookups
			   Where CodeGroup = 'RECSUBCAT'
			   order by codedesc
		   </cfquery>
		   <tr>
		     <td><select name="SubCatID">
			       <option value="">-- Select SubCategory --</option>
				   <cfloop query="GetSubCat">   
				     <option value="#CodeValue#" <cfif GetRes.SubCategory EQ GetSubCat.CodeValue>Selected</cfif>>#CodeDesc#</option>
				   </cfloop>
				 </select>
			 </td>
		   </tr>
		    <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Resource Description:</strong></font></td>
           </tr>
		   <tr>
		     <td><textarea cols="50" rows="15" name="ResDesc" wrap="virtual">#GetRes.Desc#</textarea></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr>
		     <td><font face="arial" color="navy" size="+1"><strong>Resource Contact Info:</strong></font></td>
		   </tr>
		   <tr>
              <td><font face="verdana" size="-1"><strong>Contact Name:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="ContactName" value="#GetRes.ContactName#" size="30" maxlength="80"></td>
		   </tr>
		   <tr>
              <td><font face="verdana" size="-1"><strong>Contact Email:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="ContactEmail" value="#GetRes.ContactEmail#" size="30" maxlength="80"></td>
		   </tr>
		   <tr>
              <td><font face="verdana" size="-1"><strong>Contact Phone Number:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="ContactPhone" value="#GetRes.ContactPhone#" size="30" maxlength="80"></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr>
		     <td><input type="submit" name="submit" value="Update Resource Info >>"></td>
		   </tr>
        </table>
		</cfform>
		</cfoutput>
		
     </td>
   </tr>
</table>
</CFMODULE>