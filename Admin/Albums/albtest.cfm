<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Create Event Photo Album</TITLE>
</HEAD>

<CF_Corp_header
	PageTitle="Corp Event Photo Album"
	SubPageTitle="Photo Album Creation Screen">

<p>Use this screen to add photos to existing albums in the database.</p>

<CFQUERY Name="Alb" Datasource="Calendar">
	SELECT * from Album
		WHERE AlbumID = True
</CFQUERY>

<CFIF Alb.RecordCount gt 0>
	<CFSET DirName = ExpandPath(GetFileFromPath("#Alb.PhotoPath#"))>

	<CFDIRECTORY Name="Photos" Action="List" Directory="#DirName#" Filter="*.jpg">

	<CFIF Photos.RecordCount gt 0>
		<table>
		<tr><td>
		<cfform name="PhotoList" action="test.cfm">
			<cfgrid name="files"
        query="Photos"
        insert="No"
        delete="Yes"
        sort="Yes"
        font="Tahoma"
        bold="No"
        italic="No"
        appendkey="No"
        highlighthref="No"
        griddataalign="LEFT"
        gridlines="Yes"
        rowheaders="No"
        rowheaderalign="CENTER"
        rowheaderitalic="No"
        rowheaderbold="No"
        colheaders="Yes"
        colheaderalign="CENTER"
        colheaderitalic="No"
        colheaderbold="No"
        selectmode="EDIT"
        picturebar="No"
        insertbutton="Insert"
        deletebutton="Delete">
		<CFGRIDCOLUMN Name="Name" Header="Image">
		<CFGRIDCOLUMN Name="Caption" Header="Caption">
		<CFGRIDCOLUMN Name="AltText" Header="ALT Tag Text">
		</cfgrid>
			<input type="submit" value="Submit">
		</cfform>
		</td></tr>
		</table>
	<CFELSE>
		No Directory Entries found<br>
	</CFIF>
<CFELSE>
	No Album found.<br>
</CFIF>

<CF_Corp_footer Contact="rpeete@follett.com">

</HTML>
