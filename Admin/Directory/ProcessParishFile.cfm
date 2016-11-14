<CFIF NOT IsDefined("Form.FileContents")>
	<CFLOCATION URL="default.cfm">
</CFIF>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#:  - Parish File Transfer</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Parish File Maintenance">
<blockquote>

<CFSET Location = "#Application.DirPath#\Admin\DB\Parish.txt">
<cffile action="UPLOAD"
        filefield="Form.FileContents"
        destination="#Location#"
        nameconflict="OVERWRITE">

<cfset NRecs = 0>
<cffile action="READ" file="#Location#" variable="InData">

<cfloop index="ImpRec" list="#InData#" delimiters="#chr(13)##chr(10)#">

	<cfif Len(ImpRec) gt 1 AND Find("Person_ID", ImpRec) eq 0>
		<cfset ImpRec = Replace(ImpRec, '","', ' | ', 'ALL')>
		<cfset DataFields = ListToArray(ImpRec, '|')>

		<cfloop index="i" from="1" to="#ArrayLen(DataFields)#">
			<cfset DataFields[i] = Trim(ReplaceList(DataFields[i], '"', ''))>
		</cfloop>

		<cfset CPos = Find(":", DataFields[7])>
		<cfif CPos gt 0>
			<cfset CPos = CPos + 1>
			<cfset PName = RemoveChars(DataFields[7], 1, CPos)>
		<cfelse>
			<cfset PName = '#DataFields[7]#'>
		</cfif>
		<cfset Addr1 = '#DataFields[8]#'>
		<cfset Addr2 = '#DataFields[9]#'>
		<cfset City  = '#DataFields[10]#'>

		<cfset EMail = '#LCase(DataFields[16])#'>
		<cfif EMail neq "">
			<cfx_checkemail email="#email#">
			<cfif Check_Email_Level gt 0>
				<cfset EMail = "">
			</cfif>
		</cfif>

		<cfif DataFields[6] neq "">
			<cfquery name="ChkRec" datasource="#Application.DSN#">
				SELECT OrgID From Directory
					WHERE OrgID = #DataFields[6]#
			</cfquery>
		</cfif>

		<cfif DataFields[6] neq "" AND DataFields[4] gt 0 AND DataFields[4] lt 99 AND DataFields[18] is not "">
			<cfquery name="GetRevs" datasource="#Application.DSN#">
				SELECT TOP 1 ContactID From Contacts
					WHERE OrgID = #DataFields[6]#
						AND ContactType IN ('RT','PI','DI','AB','BI','DE','EX','IN','VC','CH')
			</cfquery>

			<cfset NRecs = NRecs + 1>
			<cfoutput>#PName#, #City#</cfoutput> - 
			<cfif ChkRec.RecordCount eq 0>
				Added
				<cfquery name="AddRec" datasource="#Application.DSN#">
					INSERT INTO Directory
						(LastSync, DeaneryID, OrgID, ContactID, ParishName, 
						 Address1, Address2, City, State, ZipCode, 
						 Phone, FAX, Email, WebSite, ParishType, LastUpdated)
					VALUES
						(#CreateODBCDate(DataFields[1])#,
						 #DataFields[4]#,
						 #DataFields[6]#,
						 <cfif GetRevs.RecordCount is 1>#GetRevs.ContactID#<cfelse>NULL</cfif>,
						 '#PName#',
						 '#Addr1#',
						 '#Addr2#',
						 '#City#',
						 '#DataFields[11]#',
						 '#DataFields[12]#',
						 '#DataFields[13]#',
						 '#DataFields[14]#',
						 '#EMail#',
						 '#DataFields[17]#',
						 '#DataFields[18]#',
						 #CreateODBCDateTime(now())#
						)
				</cfquery>
			<cfelse>
				Updated
				<cfquery name="UpdRec" datasource="#Application.DSN#">
					UPDATE Directory
					SET
						LastSync		= #CreateODBCDate(DataFields[1])#,
						DeaneryID		= #DataFields[4]#,
						OrgID			= #DataFields[6]#,
						ContactID		= <cfif GetRevs.RecordCount is 1>#GetRevs.ContactID#<cfelse>NULL</cfif>,
						ParishName		= '#PName#',
						Address1		= '#Addr1#',
						Address2		= '#Addr2#',
						City			= '#City#',
						State			= '#DataFields[11]#',
						ZipCode			= '#DataFields[12]#',
						Phone			= '#DataFields[13]#',
						FAX				= '#DataFields[14]#',
						<cfif EMail neq "">EMail = '#EMail#',</cfif>
						<cfif DataFields[17] neq "">WebSite = '#DataFields[17]#',</cfif>
						ParishType		= '#DataFields[18]#',
						LastUpdated		= #CreateODBCDateTime(now())#
						WHERE OrgID = #ChkRec.OrgID#
				</cfquery>
			</cfif>
			<br>
		</cfif>
	</cfif>

</cfloop>

<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Parish Upload" Status="OK" Message="#Session.FullName# processed parish information from a File Transfer from the Diocesan Database" User="#Session.UserID#">

<cfoutput>
<p>**** A total of #Nrecs# Parish records were added/updated</p>
</cfoutput>

</blockquote>
</CFMODULE>

</HTML>
