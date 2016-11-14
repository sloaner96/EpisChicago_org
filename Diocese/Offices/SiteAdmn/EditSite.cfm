<cfif Not IsDefined("session.subuserID")>
  <cflocation url="index.cfm?GroupID=#url.groupID#">
</cfif>
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

<CFMODULE Template="#Application.Header#" PageTitle="Subsite Admin" SubTitle="">


<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
     <td width="200" valign="top">
	   <cf_sidenav>
	 </td>
	 <td width="1" bgcolor="#000000"></td> 
	 <td valign="top"> 
	  <cfform name="groupinfo" action="AddGroup.cfm?action=Update" method="POST" enctype="multipart/form-data">
	     <cfoutput>
		   <input type="hidden" name="groupid" value="#url.groupID#">
	    <table border="0" cellpadding="4" cellspacing="0" width="100%">
		  <tr>
			<td><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"><strong>Manage #GetGroupInfo.GroupName#</strong></font></td>
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
				<font face="verdana" color="990000" size="-1">The Department you choose, already has a subsite, please choose another Dapartment.</font>
				</cfif> 
			  </td>
			</tr>
		  </cfif>
		  <tr>
			<td>
			   <table border="0" cellpadding="2" cellspacing="0">
			   <input type="hidden" name="SiteType" value="#GetGroupInfo.GroupType#">
			    <cfif GetGroupInfo.GroupType EQ "D"><input type="hidden" name="Dept" value="#GetGroupInfo.DeptID#"></cfif>
				  <tr bgcolor="eeeeee">
					<td><font size="-2" face="Verdana">SHOW ALL MEMBERS ON HOMEPAGE: <input type="checkbox" name="ShowMembers" value="1" <cfif GetGroupInfo.ShowMembers EQ 1>Checked</cfif>> <strong>YES</strong></font></td>
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
                 <!--- Removed Per Rick Peete 	
				  <tr bgcolor="eeeeee">
				     <td><font face="Verdana" size="-2"><cfif GetGroupInfo.ImgName NEQ "">CHANGE PAGE PHOTO<cfelse>ADD PHOTO</cfif>: The photo will be added to the right navigation of the site. Photos must be 250 pixels wide.</font></td>
				  </tr>
				  <cfif GetGroupInfo.ImgName NEQ "">
				  <tr>
				    <td><font face="Verdana" size="-2"><strong>Current Photo:</strong></font> <img src="/images/subsite/#GetGroupInfo.ImgName#" width="50" height="50" border="0"></td>
				  </tr>
				  </cfif>
				  <tr>
				    <td><input name="GroupPhoto" type="file" size="20"></td>
				  </tr>  --->
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
			AND CodeValue NOT IN (#QuotedValueList(ThisGroupsContent.ContentCode, ",")#)
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
				  <td align="center"><font face="Verdana" size="-2">CONTENT RANKING</font></td>
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
