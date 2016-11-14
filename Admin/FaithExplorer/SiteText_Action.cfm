<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify FaithExplorer.Org Text</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify FaithExplorer.Org Text">
<cfset Error = "">
<cfif Len(trim(Sitetext)) EQ 0>
  <cfset Error = "You Must Enter Text for this Article">
</cfif>

<cfif Len(Trim(form.imgPath)) GT 0>
   <cffile action="UPLOAD" 
       filefield="form.imgPath" 
	   destination="#Application.DirPath#\images\FaithExplorer\"
	   nameconflict="MAKEUNIQUE">
  
  
  <cfset newImgName = file.ServerFile>
</cfif>

<cfif Error EQ "">
    <cfset FormattedArticleText = Trim(form.Sitetext)> 
	
    <cfquery name="UpdText" datasource="#Application.DSN#">
	   Update FaithExplorerTXT
	   Set Articletext = '#FormattedArticleText#'
	   <cfif Len(Trim(form.imgPath)) GT 0>
	     , ImgSrc = '#newImgName#'
	   </cfif>
	   Where ArticleID = #form.TextId#    
	</cfquery>
	
	<cflocation url="Sitetext.cfm" addtoken="NO">
<cfelse>
  <br>
  <blockquote>
    We Could Not Update the Site Text due to the following problem:<br>
	<cfoutput><strong>#Error#</strong><br><br></cfoutput>
	<a href="#" onclick="javascript:history.back(-1);">Click here</a> to go back and correct the Problem.
  </blockquote>
 
</cfif>


</CFMODULE>

</HTML>