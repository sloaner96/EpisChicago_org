<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="GetSubsites" datasource="#Application.dsn#" cachedwithin="#CreateTimespan(0,0,5,0)#">
Select G.*, L.CodeDesc, L.Ranking 
  From GroupNfo G, Lookups L
  where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE' 
  Order by G.GroupType, L.Ranking
</cfquery>

<cfquery name="GetGroupContent" datasource="#Application.dsn#">
  Select Distinct GroupID
  From GroupContent
  Order By GroupID
</cfquery>

<cfquery name="GetDepts" datasource="#Application.dsn#">
  Select *
  From Lookups
  Where CodeGroup= 'DEPTS'
</cfquery>

<cfquery name="GetGroupType" datasource="#Application.dsn#">
  Select *
  From Lookups
  Where CodeGroup= 'GROUPTYPE'
  Order By Ranking
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Subsite Admin" SubTitle="">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td width="200" valign="top">
	    <cf_sidenav>
	 </td>
	 <td width="1" bgcolor="#000000"></td> 
	 <td valign="top">
	  <cfform name="groupinfo" action="AddGroup.cfm?action=ADD" method="POST" enctype="multipart/form-data">
	    <table border="0" cellpadding="4" cellspacing="0" width="100%">
          <tr>
            <td><font color="#003399" size="+1" face="Arial, Verdana, Helvetica, sans-serif"><strong>Add a New Subsite</strong></font></td>
          </tr>
		  <cfif url.e NEQ 0>
		    <tr>
			  <td align="center"><font face="verdana" color="990000" size="-1"><strong>Error! The following error occurred while adding this subsite, You must correct this error and re-enter all the info for this subsite.</strong></font></td>
			</tr>
		    <tr>
			  <td align="center">
			    <cfif url.e EQ 1>
				 <font face="verdana" color="990000" size="-1">You must include a group name for this subsite or select a department.</font>
				<cfelseif url.e EQ 2>
				 <font face="verdana" color="990000" size="-1">You must select a group type for this subsite.</font>
				<cfelseif url.e EQ 3>
				 <font face="verdana" color="990000" size="-1">You must enter a group purpose/description for this subsite.</font>
				<cfelseif url.e EQ 4>
				<font face="verdana" color="990000" size="-1">The system encountered an error, while uploading your photo, please try again.</font>
				<cfelseif url.e EQ 5>
				<font face="verdana" color="990000" size="-1">The Group name you entered for this subsite, already exists. Please choose another name for this subsite.</font>
				<cfelseif url.e EQ 6>
				<font face="verdana" color="990000" size="-1">The Department/Office you choose, already has a subsite, please choose another Dapartment.</font>
				</cfif> 
			  </td>
			</tr>
		  </cfif>
		  <tr>
			<td><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"><strong>Site Information:</strong></font></td>
		  </tr>				
		  <tr>
			<td>
			   <table border="0" cellpadding="2" cellspacing="0">
			      <tr bgcolor="eeeeee">
				     <td><font face="Verdana" <cfif url.e EQ 1 OR url.e EQ 5 OR url.e EQ 6>color="990000"</cfif> size="-2">GROUP NAME: (Enter a name in the box below or select a department)</font></td>
				  </tr>
				  <tr>
				    <td><cfinput type="text" name="GroupName" value="" size="50" maxlength="80"><br>
					    <font face="Verdana" size="-2"><strong>Department/Office</strong></font><br>			
					    <select name="Dept">
						   <option value=""></option>
						   <cfoutput query="GetDepts">
						     <option value="#CodeID#">#Left(CodeDesc, 30)#<cfif len(codedesc) GT 30>...</cfif></option>
						   </cfoutput>
						</select>
					</td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				   <tr bgcolor="eeeeee">
					<td><font size="-2" <cfif url.e EQ 2>color="990000"</cfif> face="Verdana">WHAT TYPE OF SITE IS THIS?:</font> 
					</td>
				  </tr>
				  <tr>
				    <td><select name="SiteType">
					       <option value="">--- Select One ---</option>
						   <cfoutput query="GetGroupType">
						     <option value="#CodeValue#">#Left(CodeDesc, 30)#<cfif len(codedesc) GT 30>...</cfif></option>
						   </cfoutput>
					    </select>
				    </td>
				  </tr>
                  <!--- Removed so that the admin must add one member to a site, before the site can be active 				  
				   <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">ACTIVATE SITE: <input type="checkbox" name="IsSiteActive" value="1"> <strong>YES</strong></font></td>
				  </tr> --->
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">SHOW ALL MEMBERS ON HOMEPAGE: <input type="checkbox" name="ShowMembers" value="1"> <strong>YES</strong></font></td>
				  </tr>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">DISPLAY ON DIOCESAN HOMEPAGE: <input type="checkbox" name="ShowOnHomepage" value="1"> <strong>YES</strong></font></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
				     <td><font face="Verdana" <cfif url.e EQ 3>color="990000"</cfif> size="-2">GROUP PURPOSE/DESCRIPTION</font></td>
				  </tr>
				  <tr>
					 <td><textarea name="GroupPurpose" cols="36" rows="6" wrap="virtual"></textarea></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
				     <td><font face="Verdana" <cfif url.e EQ 4>color="990000"</cfif> size="-2">UPLOAD PAGE PHOTO: The photo will be added to the right navigation of the site.</font></td>
				  </tr>
				  <tr>
				    <td><input name="GroupPhoto" type="file" size="20"></td>
				  </tr> 
			   </table>
			</td>
		  </tr>
		  <tr>
			<td><hr size=1 noshade></td>
		  </tr>
		  <cfquery name="GetContentTypes" datasource="#Application.dsn#">
		    Select *
		    From Lookups 
		    Where CodeGroup = 'CONTENT'
		    Order by codevalue
		  </cfquery>
		  <tr>
			<td><a name="content"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"><strong>Site Content:</strong></font></a></td>
		  </tr>
		  <tr>
			<td>
			  <table border="0" cellpadding="3" cellspacing="1">
			    <tr bgcolor="eeeeee">
				  <td></td>
				  <td><font face="Verdana" size="-2">DEFAULT LABEL</font></td>
				  <td align="center"><font face="Verdana" size="-2">SITE LABEL</font></td>
				  <td align="center"><font face="Verdana" size="-2">CONTENT RANKING</font></td>
				</tr>
				<cfoutput query="GetContentTypes">
				  <tr>
					 <td><input type="checkbox" name="ContentType" value="#GetContentTypes.CodeValue#"></td>
					 <td><font face="verdana" size="-2"><strong>#GetContentTypes.CodeDesc#</strong></font></td>
					 <td><input type="text" name="ContentLabel_#GetContentTypes.CodeValue#" value="" size="15" maxlength="15" style="font-size:12px;"></td>
					 <td><select name="contentRank_#GetContentTypes.CodeValue#">
					         <cfloop index="i" from="1" to="#GetContentTypes.recordcount#">    
							    <option value="#i#" <cfif GetContentTypes.currentrow EQ i>Selected</cfif>>#i#</option>
						     </cfloop>
						 </select>
					 </td>
				  </tr>
				</cfoutput>
				<tr>
				  <td colspan="3"><input type="submit" name="submit" value="Save Content"></td>
				</tr>
			  </table>
			</td>
		  </tr>
		 </cfform>
        </table>
	 </td>
  </tr>
</table>

</CFMODULE>

</HTML>
