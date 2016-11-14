<CFIF NOT IsDefined("Form.FileContents")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#:  - Clergy File Transfer</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Clergy File Maintenance">
<blockquote>

<CFSET Location = "#Application.DirPath#\Admin\DB\Clergy.txt">
<cffile action="UPLOAD"
        filefield="Form.FileContents"
        destination="#Location#"
        nameconflict="OVERWRITE">

<cfset NRecs = 0>
<cffile action="READ" file="#Location#" variable="InData">

<cfloop index="ImpRec" list="#InData#" delimiters="#chr(13)##chr(10)#">

	<cfif Len(ImpRec) gt 1 AND Find("Person_ID", ImpRec) eq 0>
		<cfset NRecs = NRecs + 1>
		<cfset ImpRec = Replace(ImpRec, '","', ' | ', 'ALL')>
		<cfset DataFields = ListToArray(ImpRec, '|')>

		<cfloop index="i" from="1" to="#ArrayLen(DataFields)#">
			<cfset DataFields[i] = Trim(ReplaceList(DataFields[i], '"', ''))>
		</cfloop>

		<cfquery name="GetCType" datasource="#Application.DSN#">
			SELECT CodeValue From qConTypes
				WHERE CodeDesc = '#DataFields[4]#'
		</cfquery>
		<cfif GetCType.RecordCount is 0>
			<cfquery name="GetCType" datasource="#Application.DSN#">
				SELECT CodeValue From qConTypes
					WHERE CodeDesc = '#SpanExcluding(DataFields[4]," ")#'
			</cfquery>
		</cfif>

		<cfset FName = '#DataFields[6]#'>
		<cfset LName = '#DataFields[8]#'>
		<cfset Addr1 = '#DataFields[11]#'>
		<cfset Addr2 = '#DataFields[12]#'>
		<cfset City  = '#DataFields[13]#'>

		<cfset EMail = '#LCase(DataFields[18])#'>
		<cfif EMail neq "">
			<cfx_checkemail email="#email#">
			<cfif Check_Email_Level gt 0>
				<cfset EMail = "">
			</cfif>
		</cfif>

		<cfquery name="ChkRec" datasource="#Application.DSN#">
			SELECT ContactID From Contacts
				WHERE ContactID = #DataFields[2]#
		</cfquery>
		
		<cfoutput>#DataFields[5]# #FName# #LName#</cfoutput> - 
		<cfif ChkRec.RecordCount eq 0>
			Added
			<cfquery name="AddRec" datasource="#Application.DSN#">
				INSERT INTO Contacts
					(LastSync, ContactID, OrgID, ContactType, Prefix, FirstName, MiddleName, LastName, Suffix, Credentials, 
					 Address1, Address2, City, State, ZipCode, Phone, FAX, Email, LastUpdated)
				VALUES
					(#CreateODBCDate(DataFields[1])#,
					 #DataFields[2]#,
					 <cfif DataFields[3] neq "">#DataFields[3]#<cfelse>NULL</cfif>,
					 '#GetCType.CodeValue#',
					 '#DataFields[5]#',
					 '#FName#',
					 '#DataFields[7]#',
					 '#LName#',
					 '#DataFields[9]#',
					 '#DataFields[10]#',
					 '#Addr1#',
					 '#Addr2#',
					 '#City#',
					 '#DataFields[14]#',
					 '#DataFields[15]#',
					 '#DataFields[16]#',
					 '#DataFields[17]#',
					 '#EMail#',
					 #CreateODBCDateTime(now())#
					)
			</cfquery>
		<cfelse>
			Updated
			<cfquery name="UpdRec" datasource="#Application.DSN#">
				UPDATE Contacts
				SET
					LastSync	= #CreateODBCDate(DataFields[1])#,
					ContactID	= #DataFields[2]#,
					OrgID		= <cfif DataFields[3] neq "">#DataFields[3]#<cfelse>NULL</cfif>,
					ContactType	= '#GetCType.CodeValue#',
					Prefix		= '#DataFields[5]#',
					FirstName	= '#FName#',
					MiddleName	= '#DataFields[7]#',
					LastName	= '#LName#',
					Suffix		= '#DataFields[9]#',
					Credentials	= '#DataFields[10]#',
					Address1	= '#Addr1#',
					Address2	= '#Addr2#',
					City		= '#City#',
					State		= '#DataFields[14]#',
					ZipCode		= '#DataFields[15]#',
					Phone		= '#DataFields[16]#',
					FAX			= '#DataFields[17]#',
					<cfif Email neq "">Email = '#EMail#',</cfif>
					LastUpdated	= #CreateODBCDateTime(now())#
					WHERE ContactID = #ChkRec.ContactID#
			</cfquery>
		</cfif>
		<br>
	</cfif>

</cfloop>

<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Clergy Upload" Status="OK" Message="#Session.FullName# processed clergy information from a File Transfer from the Diocesan Database" User="#Session.UserID#">

<cfoutput>
<p>**** A total of #Nrecs# Clergy records were added/updated</p>
</cfoutput>

</blockquote>
</CFMODULE>

</HTML>
