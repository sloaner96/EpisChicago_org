
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
	Select C.*,
	  (Select Count(*)
	    From ProgramContent
		Where ProgramID = C.ProgramID) as ContentCount
	From ProgramContent C
	Where ProgramID = #url.PID#
	AND PContentID = #url.PCID#
</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Edit Content">
<cfoutput> 
<cfform action="UpdateProgram.cfm?action=UpdateContent" method="POST" name="Edit Content" enctype="multipart/form-data">
     <table border="0" cellpadding="3" cellspacing="0">
		  <input type="hidden" name="programID" value="#Programs.ProgramID#">
		  <input type="hidden" name="ContentID" value="#url.PCID#">
		  <cfset rankloop = GetContent.ContentCount>
		 
		     <tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Paragraph Heading</b></font>:</td>
				<td align=left><cfinput name="Phead" type="text" size=40 maxlength=65 value="#Trim(GetContent.Heading)#"></td>
			</tr>
			<tr>
				<td colspan=2 align=left>
					<br><font face="Verdana,Arial" size="-1"><b>Text for Pargraph:</b></font><br>
					<textarea name="PText" cols="50" rows="8" wrap="VIRTUAL">#Trim(GetContent.PText)#</textarea></td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Update Link:</b></font> </td>
				<td align=left><cfinput name="url" type="text" size=40 maxlength=200 value="#GetContent.Url#"></td>
		    </tr>
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Update Section Image:</b></font> </td>
				<td align=left><input type="file" name="SecImg" size="30" accept="image/jpeg,image/gif"></td>
		    </tr>
		    <tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Image Position:</b></font> </td>
				<td align=left><font face="verdana" size="-2"><strong>Left <input type="radio" name="imgPos" value="1" <cfif GetContent.ImgPosition EQ 1>Checked</cfif>>&nbsp;&nbsp;&nbsp;Center <input type="radio" name="imgPos" value="2" <cfif GetContent.ImgPosition EQ 2>Checked</cfif>>&nbsp;&nbsp;&nbsp;Right<input type="radio" name="imgPos" value="3" <cfif GetContent.ImgPosition EQ 3>Checked</cfif>></strong></font></td>
			</tr>
			<tr>
			    <td>&nbsp;</td>
			</tr>
			<tr>
				<td align=left><font face="Verdana,Arial" size="-1"><b>Paragraph Sorting</b></font>:</td>
				<td align=left><select name="Pranking">
	                            <option value="0">--- Select one ---</option>
								<cfloop index="i" from="1" to="#rankloop#">
								   <option value="#i#" <cfif GetContent.Ranking EQ i>Selected</cfif>>#i#</option>
								</cfloop>
				                </select>
				</td>
			</tr> 
			<tr>
			  <td>&nbsp;</td>
			</tr>
			<tr>
			  <td colspan=2 align="Center"><input type="submit" name="submit" value="Update Paragraph >>"></td>
			</tr>
		</table>
		</cfform>
</cfoutput>
</CFMODULE>

</HTML>