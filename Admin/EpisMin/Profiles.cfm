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


<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Episcopal Ministries" SubTitle="Bishops Profile">
<table border="0" cellpadding="3" cellspacing="0" width="100%">
  <tr>
    <td><font face="arial" size="-1">From this page you can maintain the biographies of the bishops.</font></td>
  </tr>
  <tr>
    <td><font face="verdana" size="-1"><strong>Select A Bishop To Admin:</strong></font></td>
  </tr>
  <form name="UpdBishops" action="Profiles.cfm" method="POST">
	  <tr>
	    <td><select name="Bishop" OnChange="this.form.submit();">
		      <option value="">--- Choose One --</option>
			  <cfoutput query="GetBishops">   
			    <option value="#BishopID#" <cfif IsDefined("Form.Bishop")><cfif form.Bishop EQ GetBishops.BishopID>Selected</cfif></cfif>>#BishopName#</option>
			  </cfoutput>
			</select>
		</td>
	  </tr>
  </form>
</table>
<cfif IsDefined("FORM.Bishop")>
	<cfquery name="GetBishopInfo" datasource="#Application.DSN#">
		Select * 
		From Bishops
		Where BishopID = #Form.Bishop#
		Order By BishopName
	</cfquery>
	<cfoutput>
	     <form name="UpdBishops" action="Profiles_Update.cfm" method="POST" enctype="multipart/form-data">
		   <input type="Hidden" name="BishopID" value="#GetBishopInfo.BishopID#">
			<table border="0" cellpadding="4" cellspacing="0" width="100%">
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Current Bishop Image:</strong></font><br> <cfif GetBishopInfo.BishopImage NEQ ""><img src="#GetBishopInfo.BishopImage#" height="60" width="60"><cfelse><font face="arial" size="-1">Image Does Not Exists</font></cfif></td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Update Bishop Image:</strong></font><br> <input type="file" name="BNewimg" size="15"></td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			   <td><font face="verdana" size="-1"><strong>Type of Bishop:</strong></font></td>
			  </tr>
			  <cfquery name="GetBishopType" datasource="#Application.dsn#">
			    Select Codevalue, CodeDesc
				From Lookups
				Where CodeGroup = 'BISHOP'
				Order By CodeValue
			  </cfquery>
			  <tr>
			    <td><select name="BType">
				     <option value="">-- Choose One --</option>
					 <cfloop Query="GetBishopType"> 
					   <option value="#GetBishopType.CodeValue#" <cfif GetBishopType.Codevalue EQ GetBishopInfo.BishopType>Selected</cfif>>#GetBishopType.CodeDesc#</option>
					 </cfloop>
					</select>
				</td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Email:</strong></font></td>
			  </tr>
			  <tr>
			    <td><input type="text" name="Email" value="#GetBishopInfo.Email#" size="25" maxlength="130"></td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Phone:</strong></font></td>
			  </tr>
			  <tr>
			    <td><input type="text" name="Phone" value="#GetBishopInfo.Phone#" size="15" maxlength="20"></td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Select an Admin for this Bishop:</strong></font></td>
			  </tr>
			  <cfquery name="GetAdmin" datasource="#Application.dsn#">
			    Select MemberID, FirstName, LastName
				From Members
				Where StaffID IS NOT NULL
				Order By LastName, Firstname
			  </cfquery>
			  <tr>
			    <td><select name="BAdmin">
				       <option value="">--- Select One ---</option>
					   <cfloop query="GetAdmin">   
					      <option value="#MemberID#" <cfif GetAdmin.MemberID EQ GetBishopInfo.AdminID>Selected</cfif>>#GetAdmin.LastName#, #GetAdmin.Firstname#</option>
					   </cfloop>
					</select>
				</td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Installed On:</strong></font></td>
			  </tr>
			  <tr>
			    <td><input type="text" name="InstalledOn" value="#DateFormat(GetBishopInfo.InstalledON, 'MM/DD/YYYY')#" size="15" maxlength="20"></td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Consecration SubSite:</strong></font></td>
			  </tr>
			  <tr>
			    <td><input type="text" name="ConSite" value="#GetBishopInfo.ConsecrationSite#" size="25" maxlength="50"></td>
			  </tr>
			  <tr>
			    <td><font face="verdana" size="-1"><strong>Profile:</strong></font></td>
			  </tr>
			  <tr>
			    <td><textarea cols="60" rows="20" name="Profile" wrap="virtual">#GetBishopInfo.Profile#</textarea></td>
			  </tr>
			  <tr>
			   <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td><input type="Submit" name="submit" value="Update Profile >>"></td>
			  </tr>
			</table>
	   </form>	
	</cfoutput>
</cfif>
</CFMODULE>

</HTML>