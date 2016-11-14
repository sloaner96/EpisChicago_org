<cfparam name="url.e" default="0">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="GetBishops" datasource="#Application.DSN#">
	Select * 
	From Bishops
	Order By BishopID
</cfquery>


<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Episcopal Ministries" SubTitle="Sermon/Message Administration">
<table border="0" cellpadding="3" cellspacing="0" width="100%">
  <tr>
    <td><font face="arial" size="-1">From this page you can maintain the Sermons and the Messages of the bishops.</font></td>
  </tr>
  <form name="UpdBishops" action="Sermons.cfm" method="POST">
  <tr>
    <td><font face="verdana" size="-1"><strong>Select A Bishop To Admin:</strong></font></td>
  </tr>
  
	  <tr>
	    <td><select name="Bishop">
		      <option value="">--- Choose One --</option>
			  <cfoutput query="GetBishops">   
			    <option value="#BishopID#" <cfif IsDefined("Form.Bishop")><cfif form.Bishop EQ GetBishops.BishopID>Selected</cfif></cfif>>#BishopName#</option>
			  </cfoutput>
			</select>
		</td>
	  </tr>
	    <tr>
    <td><font face="verdana" size="-1"><strong>Select the Type of Content:</strong></font></td>
  </tr>
  
	  <tr>
	    <td><select name="SType">
		      <option value="SERMON" <cfif IsDefined("url.Type")><cfif url.type EQ "S">Selected</cfif></cfif>>Sermon/Address</option>
			  <option value="MESG" <cfif IsDefined("url.Type")><cfif url.type EQ "M">Selected</cfif></cfif>>Message</option>
			</select>
		</td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	  <tr>
	    <td><input type="submit" name="submit" value="Submit >>"></td>
	  </tr>
  </form>
</table>
<cfif IsDefined("FORM.Bishop")><hr noshade size="1"><br>
	<cfquery name="GetSermon" datasource="#Application.DSN#">
		Select B.BishopName, S.* 
		From Bishops B, Sermons S
		Where S.BishopID = B.BishopID 
		AND S.BishopID = #Form.Bishop#
		AND S.SermonType = '#FORM.SType#'
		Order By S.SermonDate Desc
	</cfquery>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
     <cfoutput>
	  <tr>
         <td><font face="arial" size="-1"><a href="NewSermons.cfm?B=#Form.Bishop#&T=#Form.SType#">Add new content</a></font></td>
     </tr>
	 </cfoutput>
    </table><br>
	<table border="0" cellpadding="3" cellspacing="1" width="100%" bgcolor="eeeeee">
      <tr bgcolor="#006699">
	    <td></td>
        <td><font face="verdana" color="ffffff" size="-1"><strong>Title</strong></font></td>
		<td><font face="verdana" color="ffffff" size="-1"><strong>Date</strong></font></td>
		<td><font face="verdana" color="ffffff" size="-1"><strong>Type</strong></font></td>
      </tr>
	  <cfif GetSermon.recordcount GT 0>
	  <cfoutput query="GetSermon">
	    <tr bgcolor="ffffff">
		   <td width="20%" valign="top"><font face="verdana" size="-2"><a href="EditSermons.cfm?SID=#SermonID#">[EDIT]</a>&nbsp;&nbsp;&nbsp;<a href="UpdateSermons.cfm?Action=DELETE&SID=#SermonID#" style="color:##cc0000;">[DELETE]</a></font></td>
	       <td width="50%" valign="top"><font face="verdana" size="-1">#GetSermon.SermonTitle#</font></td>
		   <td width="20%" valign="top"><font face="verdana" size="-1">#DateFormat(GetSermon.SermonDate, 'MM/DD/YYYY')#</font></td>
		   <td width="10%" valign="top"><font face="verdana" size="-1"><cfif SermonType EQ "SERMON">SERMON<cfelse>MESSAGE</cfif></font></td>
	    </tr>
      </cfoutput>
	  <cfelse>
	    <tr bgcolor="ffffff">
	     <td align="center" colspan=4><font face="tahoma" color="b5b5b5" size="-1"><strong>THERE ARE CURRENTLY NO <cfif Form.Stype EQ "SERMON">SERMONS<cfelse>MESSAGES</cfif> FOR THIS BISHOP</strong></font></td>
		</tr> 
	  </cfif>
	</table>
</cfif>
</CFMODULE>

</HTML>