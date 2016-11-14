<CF_NoCache>
<cfif Not IsDefined("session.subuserID")>
  <cflocation url="../../index.cfm?GroupID=#url.groupID#">
</cfif>

<CFIF NOT IsDefined("URL.AlbumID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Photos Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#"  PageTitle="Site Administration" SubTitle="Photo Maintenance">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td width="200" valign="Top"><cfoutput><cfmodule template="../sidenav.cfm"></cfoutput></td>
<td>
<font face="Verdana,Arial" size="-1">

<CFIF IsDefined("URL.AutoScan")>
	<CFQUERY Name="Alb" Datasource="#Application.dsn#">
		SELECT AlbumID, PhotoPath, NumPhotos from Album
			WHERE AlbumID = #URL.AlbumID#
	</CFQUERY>

	<CFSET DirName = "#Application.DirPath##Alb.PhotoPath#">
	<CFDIRECTORY Name="Photos" Action="List" Directory="#DirName#" Filter="*.jpg">
	
	<CFIF Photos.RecordCount gt 0>
		<CFSET Count = Alb.NumPhotos>
		<CFLOOP Query="Photos">
			<CFQUERY Name="Chk" Datasource="#Application.dsn#">
				SELECT FileName from AlbPhotos
					WHERE AlbumID = #Alb.AlbumID# AND FileName = '#Photos.Name#'
			</CFQUERY>

			<CFIF Chk.RecordCount eq 0>
				<CFSET Count = Count + 1>
				<CFSET FullPath = "#DirName#/#Photos.Name#">
				<CFX_ImgInfo NAME="ImageNfo" Filename="#FullPath#">

				<CFQUERY Name="AddInfo" Datasource="#Application.dsn#">
					INSERT into AlbPhotos
						(AlbumID,
						 FileName,
						 Width,
						 Height,
						 Sequence
						)
					VALUES
						(#Alb.AlbumID#,
						 '#Photos.Name#',
						 #ImageNfo.Width#,
						 #ImageNfo.Height#,
						 #Count#
						)
				</CFQUERY>
			</CFIF>
		</CFLOOP>

		<CFIF Count gt Alb.NumPhotos>
			<CFQUERY Name="AdjCount" Datasource="#Application.dsn#">
				UPDATE Album
					SET NumPhotos = #Count#
					WHERE AlbumID = #Alb.AlbumID#
			</CFQUERY>
		</CFIF>
	</CFIF>
</CFIF>


<CFQUERY Name="Alb" Datasource="#Application.dsn#">
	SELECT * from Album
		WHERE AlbumID = #URL.AlbumID#
</CFQUERY>


<CFOUTPUT>
<center>
<table width=90% border=0>
<tr valign=top>
	<td width=50% align=left><a href="/diocese/offices/siteadmn/Albums/UpdAlbum.cfm?AlbumID=#AlbumID#"><font face="Tahoma" color="Blue" size="-1">Return to Album Page</font></a></td>
	<td width=50% align=right><a href="/Albums/album.cfm?AlbumID=#AlbumID#" target="_blank"><font face="Tahoma" color="Blue" size="-1">View Photo Album</font></a></td>
</tr>
</table>
</center>
<h4 align=center>Use this screen to Add/Update/Delete photos to Album:<br>"#Alb.AlbName#" (#Alb.NumPhotos# on file)</h4>
</CFOUTPUT>

<CFIF Alb.RecordCount gt 0>
	<CFQUERY Name="Photos" Datasource="#Application.dsn#">
		SELECT PhotoID, Sequence, FileName, Height, Width, Caption, AltText from AlbPhotos
			WHERE AlbumID = #URL.AlbumID#
			ORDER BY Sequence
	</CFQUERY>

	<center>
	<table border=0>
	<tr><td>
		<cfform name="PhotoList" action="Photo-Update.cfm">
			<CFOUTPUT><input type="hidden" name="AlbumID" value="#URL.AlbumID#"></CFOUTPUT>
			
			<cfgrid name="UpdAlbum" width="600" query="Photos" insert="No" delete="Yes" sort="Yes" font="Tahoma" bold="No" italic="No" appendkey="No" highlighthref="No" griddataalign="LEFT" gridlines="Yes" rowheaders="Yes" rowheaderalign="LEFT" rowheaderitalic="No" rowheaderbold="No" colheaders="Yes" colheaderalign="CENTER" colheaderitalic="No" colheaderbold="Yes" selectmode="EDIT" picturebar="No">
				<cfgridcolumn name="PhotoID" headeralign="CENTER" dataalign="LEFT" display="No" headerbold="Yes">
				<cfgridcolumn name="Sequence" header="Seq##" headeralign="CENTER" dataalign="LEFT" display="Yes" headerbold="Yes" >
				<cfgridcolumn name="FileName" select="No" headeralign="CENTER" dataalign="LEFT" display="Yes" headerbold="Yes" >
				<cfgridcolumn name="Caption" headeralign="CENTER" dataalign="LEFT" width="200" display="Yes" headerbold="Yes" >
				<cfgridcolumn name="AltText" headeralign="CENTER" dataalign="LEFT" width="200" display="Yes" headerbold="Yes" >
			</cfgrid>
			<p align=center><input type="submit" value="Process Updates"></p>
		</cfform>
	</td></tr>
	</table>
	</center>

	<hr width=80% size=2 noshare align=center>
</cfif>

<h3 align=center><font face="Verdana" color="Blue">Add a new image to the album</font></h3>
<cfform name="NewPhoto" Enctype="multipart/form-data" Action="Photo-Add.cfm">
<CFOUTPUT><input type="hidden" name="DirName" value="#Alb.PhotoPath#">
<input type="hidden" name="AlbumID" value="#Alb.AlbumID#"></CFOUTPUT>

<blockquote>
<table width="300" border="0" cellspacing="2" cellpadding="2" align="right" bgcolor="#E6E6E6">
<tr><td colspan=2 align=center>&nbsp;</td></tr>

<tr valign=top>
	<td width=100 align=left><font size="-1"><b>File</b>:</font></td>
	<td width=200 align=left><input type="file" name="FileContents"></td>
</tr>

<tr valign=top>
	<td width=100 align=left><font size="-1"><b>Caption</b>:</font></td>
	<td width=200 align=left><textarea name="Caption" cols="23" rows="2" wrap="VIRTUAL"></textarea></td>
</tr>

<tr valign=top>
	<td width=100 align=left><font size="-1"><b>ALT&nbsp;Text</b>:</font></td>
	<td width=200 align=left><cfinput name="AltText" type="text" size=25 maxlength=80></td>
</tr>
<tr>
	<td colspan=2 align=center><br>
		<input type="Submit" value="Upload New Image"> 
		<input type="reset" value="Clear Form"><br>&nbsp;
	</td>
</tr>
</table>
</cfform>

<p>Use the BROWSE button to locate an image on your hard drive.  Then provide text for the caption of the photo.  We recommend caption do not exceed 10-15 words.</p>
<p>Optionally, you can provide text to appear when the mouse hovers over the photo while viewing the photo album.</p>
</blockquote>


</font>

</td>
</tr>
</table></CFMODULE>
</HTML>
