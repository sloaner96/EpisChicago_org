
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>


<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin: Goals" SubTitle="Main Menu">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td width="150" valign="top"><cf_sidenav></td>
   <td valign="top">
      <table border="0" cellpadding="0" cellspacing="0" width="100%">
         <tr>
            <td><font face="arial" size="-1">Use the form below to Add a new Initiative to a goal in the Strategic Plan.</font></td>
         </tr>
		 <tr>
		   <td><hr noshade size=1></td>
		 </tr>
		 <tr>
		   <td>
		     <cfform action="UpdateInit.cfm?action=ADD" method="POST" name="addgoal" enctype="multipart/form-data">
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
							  <cfoutput query="GetGoals">
							  <option value="#GetGoals.GoalID#">Goal #GetGoals.GoalNbr# - #Left(GetGoals.Label, 12)#<cfif Len(GetGoals.Label) GT 12>...</cfif></option>
							  </cfoutput>
							</select>
						</td>
	                 </tr>
	                 <tr>
	                    <td><font face="verdana" size="-2"><strong>Initiative Label:</strong></font></td>
						<td><cfinput type="Text" name="label" message="You must enter a Initiative label" required="Yes" size="50" maxlength="200"></td>
	                 </tr>
					 <tr>
					   <td><font face="verdana"  size="-2"><strong>Add Photo:</strong></font></td>
					   <td><input type="file" name="Initimg" size="25"></td>
					 </tr>
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
							  <cfoutput query="GetPhotoAlb">
							  <option value="#GetPhotoAlb.AlbumID#">#GetPhotoAlb.AlbName#</option>
							  </cfoutput>
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
						<td colspan=2><textarea cols="55" rows="15" name="Desc"></textarea></td>
	                 </tr>
					 <tr>
					   <td>&nbsp;</td>
					 </tr>
					 <tr>
					   <td colspan=2 align="center"><input type="submit" name="submit" value="Add Initiative >>"></td>
					 </tr>
	             </table>
			 </cfform>
		   </td>
		 </tr>
      </table>
   </td>
  </tr>
</table>

</CFMODULE>