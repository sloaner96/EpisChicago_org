
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="Programs" datasource="#Application.DSN#">
	Select *
	From Programs
	Where ProgramID = #url.PID#
</cfquery>

<cfquery name="GetContent" datasource="#Application.DSN#">
	Select *
	From ProgramContent
	Where ProgramID = #url.PID#
	Order By Ranking
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Maintain Content">
 
 <cfoutput>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
     <tr>
       <td align="right"><font face="arial" size="-2"><strong><a href="index.cfm">Back to Program Home</a></strong></font></td>
     </tr>
  </table>
  <table border="0" cellpadding="4" cellspacing="0" width="100%">
   <tr>
     <td><font face="tahoma" color="##003399" size="-1"><strong>Maintain Program Content</strong></font></td>
   </tr>
  </table>
  <hr noshade size="1">
  <blockquote>
  <cfform action="UpdateProgram.cfm?action=AddContent" method="POST" name="AddContent" enctype="multipart/form-data">
     <table border="0" cellpadding="3" cellspacing="0">
		  <input type="hidden" name="programID" value="#Programs.ProgramID#">
		  <cfset contentloop = GetContent.recordcount>
		  <cfset rankloop = GetContent.recordcount +1>
		 
		     <tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Paragraph Heading</b></font>:</td>
				<td align=left><cfinput name="Phead" type="text" size=40 maxlength=65 ></td>
			</tr>
			<tr>
				<td colspan=2 align=left>
					<br><font face="Verdana,Arial" size="-1"><b>Text for Pargraph:</b></font><br>
					<textarea name="PText" cols="50" rows="8" wrap="VIRTUAL"></textarea></td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Add Link to Paragraph:</b></font> </td>
				<td align=left><cfinput name="url" type="text" size=40 maxlength=200></td>
		    </tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Add Section Image:</b></font> </td>
				<td align=left><input type="file" name="SecImg" size="30" accept="image/jpeg,image/gif"></td>
		    </tr>
		    <tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Image Position:</b></font> </td>
				<td align=left><font face="verdana" size="-2"><strong>Left <input type="radio" name="imgPos" value="1" checked>&nbsp;&nbsp;&nbsp;Center <input type="radio" name="imgPos" value="2">&nbsp;&nbsp;&nbsp;Right<input type="radio" name="imgPos" value="3"></strong></font></td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Paragraph Sorting</b></font>:</td>
				<td align=left><select name="Pranking">
				                            <option value="0">--- Select one ---</option>
											<cfloop index="i" from="1" to="#rankloop#">
											<option value="#i#">#i#</option>
											</cfloop>
				                         </select>
				</td>
			</tr> 
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td colspan=2 align="Center"><input type="submit" name="submit" value="Save Paragraph >>"></td>
			</tr>
		</table>
		</cfform>		
		<cfif GetContent.recordcount Gt 0> 
		 
		  <table border="0" cellpadding="3" cellspacing="2" wdith="100%">
		        <tr>
				   <td colspan=4><hr size=1 noshade></td>
				</tr>		
				<tr>
				  <td colspan=4><font face="tahoma" color="0066cc" size="-1"><strong>Existing Content</strong></font></td>
				</tr>
				<tr bgcolor="eeeeee">
				  <td width="10"></td>
				  <td><strong><font face="arial" size="-1">Order</font></strong></td>
				  <td><strong><font face="arial" size="-1">Heading</font></strong></td>
				  <td align="center"><strong><font face="arial"  size="-1">Action</font></strong></td>
				</tr> 
			  <cfloop query="GetContent">
					<tr>
					    <td width="10"></td>
					    <td><font face="verdana" size="-1">#GetContent.Ranking#</font></td>
						<td align=left><font face="verdana" size="-1">#trim(GetContent.Heading)#</font></td>
					    <td align="center"><font face="verdana" size="-1"><a href="EditContent_2.cfm?PID=#Programs.ProgramID#&PCID=#GetContent.PContentID#">EDIT</a> | <a href="UpdateProgram.cfm?Action=RemoveContent&PID=#Programs.ProgramID#&PCID=#GetContent.PContentID#" style="color:cc0000;">DELETE</a></font></td>
					</tr>
			  </cfloop>
			 </table>
		<cfelse>
		<hr size=1 noshade>
		  <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <td><font face="verdana" color="##b9b9b9" size="-1"><strong>No Content Exists for this Program</strong></font></td>
            </tr>
          </table>	 
		</cfif>
		</blockquote>
		</cfoutput>

</CFMODULE>

</HTML>