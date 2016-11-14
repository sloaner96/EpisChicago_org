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
<cfquery name="GetSermon" datasource="#Application.DSN#">
		Select B.BishopName, S.* 
		From Bishops B, Sermons S
		Where S.BishopID = B.BishopID 
		AND S.SermonID = #URL.SID#
		Order By S.SermonDate Desc
	</cfquery>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Episcopal Ministries" SubTitle="Sermon/Message Administration">
<div align="right"><font face="verdana" size="-2"><a href="Sermons.cfm">Back to Sermon/Message Admin</a></font></div>
<table border="0" cellpadding="3" cellspacing="0" width="100%">
  <tr>
    <td><font face="arial" size="-1">From this page you can Edit this <cfif GetSermon.SermonType EQ "SERMON">Sermon<cfelse>Message</cfif>.</font></td>
  </tr>
  <tr>
   <td><hr noshade size="1"</td>
  </tr>
  <cfif Url.E EQ 1>
    <tr>
	  <td align="center"><font face="verdana" color="#cc0000" size="-1"><strong>Error! You must include a title</strong></font></td>
	</tr>
  <cfelseif Url.E EQ 2>
    <tr>
	  <td align="center"><font face="verdana" color="#cc0000" size="-1"><strong>Error! You must enter a date</strong></font></td>
	</tr>
  <cfelseif Url.E EQ 3>
   <tr>
	  <td align="center"><font face="verdana" color="#cc0000" size="-1"><strong>Error! You must enter text for this content</strong></font></td>
	</tr>
  </cfif>
  <tr>
    <td>
	   <cfform name="AddSermon" action="UpdateSermons.cfm?Action=UPDATE" Method="POST" enctype="multipart/form-data">
		<cfoutput>   
		   <input type="hidden" name="SermonID" value="#GetSermon.SermonID#"> 
		   <table border="0" cellpadding="4" cellspacing="0">
	          <tr>
	            <td><font face="verdana" size="-1"><strong>Title:</strong></font></td>
				<td><cfinput type="text" name="Title" value="#GetSermon.SermonTitle#" size="40" maxlength="200" required="Yes" message="You must enter a title."></td>
	          </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Type of Content:</strong></font></td>
				<td><select name="SType">
		               <option value="SERMON" <cfif GetSermon.SermonType EQ "SERMON">Selected</cfif>>Sermon/Address</option>
			           <option value="MESG" <cfif GetSermon.SermonType EQ "MESG">Selected</cfif>>Message</option>
			        </select>
				</td>
			  </tr>
			  <tr>
	             <td><font face="verdana" size="-1"><strong>Bishop:</strong></font></td>
				 <td><select name="Bishop">
			          <cfloop query="GetBishops">   
			            <option value="#BishopID#" <cfif GetSermon.BishopID EQ GetBishops.BishopID>Selected</cfif>>#BishopName#</option>
			          </cfloop>
			        </select>
				 </td>
	          </tr>
			  <tr>
	            <td><font face="verdana" size="-1"><strong>Date:</strong></font></td>
				<td><cfinput type="text" name="SermonDate" value="#DateFormat(GetSermon.SermonDate, 'MM/DD/YYYY')#" size="12" maxlength="20" required="YES" message="You must enter a date"></td>
	          </tr>
			  
			  <tr>
	            <td><font face="verdana" size="-1"><strong>Web URL Heading:</strong></font></td>
				<td><cfinput type="text" name="URLHeading" value="#GetSermon.URLHeading#" size="30" maxlength="150"></td>
	          </tr>
			  
			  <tr>
	            <td><font face="verdana" size="-1"><strong>Web URL:</strong></font></td>
				<td><cfinput type="text" name="WebURL" value="#GetSermon.WebURL#" size="30" maxlength="130"></td>
	          </tr>
			  <tr>
	            <td><font face="verdana" size="-1"><strong><cfif GetSermon.ImgName NEQ "">Update<cfelse>Add</cfif> Image:</strong></font></td>
				<td><input type="file" name="imgFile" size="30" ></td>
	          </tr>
			  <cfif GetSermon.ImgName NEQ "">
			  <tr>
	            <td><font face="verdana" size="-1"><strong>Current Image:</strong></font></td>
				<td><img src="/images/#GetSermon.ImgName#" Height="40" width="40" border="0"></td>
	          </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  </cfif>
			  <tr>
			    <td colspan=2><font face="verdana" size="-1"><strong>Message/Sermon:</strong></font><br>
				    <textarea cols="60" rows="20" name="SermonText">#Trim(GetSermon.SermonText)#</textarea>
				</td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td><input type="submit" name="submit" value="Update >>"></td>
			  </tr>
	       </table>
		   </cfoutput>
	   </cfform>
	</td>
  </tr>
</table>

</CFMODULE>

</HTML>