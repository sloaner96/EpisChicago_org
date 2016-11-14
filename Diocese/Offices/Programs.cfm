<cfparam name="attributes.ProgramID" default="0">
<cfparam name="attributes.GroupID" default="0">

<cfquery name="GetGroupPrograms" datasource="#Application.dsn#">
	Select P.*, G.Highlight
   From Programs P, GrpPrograms G
   Where G.ProgramID = P.ProgramID
   AND G.GroupID = #attributes.GroupID# 
   AND P.Approved = True
   AND P.EndDate >= #createodbcdatetime(now())#
   <cfif Attributes.ProgramID NEQ "0">
    AND P.ProgramID = #Attributes.ProgramID#
   </cfif>
</cfquery>

<cfif GetGroupPrograms.recordcount GT 0>
	<cfif GetGroupPrograms.recordcount EQ 1>
	    <cfquery name="GetProgramContent" datasource="#Application.dsn#">
		   Select *
		   From ProgramContent
		   Where ProgramID = #GetGroupPrograms.ProgramID#
		   Order By Ranking, Heading
		</cfquery>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		  <tr>
		    <td><cfoutput><h2><font face="tahoma" color="##000066">#GetGroupPrograms.Title#</font></h2></cfoutput></td>
		  </tr>
		  <cfquery name="GetProgEvents" datasource="#Application.dsn#">
			   Select *
			   From Events
			   where ProgramID = #GetGroupPrograms.ProgramID#
			   order by BeginDate, EndDate
			 </cfquery>
		  <tr>
		     <td>
			   <cfif GetProgEvents.recordcount GT 0>
				   <table border="0" cellpadding="0" cellspacing="1" width="175" bgcolor="#408080" align="right">
			          <tr bgcolor="#408080">
						  <td align="center"><font face="tahoma" color="#ffffcc" size="+1"><strong>Program Schedule</strong></font></td>
					   </tr>
	                   <tr>
	                      <td>
						      <table border="0" cellpadding="0" cellspacing="2" bgcolor="#c8e1e6" width="100%">
								<cfoutput query="GetProgEvents">
								  <tr>
			                         <td valign="top" align="center"><font 
									     face="arial" size="-1"><strong>#EventName#</strong><br>
									        #DateFormat(BeginDate, 'MMM DD')# - #DateFormat(EndDate, 'MMM DD')#<br>
											<font face="arial" size="-2">#Description#</font><br>
									     </font>
									 </td>
			                      </tr>
								  <tr>
								    <td>&nbsp;</td>
								  </tr>
								</cfoutput>
			                  </table>
					      </td>
	                    </tr>
		           </table>
				 </cfif> 
			   <font face="verdana" size="-1">
				   <cfoutput query="GetProgramContent">
				     
				     <cfif getProgramContent.Heading NEQ ""><p><strong><font face="arial" color="##990000" size="+1">#GetProgramContent.Heading#</font></strong></p></cfif>
					 <cfif GetProgramContent.ImgName NEQ ""><img src="/images/programs/#GetProgramContent.imgname#" alt="" border="0" align="<cfif GetProgramContent.ImgPosition EQ 1>Left<cfelseif GetProgramContent.ImgPosition EQ 2>right</cfif>" hspace="4" vspace="2"></cfif>
					 <p>#ReplaceNoCase(GetProgramContent.PText, "#chr(13)##chr(10)#", "<br>", "ALL")#</p>
					 <cfif GetProgramContent.FormID NEQ "">
					   <cfquery name="GetForm" datasource="#Application.DSN#">
					      Select FormName
						  From Forms
						  Where FormID = #GetProgramContent.FormID#
					   </cfquery> 
					   <p><a href="/DownloadResource.cfm?RecID=#GetProgramContent.formID#" blank="_blank">Download the form: <strong>#GetForm.FormName#</strong></a></p>
					 </cfif>
					 <cfif GetProgramContent.URL NEQ "">
					   <p>Click to visit <a href="#GetProgramContent.URL#" target="_blank">#GetProgramContent.URL#</a></p>
					 </cfif><br>
				   </cfoutput>
			   </font>
			 </td>
			 
		  </tr>
		</table>	
	<cfelse>
		 <table border="0" cellpadding="3" cellspacing="1" width="100%">
		   <tr>
		       <td colspan=2><font face="arial" color="#000066" size="-1"><strong>Upcoming Programs</strong></font></td>
		   </tr>
		   <tr>
		      <td>&nbsp;</td>
		   </tr>
		   <tr bgcolor="#003366">
		      <td><font face="verdana" color="ffffff" size="-1"><strong>DATES</strong></font></td>
			  <td><font face="verdana" color="ffffff" size="-1"><strong>PROGRAM</strong></font></td>
		   </tr>
		   <cfoutput query="GetGroupPrograms">
		     <tr>
			   <td valign="top"><font face="verdana" size="-2">#DateFormat(GetGroupPrograms.BeginDate, 'MM/DD/YYYY')# - #DateFormat(GetGroupPrograms.EndDate, 'MM/DD/YYYY')#</font></td>
			   <td valign="top"><font face="verdana" size="-2"><strong><a href="SiteContent.cfm?GroupID=#Attributes.GroupID#&GCID=07&PID=#GetGroupPrograms.ProgramID#">#GetGroupPrograms.Title#</a></strong><br>#GetGroupPrograms.ShortDesc#</font></td>
			 </tr>
		   </cfoutput>
		  </table>
	</cfif>	
<cfelse>
<br>
  <div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO UPCOMING PROGRAMS FOR THIS GROUP</strong></font></div> 

</cfif>