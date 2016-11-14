<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<cfparam name="url.E" default="0">

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Diocesan Resources Admin" SubTitle="Edit Resource">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
     <td valign="top" width="150"><cf_ResourceNav></td>
	 <td valign="top">&nbsp;</td>
	 <td valign="top">
	    <br>
		<p><font face="arial" size="-1">Use the form below to add diocesan resources.</font></p> 
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
		<cfelseif url.e Eq 6>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
          <tr>
            <td align="center"><font face="arial" color="##990000" size="-1"><strong>Error! You did not select a file to upload.</strong></font></td>
          </tr>
         </table> 
		</cfif>
		<cfform action="UpdateResource.cfm?action=Add" method="POST" name="editrec" enctype="multipart/form-data">
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
           <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Resource Name:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="RecLabel" size="30" maxlength="200" required="Yes" message="You must include a name for this resource"></td>
		   </tr>
		    <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
		     <td><font face="verdana" size="-1"><strong>Activate Resource:</strong></font> <input type="checkbox" name="IsActive" value="1" checked></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
		     <td><font face="verdana" size="-1"><strong>Highlight Resource on Homepage:</strong></font> <input type="checkbox" name="IsHighlight" value="1"></td>
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
			   order by codedesc
		   </cfquery>
		   <tr>
		     <td><select name="ResType">
			       <option value="">-- Select Type --</option>
				   <cfloop query="GetResType">   
				     <option value="#CodeValue#">#CodeDesc#</option>
				   </cfloop>
				 </select>
			 </td>
		   </tr>
		   <tr>
		      <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="eeeeee">
              <td><font face="verdana" size="-1"><strong>Resource File/Link:</strong></font> <font face="arial" size="-1">Add either a (1) Website Link, a (2) ListServ Email, or (3) upload a file for this resource.</font></td>
           </tr>
		     <td>
			   <table border="0" cellpadding="0" cellspacing="5">
                 <tr bgcolor="666666">
			        <td valign="top"><font face="verdana" color="ffffff" size="-2"><strong>(1) Website Link:</strong></font></td>
				 </tr>
				 <tr>	
					<td valign="top">
					   <table border="0" cellpadding="0" cellspacing="0" width="100%">
						 <tr>
						   <td><font face="verdana" size="-2">Site name: </td><td><input type="text" name="RecLinkLabel" size="25" maxlength="70"></font></td>
						 </tr>
						 <tr>
						   <td><font face="verdana" size="-2">Site Address: </td><td><input type="text" name="RecLink" size="25" maxlength="70"></font></td>
						 </tr>
					   </table>
					</td>
		         </tr> 
		         <tr bgcolor="666666">
		            <td valign="top"><font face="verdana" color="ffffff" size="-2"><strong>(2) ListServ:</strong></font></td>
				 </tr>
				 <tr>	
					<td valign="top">
					  <table border="0" cellpadding="0" cellspacing="0" width="100%">
                         <tr>
                           <td><font face="verdana" size="-2">ListServ Label: </td><td><input type="text" name="RecEmailLabel" size="25" maxlength="70"></font></td>
                         </tr>
						 <tr>
						   <td><font face="verdana" size="-2">ListServ Email: </td><td><input type="text" name="RecEmail" size="25" maxlength="70"></font></td>
						 </tr>
                      </table>
					</td>
		         </tr>  
		         <tr bgcolor="666666">
			        <td><font face="verdana" color="ffffff" size="-2"><strong>(3) File:</strong></font></td>
				</tr>
				<tr>	
					<td><input type="file" name="RecFile" size="25"></td>
		         </tr>
               </table>
			 </td>
		   </tr>    
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
				     <option value="#CodeValue#">#CodeDesc#</option>
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
				     <option value="#CodeValue#">#CodeDesc#</option>
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
		     <td><textarea cols="50" rows="15" name="ResDesc" wrap="virtual"></textarea></td>
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
		     <td><cfinput type="text" name="ContactName" size="30" maxlength="80"></td>
		   </tr>
		   <tr>
              <td><font face="verdana" size="-1"><strong>Contact Email:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="ContactEmail" size="30" maxlength="80"></td>
		   </tr>
		   <tr>
              <td><font face="verdana" size="-1"><strong>Contact Phone Number:</strong></font></td>
           </tr>
		   <tr>
		     <td><cfinput type="text" name="ContactPhone" size="30" maxlength="80"></td>
		   </tr>
		   <tr>
		     <td>&nbsp;</td>
		   </tr>
		   <tr>
		     <td><input type="reset" name="reset" value="Clear">&nbsp;&nbsp;<input type="submit" name="submit" value="Add Resource >>"></td>
		   </tr>
        </table>
		</cfform>
		</cfoutput>
		
     </td>
   </tr>
</table>
</CFMODULE>