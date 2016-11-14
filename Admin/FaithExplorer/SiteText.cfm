<cfparam name="URL.Type" default="">
<cfquery name="gettextHeading" datasource="#Application.DSN#">
  Select ArticleType, ArticleTitle
  From FaithExplorerTXT
  order By ArticleTitle
</cfquery>

<cfif URL.Type NEQ "">
   <cfquery name="getSitetext" datasource="#Application.DSN#">
     Select *
     From FaithExplorerTXT
	 Where ArticleType = '#url.Type#'
     order By ArticleTitle
   </cfquery>

</cfif>
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Modify FaithExplorer.Org Text</TITLE>
	</cfoutput>
</HEAD>

<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Site Administration" SubTitle="Modify FaithExplorer.Org Text">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
       <td valign="top" width="200">
	      <table border="0" cellpadding="4" cellspacing="0" width="100%">
             <tr>
			   <td><strong style="font-family:arial; font-size:12px; color:Green;">MAINTAIN SITE TEXT</strong></td>
			 </tr>
			 <tr>
               <td style="font-family:verdana; font-size:11px;">Click on the title to edit the text</td>
             </tr>
			 <cfoutput query="gettextHeading">
			   <tr>
			      <td style="font-family:verdana; font-size:11px;"><a href="SiteText.cfm?Type=#gettextHeading.Articletype#">#gettextHeading.ArticleTitle#</a></td>
			   </tr>
			 </cfoutput>
          </table>           
	   </td>
	   <td width="1" bgcolor="#000000"></td>
	   <td valign="top">
	   <cfoutput>
	    
	      <form name="EditText" action="SiteText_Action.cfm" method="POST" enctype="multipart/form-data">
		     <cfif Url.Type NEQ ""><input type="hidden" name="textID" value="#getSitetext.ArticleID#"></cfif>
			  <table border="0" cellpadding="4" cellspacing="0" style="font-family:verdana; font-size:11px;">
			    
				    <cfif Url.Type NEQ "">
		              <tr>
					     <td colspan="2">Use the form below to a edit content on the FaithExplorer.com website.</td>
					  </tr>
					  <tr>
					     <td><strong>Title:</strong></td>
					     <td>#getSitetext.Articletitle#</td>
					  </tr>
					  <tr>
					     <td valign="top"><strong>Page Text:</strong></td>
					     <td><textarea name="Sitetext" cols="55" rows="25" wrap="Virtual">#trim(getSitetext.Articletext)#</textarea></td>
					  </tr>
					  <tr>
					     <td colspan="2"><strong>Image:</strong> <cfif getSitetext.imgSrc NEQ ""><img src="/images/FaithExplorer/#getSitetext.imgSrc#" width="25" height="25"></cfif></td>
					  </tr>
					  <tr>
					     <td colspan="2"><input type="file" name="imgPath" value=""> <cfif getSitetext.imgSrc NEQ "">*Note this will replace the current image.</cfif></td>
					  </tr>
					  <tr>
					    <td colspan="2"><strong>Date Added:</strong> #DateFormat(getSitetext.DateAdded, 'MM/DD/YYYY')# at #TimeFormat(getSitetext.DateAdded, 'hh:mm tt')#<br>
						                <strong>Last updated:</strong> <cfif getSitetext.LastUpdated NEQ "">#DateFormat(getSitetext..LastUpdated, 'MM/DD/YYYY')# at #TimeFormat(getSitetext.LastUpdated, 'hh:mm tt')#<cfelse>NEVER</cfif>
						</td>
					  </tr>
					  <tr>
					    <td colspan="2"><input type="submit" value="submit" name="Update Site Text >>"></td>
					  </tr>
				   
				 <cfelse>
				   <tr>
				     <td>&nbsp;</td>
				   </tr>
				   <tr>
	                  <td><---- Select the area at the left for which you would like to edit the text.</td>
	               </tr>  
				 </cfif>
	          </table>
		 </form> 
		 </cfoutput>
	   </td>
   </tr>
</table>           


</CFMODULE>

</HTML>