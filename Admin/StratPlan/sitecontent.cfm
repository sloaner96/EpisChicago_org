<cfparam name="url.e" default="0">

	<cfquery name="GetContent" datasource="#Application.dsn#">
	   Select *,
	     (Select Count(*) 
		   from Pagetext
		   Where PSection = P.PSection
		   AND ImgName IS NOT NULL) as ImgExists  
	   From Pagetext P
	   where P.PSection = '1'
	   order by P.ranking
	</cfquery>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
	<style type="text/css">
	 .normaltext{
	     font-family: verdana, arial, times new roman;
		 font-size: 12px;
	 }
	</style>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Strategic Plan Admin" SubTitle="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
  <td width="150" valign="top"><cf_sidenav></td>
  <td valign="top">
		<div align="center">
		<p><font face="arial" size="-1">Use the form below to maintain strategic plan content. If you have an image to include with the section, use the "Browse" button to locate it on your hard drive.  Note that the image should not be larger than 275 pixels and you may upload only 1 image per section.</font></p>
		<cfoutput>
		<table border=0 cellspacing=1 cellpadding=4>
		<tr>
		  <td colspan=2><hr noshade size=2></td>
		</tr>
		<cfform action="sitecontent_Update.cfm?action=Addphoto" method="POST" name="PhotoContent" enctype="multipart/form-data">
		    <input type="hidden" name="section" value="1">
			<cfif GetContent.ImgExists GT 0>
				<tr>
				  <td colspan=2><font face="verdana" size="-1"><strong>Current Image:</strong></font> <a href="/images/#GetContent.ImgName#" target="_blank"><img src="/images/#GetContent.ImgName#" height="50" width="50" border="0"></a></td>
				</tr>
				<tr>
					<td align=left><font face="Verdana,Arial" size="-1"><b>Add Section Image:</b></font> </td>
					<td align=left><input type="file" name="FileContents" size="30" accept="image/jpeg,image/gif"></td>
				</tr>
				<tr>
				  <td><input type="Submit" name="Submit" value="Update Photo >>"></td>
				</tr>
			<cfelseif GetContent.recordcount GTE 1 OR GetContent.ImgExists EQ 0>
				<tr>
					<td align=left><font face="Verdana,Arial" size="-1"><b>Add Section Image:</b></font> </td>
					<td align=left><input type="file" name="FileContents" size="30" accept="image/jpeg,image/gif"></td>
				</tr>
				<tr>
				  <td><input type="Submit" name="Submit" value="Add Photo >>"></td>
				</tr>
			</cfif> 
		</cfform>
		<tr>
		  <td colspan=2>&nbsp;</td>
		</tr>
		
		<cfif url.e EQ 1>
			<tr>
			  <td colspan=2><font face="arial" color="cc0000" size="-1"><strong>ERROR! You must Select a Section.</strong></font></td>
			</tr>
		<cfelseif url.e eq 2>
			<tr>
			  <td colspan=2><font face="arial" color="cc0000" size="-1"><strong>ERROR! You must enter a heading for this paragraph.</strong></font></td>
			</tr>
		<cfelseif url.e eq 3>
			<tr>
			  <td colspan=2><font face="arial" color="cc0000" size="-1"><strong>ERROR! You must enter text for this paragraph</strong></font></td>
			</tr>
		<cfelseif url.e eq 4>
			<tr>
			  <td colspan=2><font face="arial" color="cc0000" size="-1"><strong>ERROR! You did not include a photo to upload.</strong></font></td>
			</tr>
		<cfelseif url.e eq 5>
			<tr>
			  <td colspan=2><font face="arial" color="cc0000" size="-1"><strong>ERROR! No content was found for this section.</strong></font></td>
			</tr>	
		</cfif>
		<cfform action="sitecontent_Update.cfm?action=Add" method="POST" name="AddContent">
		  <input type="hidden" name="section" value="1">
		  <cfset contentloop = GetContent.recordcount>
		  <cfset rankloop = GetContent.recordcount +1>
		    <tr>
			  <td colspan=2><font face="tahoma" color="0066cc" size="-1"><strong>New Content</strong></font></td>
			</tr>
		       <tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Paragraph Heading</b></font>:</td>
				<td align=left><cfinput name="Phead" type="text" size=40 maxlength=65 required="Yes" Message="A headline for this paragraph is required"></td>
			</tr>
			<tr>
				<td colspan=2 align=left>
					<br><font face="Verdana,Arial" size="-1"><b>Text for Pargraph:</b></font><br>
					<textarea name="PText" cols="50" rows="8" wrap="VIRTUAL"></textarea></td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Sorting</b></font>:</td>
				<td align=left><select name="Pranking">
				                            <option value="0">--- Select one ---</option>
											<cfloop index="i" from="1" to="#rankloop#">
											<option value="#i#">#i#</option>
											</cfloop>
				                         </select>
				</td>
			</tr> 
			<tr>
		      <td colspan=2 align=right><br>
			     <input type="Submit" name="Cmd" value="Save Content >>"> 
		      </td>
		       </tr>
		 </cfform>		
		<cfif GetContent.recordcount Gt 0> 
		  </table>
		  <table border="0" cellpadding="3" cellspacing="2" wdith="100%">
		        <tr>
				   <td colspan=4><hr size=1 noshade></td>
				</tr>		
				<tr>
				  <td colspan=4><font face="tahoma" color="0066cc" size="-1"><strong>Existing Content</strong></font></td>
				</tr>
				<tr bgcolor="eeeeee">
				  <td class="normaltext" width="10"></td>
				  <td class="normaltext"><strong>Paragraph Order</strong></td>
				  <td class="normaltext"><strong>Paragraph Heading</strong></td>
				  <td class="normaltext" align="center"><strong>Action</strong></td>
				</tr> 
			  <cfloop query="GetContent">
					<tr>
					    <td width="10"></td>
					    <td class="normalText">#GetContent.Ranking#</td>
						<td align=left><font face="verdana" size="-1">#trim(GetContent.Heading)#</font></td>
					    <td class="normaltext" align="center"><a href="EditContent.cfm?RecID=#GetContent.RecID#">EDIT</a> | <a href="SiteContent_Update.cfm?action=Confirm&RecID=#GetContent.RecID#" class="color:cc0000;">DELETE</a></td>
					</tr>
			  </cfloop>
		</cfif>
		</table>
		</cfoutput>
		</div>
</td>
</tr>
</table></CFMODULE>

</HTML>