<CF_NoCache>

<CFIF NOT IsDefined("Form.AlbumID")>
	<CFLOCATION URL="index.cfm">
</CFIF>

<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Event Photos Maintenance</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Photo Maintenance">
<font face="Verdana,Arial" size="-1">

<CFSET #ErrorsFound#	= FALSE>

<CFIF #Form.FileContents# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No image was selected!  Use the Browse button on the previous page to locate an image on your hard drive.</li>
</CFIF>

<CFIF #Form.Caption# is "">
	<CFIF NOT #ErrorsFound#>
		<h3 align=center>The following problems were found with your entry</h3>
		<ul type=disc>
		<CFSET #ErrorsFound# = TRUE>
	</CFIF>
	<li>No value specified for the <b>Caption</b> field</li>
</CFIF>


<CFIF NOT #ErrorsFound#>

	<CFSET Location = "#Application.DirPath##Form.DirName#\photo001.jpg">
	
	<CFFILE Action="Upload"
		FileField="Form.FileContents"
		Destination="#Location#"
		NameConflict="MakeUnique"
		Accept="image/*">

	<CFX_ImgInfo NAME="ImageNfo" Filename="#Application.DirPath##Form.DirName#\#File.ServerFile#">

	<cfquery name="LastSeq" datasource="#Application.DSN#">
		SELECT Max(Sequence) as HighestSeq From AlbPhotos
			WHERE AlbumID = #Form.AlbumID#
	</cfquery>
	<cfset NextSeqNbr = IIF(LastSeq.HighestSeq neq "", DE("#LastSeq.HighestSeq#"), DE("0"))>
	
	<CFQUERY Name="AddInfo" Datasource="#Application.DSN#">
		INSERT into AlbPhotos
			(AlbumID,
			 FileName,
			 Width,
			 Height,
			 AltText,
			 Sequence,
			 Caption
			)
		VALUES
			(#Form.AlbumID#,
			 '#File.ServerFile#',
			 #ImageNfo.Width#,
			 #ImageNfo.Height#,
			 '#Form.AltText#',
			 #Evaluate(NextSeqNbr+1)#,
			 '#Form.Caption#'
			)
	</CFQUERY>

	<CFQUERY Name="Alb" Datasource="#Application.DSN#">
		SELECT AlbumID, NumPhotos from Album
			WHERE AlbumID = #Form.AlbumID#
	</CFQUERY>
	
	<CFSET NewValue = #Alb.NumPhotos# + 1>
	<CFQUERY Name="UpdAlb" Datasource="#Application.DSN#">
		UPDATE Album
			SET
				NumPhotos = #NewValue#
			WHERE
				AlbumID = #Form.AlbumID#
	</CFQUERY>
	<CF_LogFile SiteID="#Application.SiteNfo.SiteID#" Action="Add Photo" Status="OK" Message="#Session.FullName# added photograph '#Form.Caption#' in Album #Form.AlbumID#" User="#Session.UserID#">

	<CFLOCATION URL="AlbPopulate.cfm?AlbumID=#Alb.AlbumID#" addtoken="No">

<CFELSE>
	</ul><br><br>
	<p align=center><a href="AlbPopulate.cfm?AlbumID=#Form.AlbumID#">Correct Errors Now</a></p>
</CFIF>


</CFMODULE>

</HTML>
