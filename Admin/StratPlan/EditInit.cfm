
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Goals" SubTitle="Main Menu">
<cfquery name="GetInit" datasource="#Application.dsn#">
  Select I.*,
    (Select Max(Ranking)
	  From Initiatives
	  Where GoalID = I.GoalID) as MaxRanking
  From Initiatives I
  Where InitID = #url.InitID#
  Order By I.GoalID, I.Ranking
</cfquery>

 <cfif GetInit.MaxRanking NEQ "">
     <cfset NextRank = GetInit.MaxRanking + 1>
 <cfelse>
    <cfset NextRank = 1>
 </cfif>	
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
            <td><font face="arial" size="-1">Use the form below to Edit this initiative.</font></td>
         </tr>
		 <tr>
		   <td><hr noshade size=1></td>
		 </tr>
		 <cfoutput query="GetInit">
		  
		 <tr>
		   <td>
		     <cfform action="UpdateInit.cfm?Action=update" method="POST" name="addgoal" enctype="multipart/form-data">
			    <input type="hidden" name="initID" value="#GetInit.InitID#">
				 <table border="0" cellpadding="3" cellspacing="0">
	                 <cfquery name="GetGoals" datasource="#Application.dsn#">
						  Select G.*
						  From Goals G
						  Where Active = True
						  Order By GoalNbr
						</cfquery>
					 <tr>
	                    <td><font face="verdana" size="-2"><strong>Goal:</strong></font></td>
						<td><select name="GoalID">
						      <option value="">-- Select a Goal --</option>
							  <cfloop query="GetGoals">
							  <option value="#GetGoals.GoalID#" <cfif GetInit.GoalID EQ GetGoals.GoalID>Selected</cfif>>Goal #GetGoals.GoalNbr# - #Left(GetGoals.Label, 12)#<cfif Len(GetGoals.Label) GT 12>...</cfif></option>
							  </cfloop>
							</select>
						</td>
	                 </tr>
					
	                 <tr>
	                    <td><font face="verdana" size="-2"><strong>Initiative Label:</strong></font></td>
						<td><cfinput type="Text" name="label" message="You must enter a Initiative label" value="#GetInit.Label#" required="Yes" size="50" maxlength="200"></td>
	                 </tr>
					 <tr>
	                    <td><font face="verdana" size="-2"><strong>Date Completed:</strong></font></td>
						<td><cfinput type="Text" name="DateComplete" value="#DateFormat(GetInit.CompletedOn, 'MM/DD/YYYY')#" size="15" maxlength="15" validate="date"></td>
	                 </tr>
					 
					 <tr>
					   <td><font face="verdana"  size="-2"><strong>Add New Photo:</strong></font></td>
					   <td><input type="file" name="Initimg" size="25"></td>
					 </tr>
					 <cfif GetInit.ImgPath NEQ "">
					   <tr>
					     <td>&nbsp;</td>
					   </tr>
					   <tr>
					     <td><font face="verdana"  size="-2"><strong>Existing Photo:</strong></font></td>
					     <td><img src="/images/subsite/#GetInit.ImgPath#" height="50" width="50" border="0" alt=""></td>
					   </tr>
					 </cfif>
					 <tr>
					   <td>&nbsp;</td>
					 </tr>
					 <cfquery name="GetPhotoAlb" datasource="#Application.DSN#">
					   Select AlbumID, AlbName
					   From Album
					   Where Showable = True
					   Order BY AlbName
					 </cfquery>
					 <tr>
	                    <td><font face="verdana" size="-2"><strong>Select a Photo Album:</strong></font></td>
						<td><select name="AlbumID">
						      <option value="">-- Select a Album --</option>
							  <cfloop query="GetPhotoAlb">
							  <option value="#GetPhotoAlb.AlbumID#" <cfif GetInit.AlbumID EQ GetPhotoAlb.AlbumID>Selected</cfif>>#GetPhotoAlb.AlbName#</option>
							  </cfloop>
							</select>
						</td>
	                 </tr>
					 <tr>
					   <td>&nbsp;</td>
					 </tr>
					  <tr>
	                    <td><font face="verdana" size="-2"><strong>Initiative Ranking:</strong></font></td>
						<td><select name="Ranking">
							  <cfloop index="i" from="1" to="#nextRank#">
							  <option value="#i#" <cfif i EQ GetInit.Ranking>Selected</cfif>>#i#</option>
							  </cfloop>
							</select>
						</td>
	                 </tr>
					 <tr>
					   <td>&nbsp;</td>
					 </tr>
					 <tr>
					   <td colspan=2><font face="verdana" size="-2"><strong>Initiative Description:</strong></font></td>
					 </tr>
					 <tr>
						<td colspan=2><textarea cols="55" rows="15" name="Desc">#GetInit.Description#</textarea></td>
	                 </tr>
					 <tr>
					   <td>&nbsp;</td>
					 </tr>
					 <tr>
					   <td colspan=2 align="center"><input type="submit" name="submit" value="Update Initiative >>"></td>
					 </tr>
	             </table>
			 </cfform>
		   </td>
		 </tr>
		</cfoutput> 
      </table>
   </td>
  </tr>
</table>

</CFMODULE>