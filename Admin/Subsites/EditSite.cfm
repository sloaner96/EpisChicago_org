<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
		<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="GetSubsites" datasource="#Application.dsn#">
  Select G.*, L.CodeDesc, L.Ranking 
  From GroupNfo G, Lookups L
  where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE' 
  Order by G.GroupType, L.Ranking
</cfquery>

<cfquery name="GetGroupInfo" datasource="#Application.dsn#">
  Select G.*, L.CodeDesc, L.Ranking 
  From GroupNfo G, Lookups L
  where G.GroupType = L.CodeValue
  AND L.CodeGroup = 'GROUPTYPE' 
  AND G.GroupID = #Url.GroupID#
  Order by G.GroupType, L.Ranking
</cfquery>


<cfquery name="GetDepts" datasource="#Application.dsn#" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
  Select *
  From Lookups
  Where CodeGroup= 'DEPTS'
</cfquery>

<cfquery name="GetGroupType" datasource="#Application.dsn#" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
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
<!--- Removed Per Rick's Request	   
      <cfoutput>
	    <form name="removesite" action="AddGroup.cfm?action=Confirm&groupID=#URL.GroupID#" method="POST">
	      <table border="0" cellpadding="4" cellspacing="0" width="100%">
		    <tr>
               <td colspan=2><font color="##003399" size="+1" face="Arial, Verdana, Helvetica, sans-serif"><strong>Edit Group Subsite</strong></font></td>
            </tr>
            <tr>
			  <td>&nbsp;</td> 
		      <td><font color="##CC0000" size="-1" face="Arial, Helvetica, sans-serif"><strong>REMOVE THIS SUBSITE?</strong>&nbsp;<input type="checkbox" name="deleteSite" value="1" onClick="this.form.submit();"></font></td>
		   </tr>   
        </table>
	   </form> 	
	  </cfoutput> --->
	  <cfform name="groupinfo" action="AddGroup.cfm?action=Update" method="POST" enctype="multipart/form-data">
	     <cfoutput>
		   <input type="hidden" name="groupid" value="#url.groupID#">
	    <table border="0" cellpadding="4" cellspacing="0" width="100%">
		  <tr>
			<td><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"><strong>Site Information:</strong></font></td>
		  </tr>				
		  <cfif url.e NEQ 0>
		    <tr>
			  <td align="center"><font face="verdana" color="990000" size="-1"><strong>Error! The following error occurred while updating this subsite, You must correct this error and re-enter all the info for this subsite.</strong></font></td>
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
			<td>
			   <table border="0" cellpadding="2" cellspacing="0">
			      <tr bgcolor="eeeeee">
				     <td><font face="Verdana" size="-2">GROUP NAME: (Enter a name in the box below or select a department)</font></td>
				  </tr>
				  <tr>
				    <td><cfinput type="text" name="GroupName" value="#trim(GetGroupInfo.GroupName)#" size="50" maxlength="80"><br>
					    <font face="Verdana" size="-2"><strong>Department/Office</strong></font><br>				     
						 <select name="Dept">
						   <option value=""></option>
						   <cfloop query="GetDepts">
						     <option value="#CodeID#" <cfif GetGroupInfo.GroupType EQ "D"><cfif GetGroupInfo.DeptID EQ GetDepts.CodeID>Selected</cfif></cfif>>#Left(CodeDesc, 30)#<cfif len(codedesc) GT 30>...</cfif></option>
						   </cfloop>
						</select>
					</td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				   <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">WHAT TYPE OF SITE IS THIS?:</font> 
					</td>
				  </tr>
				  <tr>
				    <td><select name="SiteType">
					       <option value="">--- Select One ---</option>
						   <cfloop query="GetGroupType">
						     <option value="#CodeValue#" <cfif GetGroupInfo.GroupType EQ GetGroupType.Codevalue>Selected</cfif>>#Left(CodeDesc, 30)#<cfif len(codedesc) GT 30>...</cfif></option>
						   </cfloop>
					    </select>
				    </td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <cfquery name="MemberCount" datasource="#Application.dsn#">
				     Select Count(*) as NumberMembers
					 From GrpMembers
					 Where GroupID = #GroupID#
				  </cfquery>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">ACTIVATE SITE: <cfif MemberCount.NumberMembers GT 0><input type="checkbox" name="IsSiteActive" value="1" <cfif GetGroupInfo.IsActive EQ 1>Checked</cfif>> <strong>YES</strong><cfelse><strong><font color="cc0000">YOU MUST ADD AT LEAST ONE MEMBER TO ACTIVATE THIS SITE</font></strong></cfif></font></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">SHOW ALL MEMBERS ON HOMEPAGE: <input type="checkbox" name="ShowMembers" value="1" <cfif GetGroupInfo.ShowMembers EQ 1>Checked</cfif>> <strong>YES</strong></font></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">DISPLAY ON DIOCESAN HOMEPAGE: <input type="checkbox" name="ShowOnHomepage" value="1" <cfif GetGroupInfo.HomePageDisplay EQ 1>Checked</cfif>> <strong>YES</strong></font></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
				     <td><font face="Verdana" size="-2">GROUP PURPOSE/DESCRIPTION</font></td>
				  </tr>
				  <tr>
					 <td><textarea name="GroupPurpose" cols="50" rows="6">#trim(GetGroupInfo.Purpose)#</textarea></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr bgcolor="eeeeee">
				     <td><font face="Verdana" size="-2"><cfif GetGroupInfo.ImgName NEQ "">CHANGE PAGE PHOTO<cfelse>ADD PHOTO</cfif>: The photo will be added to the right navigation of the site.</font></td>
				  </tr>
				  <cfif GetGroupInfo.ImgName NEQ "">
				  <tr>
				    <td><font face="Verdana" size="-2"><strong>Current Photo:</strong></font> <img src="/images/subsite/#GetGroupInfo.ImgName#" width="50" height="50" border="0"></td>
				  </tr>
				  </cfif>
				  <tr>
				    <td><input name="GroupPhoto" type="file" size="20"></td>
				  </tr> 
			   </table>
			</td>
		  </tr>
		  <tr>
			<td><hr size=1 noshade></td>
		  </tr>
		  <cfquery name="ThisGroupsContent" datasource="#Application.dsn#">
		     Select C.*, L.CodeDesc
		     From GroupContent C, Lookups L
		     Where C.ContentCode = L.CodeValue
			 AND L.CodeGroup = 'CONTENT'
			 AND C.GroupID = #url.GroupID#
			 Order By RankOrder
		  </cfquery>
		  
		  <cfquery name="GetContentTypes" datasource="#Application.dsn#">
		    Select *
		    From Lookups 
		    Where CodeGroup = 'CONTENT'
			<cfif ThisGroupsContent.recordcount GT 0>
			AND CodeValue NOT IN (#QuotedValueList(ThisGroupsContent.ContentCode, ",")#)
			</cfif>
		    Order by Ranking, CodeValue ASC
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
				  <td align="center"><font face="Verdana" size="-2">SITE LABEL</td>
				  <td align="center"><font face="Verdana" size="-2">CONTENT ORDER</font></td>
				  <td><font face="Verdana" size="-2">MANAGE CONTENT</font></td>
				</tr>
				<!--- First Loop Through and SHow me Content on the SIte Currently --->
				<cfloop query="ThisGroupsContent">
				   <cfif ThisGroupsContent.MenuName NEQ "">
				      <cfset ContentLabel = ThisGroupsContent.MenuName>
				   <cfelse>
				      <cfset ContentLabel = "">	  
				   </cfif>
				   
				  <tr>
					 <td><input type="checkbox" name="ContentType" value="#ThisGroupsContent.ContentCode#" <cfif ThisGroupsContent.recordcount GT 0>Checked</cfif>></td>
					 <td><font face="verdana" size="-2"><strong>#ThisGroupsContent.CodeDesc#</strong></font></td>
					 <td><input type="text" name="ContentLabel_#ThisGroupsContent.ContentCode#" value="#Trim(ContentLabel)#" size="15" maxlength="15" style="font-size:12px;"></td>
				     <td align="center"><select name="contentRank_#ThisGroupsContent.ContentCode#">
					         <cfloop index="i" from="1" to="#ThisGroupsContent.recordcount#">    
							    <option value="#i#" <cfif ThisGroupsContent.RankOrder EQ i>Selected</cfif>>#i#</option>
						     </cfloop>
						 </select>
					 </td>
					 <td align="center"><cfif ThisGroupsContent.recordcount GT 0><a href="ManageContent.cfm?Ctype=#ThisGroupsContent.ContentCode#&GroupID=#GetGroupInfo.GroupID#"><font face="verdana" size="-2">[Edit]</font></a></cfif></td>
				     
				  </tr>
				</cfloop>
				<cfset StartLoop = ThisGroupsContent.recordcount + 1>	
				<cfset toLoop =  ThisGroupsContent.recordcount + GetContentTypes.recordcount>
				<!--- Now Loop Through Unchosen available Content --->
				<cfloop query="GetContentTypes">

				  <tr>
					 <td><input type="checkbox" name="ContentType" value="#GetContentTypes.CodeValue#"></td>
					 <td><font face="verdana" size="-2"><strong>#GetContentTypes.CodeDesc#</strong></font></td>
					 <td><input type="text" name="ContentLabel_#GetContentTypes.CodeValue#" value="" size="15" maxlength="15" style="font-size:12px;"></td>
				     <td align="center"><select name="contentRank_#GetContentTypes.CodeValue#">
				               <option value="0">-</option>		
							      
						         <cfloop index="i" from="#StartLoop#" to="#toLoop#">    
								    <option value="#i#" <cfif GetContentTypes.currentrow EQ i>Selected</cfif>>#i#</option>
							     </cfloop>
						 </select>
					 </td>
					 <td>&nbsp;</td>
				     
				  </tr>
				</cfloop>
			  </table>
			</td>
		  </tr>
		  <tr>
		    <td ><input type="submit" name="submit" value="Update Content >>"></td>
		  </tr>
		</table> 
	   </cfoutput>
      </cfform>
	 </td>
  </tr>
</table>

</CFMODULE>

</HTML>

</body>
</html>
