<CFIF NOT IsDefined("Form.OrgID")>
	<CFLOCATION URL="index.cfm">
</CFIF>


<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Directory Processing</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Directory Processing">

<cfset ErrorList = ArrayNew(1)>

<cfif Left(Form.Cmd, "6") is not "Delete">
	<CFIF #Form.Parish# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Parish Name</b> field")>
	</CFIF>
	
	<CFIF #Form.PType# is "*">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Parish Type</b> field")>
	</CFIF>
	
	<CFIF #Form.Addr1# is "">
		<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Address 1</b> field")>
	</CFIF>

	<CFIF #Form.Pledge# is not "" AND NOT IsNumeric(Form.Pledge)>
		<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Annual Pledge</b> field")>
	</CFIF>
	
	
</cfif>

<cfset NErrors = ArrayLen(ErrorList)>
<cfif NErrors gt 0>

	<cfoutput>
	<h4><font face="" color="Maroon">#NErrors# problem(s) encountered with your Submission</font></h4>
	</cfoutput>
	<p>Errors have been found while processing your request.  Please return to the form, correct these errors, and resubmit.</p>
	<ol>
	<cfloop INDEX="i" FROM="1" TO="#NErrors#">
	<cfoutput><li><p>#ErrorList[i]#</p></li></cfoutput>
	</cfloop>
	</ol>
	<div align=center><form><input type="Button" name="" value="Correct Errors Now" align="ABSMIDDLE" onclick="history.back()"></form></div>

<cfelse>

	<!--- ****************************************************** --->
	<!--- Process the Record here 						 --->

	<CFIF Left(Form.Cmd, 4) is "Save">
		<CFQUERY Name="AddRec" Datasource="#Application.DSN#">
			INSERT into Directory
				(ParishName,
				 ContactID,
				 ParishType,
				 Address1,
				 Address2,
				 City,
				 State,
				 ZipCode,
				 Phone,
				 FAX,
				 Email,
				 WebSite,
				 <cfif Form.Pledge is not "">AnnualPledge,</cfif>
				 programs,
				 WorshipServices,
				 ParishProfile,
				 Pswd,
				 LastUpdated
				)
			VALUES
				('#Form.Parish#',
				 <cfif Form.ContactID is not "*">#Form.ContactID#<cfelse>NULL</cfif>,
				 '#Form.PType#',
				 '#Form.Addr1#',
				 '#Form.Addr2#',
				 '#Form.City#',
				 '#Form.State#',
				 '#Form.ZipCode#',
				 '#Form.Phone#',
				 '#Form.FAX#',
				 '#Form.Email#',
				 '#Form.WebURL#',
				 <cfif Form.Pledge is not "">
				 #Form.Pledge#,
				 </cfif>
				 <cfif Len(trim(form.programs)) GT 0>'#form.programs#'<cfelse>NULL</cfif>,
				 <cfif Len(trim(form.Worship)) GT 0>'#form.Worship#'<cfelse>NULL</cfif>,
				 <cfif Len(trim(form.parishProfile)) GT 0>'#form.parishProfile#'<cfelse>NULL</cfif>,
				 '#Form.Password#',
				 #now()#
				)
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="New Parish" Status="OK" Message="#Session.FullName# added Parish: '#Form.Parish#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Parish has been Entered!</FONT></H3>
	<CFELSEIF Left(Form.Cmd, "6") is "Delete">
		<CFQUERY Name="DelInfo" Datasource="#Application.DSN#">
			DELETE From Directory
				WHERE OrgID = #Form.OrgID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Delete Parish" Status="OK" Message="#Session.FullName# deleted Parish: '#Form.Parish#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Parish has been Removed!</FONT></H3>
	<CFELSE>
	    <cfif Len(Trim(form.ParishImg))>
		   <cffile action="UPLOAD" 
		           filefield="form.ParishImg"
				   destination="#Application.DirPath#/images/Parishes/" 
				   nameconflict="MAKEUNIQUE">  
				   
			<cfset ThisFile = file.serverFile>	    
		</cfif>
		
		<CFQUERY Name="UpdRec" Datasource="#Application.DSN#">
			UPDATE Directory
			SET
				ParishName	= '#Form.Parish#',
				ParishType	= '#Form.PType#',
				ContactID	= <cfif Form.ContactID is not "*">#Form.ContactID#<cfelse>NULL</cfif>,
				Address1	= '#Form.Addr1#',
				Address2	= '#Form.Addr2#',
				City		= '#Form.City#',
				State		= '#Form.State#',
				ZipCode		= '#Form.ZipCode#',
				Phone		= '#Form.Phone#',
				FAX			= '#Form.FAX#',
				Email		= '#Form.Email#',
				WebSite		= '#Form.WebURL#',
				<cfif Form.Pledge is not "">
				AnnualPledge= #Form.Pledge#,
				</cfif>
				Programs    = <cfif Len(trim(form.programs)) GT 0>'#form.programs#'<cfelse>NULL</cfif>,
				WorshipServices= <cfif Len(trim(form.Worship)) GT 0>'#form.Worship#'<cfelse>NULL</cfif>,
				ParishProfile    = <cfif Len(trim(form.parishProfile)) GT 0>'#form.parishProfile#'<cfelse>NULL</cfif>,
				Pswd		= '#Form.Password#',
				<cfif Len(Trim(form.ParishImg))>imgPath     = '#ThisFile#',</cfif> 
				LastUpdated	= #now()#
			WHERE OrgID = #Form.OrgID#
		</CFQUERY>
		<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Update Parish" Status="OK" Message="#Session.FullName# updated Parish: '#Form.Parish#'" User="#Session.UserID#">

		<H3 align=center><FONT FACE="Verdana,Arial" COLOR="Blue" size="+1">This Parish has been Updated!</FONT></H3>
	</CFIF>

</cfif>

<p align=center><a href="/Admin/Directory/"><font face="Tahoma" color="Maroon" size="+1">Return to Parish Page</font></a></p>

</CFMODULE>

</HTML>
