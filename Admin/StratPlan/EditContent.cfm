
<cfquery name="GetContent" datasource="#Application.dsn#">
   Select P.*, 
     (Select Count(*) as SecCount
	    From PageText C
        Where C.PSection = P.PSection) as SecCount
   From Pagetext P
   where P.RecID = #Url.RecID#
</cfquery>

<CFMODULE Template="#Application.Header#" pagetitle="Manage Site Content" >
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="150" valign="top"><cf_sidenav></td>
<td valign="top"><div align="center">
<p><font face="arial" size="-1">Use the form below to maintain content on the Strategic Plan site.</font></p>
<cfoutput>
<cfform action="sitecontent_Update.cfm?action=Update" method="POST" name="UpdateContent">
  <input type="hidden" name="RecordID" value="#GetContent.RecID#">
  <input type="hidden" name="section" value="1">
<table border=0 cellspacing=1 cellpadding=4>

 
  <cfset contentloop = GetContent.recordcount>
  <cfset rankloop = GetContent.SecCount>
    <tr>
	  <td colspan=2><font face="tahoma" color="0066cc" size="-1"><strong>Edit Content</strong></font></td>
	</tr>
       <tr>
		<td align=left><font face="Verdana,Arial" size="-1"><b>Paragraph Heading</b></font>:</td>
		<td align=left><cfinput name="Phead" type="text" size=40 maxlength=65 value="#Trim(GetContent.Heading)#" required="Yes" Message="A headline for this paragraph is required"></td>
	</tr>
	<tr>
		<td colspan=2 align=left>
			<br><font face="Verdana,Arial" size="-1"><b>Text for Pargraph:</b></font><br>
			<textarea name="PText" cols="50" rows="8" wrap="VIRTUAL">#GetContent.InfoText#</textarea></td>
	</tr>
	<tr>
		<td align=left><font face="Verdana,Arial" size="-1"><b>Sorting</b></font>:</td>
		<td align=left><select name="Pranking">
									<cfloop index="i" from="1" to="#rankloop#">
									<option value="#i#" <cfif getContent.ranking EQ i>Selected</cfif>>#i#</option>
									</cfloop>
		                         </select>
		</td>
	</tr> 
	<tr>
      <td colspan=2 align=right><br>
	     <input type="Submit" name="Cmd" value="Update Content >>"> 
      </td>
       </tr>
 </cfform>		
</table>
</div>
</td>
</tr>
</table>
</cfoutput>

</CFMODULE>