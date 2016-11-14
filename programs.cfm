

<cfquery name="GetGroupPrograms" datasource="#Application.dsn#">
	Select P.ProgramID, P.Title, P.begindate, P.enddate
   From Programs P
   Where P.ProgramID = #url.programID#
   AND Approved = True
   AND EndDate >= #createodbcdatetime(now())#
</cfquery>
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Diocesan Programs > #GetGroupPrograms.Title#</TITLE>
</head>
<cfmodule template="#Application.header#" PageTitle="Diocesan Programs" subtitle="#GetGroupPrograms.Title#">
<cfif GetGroupPrograms.recordcount GT 0>

	    <cfquery name="GetProgramContent" datasource="#Application.dsn#">
		   Select *
		   From ProgramContent
		   Where ProgramID = #GetGroupPrograms.ProgramID#
		   Order By Ranking, Heading
		</cfquery>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		  <tr>
		    <td><cfoutput><h2><font face="tahoma" color="##000066">#GetGroupPrograms.Title#</font></h2></cfoutput></td>
		     <cfquery name="GetProgEvents" datasource="#Application.dsn#">
			   Select *
			   From Events
			   where ProgramID = #GetGroupPrograms.ProgramID#
			   order by BeginDate, EndDate
			 </cfquery>
		  </tr>
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
						 <cfif GetProgramContent.ImgName NEQ ""><img src="/images/programs/#GetProgramContent.imgname#" alt="" border="0" align="<cfif GetProgramContent.ImgPosition EQ 1>Left<cfelseif GetProgramContent.ImgPosition EQ 2>MIDDLE<cfelseif GetProgramContent.ImgPosition EQ 3>right</cfif>" hspace="4" vspace="2"></cfif>
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
<br><br><br><br>
<cfelse>
<br>
  <div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO UPCOMING PROGRAMS</strong></font></div> 

</cfif>
</cfmodule>