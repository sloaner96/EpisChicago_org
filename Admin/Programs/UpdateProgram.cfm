<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Site Administration</TITLE>
	</cfoutput>
</HEAD>
<CFMODULE Template="#Application.Header#" Section="Admin" PageTitle="Programs Admin" SubTitle="Add New Program">
<cfif url.action EQ "ADDINFO">
	    <cfif Len(trim(form.title)) EQ 0>
		   <cflocation url="AddProgram.cfm?e=1" addtoken="No">
		</cfif>
	    <cfquery name="CheckProgram" datasource="#Application.dsn#">
		  Select ProgramID
		  From Programs
		  Where Title = '#form.title#'
		</cfquery> 
		
		<cfif CheckProgram.recordcount GT 0>
		   <cflocation url="AddProgram.cfm?e=2" addtoken="No">
		</cfif>
		<!--- @@@ REMOVED PER RICK PEETE
		 <cfif Len(trim(form.BeginDate)) EQ 0>
		    <cflocation url="AddProgram.cfm?e=2" addtoken="No">
		</cfif>
	    
		<cfif Len(trim(form.EndDate)) EQ 0>
		    <cflocation url="AddProgram.cfm?e=3" addtoken="No">
		</cfif> --->
		
	     <cfset tempdesc = Trim(form.sdesc)>
		
		 <cfquery name="AddProgram" datasource="#Application.dsn#">
		    Insert Into Programs (Title, 
			                      BeginDate, 
								  EndDate, 
								  ShortDesc, 
								  Hightlight, 
								  Approved, 
								  HomePageDisplay, 
								  CreatedBy, 
								  LastUpdated)
			Values('#Form.Title#', 
			        <cfif Len(Trim(form.begindate)) GT 0>#CreateodbcDate(form.begindate)#<cfelse>NULL</cfif>, 
					<cfif Len(Trim(form.enddate)) GT 0>#CreateodbcDate(form.enddate)#<cfelse>NULL</cfif>, 
					<cfif tempDesc NEQ "">'#tempdesc#'<cfelse>NULL</cfif>, 
					0,
					0,
					0, 
					#Session.UserID#, 
					#CreateODBCDateTime(now())#)
		 </cfquery>
		 
		 <cfquery name="GetID" datasource="#Application.dsn#">
		   Select ProgramID
		   From Programs
		   Where Title= '#Form.Title#'
		   <cfif Len(Trim(form.begindate)) GT 0>
		   AND BeginDate = #CreateodbcDate(form.begindate)#
		   </cfif>
		   <cfif Len(Trim(form.enddate)) GT 0>
		   AND EndDate = #CreateodbcDate(form.enddate)#
		   </cfif>
		 </cfquery>
		  
		 <cflocation url="EditContent.cfm?PID=#GetID.ProgramID#" addtoken="No">
<cfelseif url.action EQ "UpdateInfo">
        
	    <cfif Len(trim(form.title)) EQ 0>
		   <cflocation url="EditProgram.cfm?e=1&PID=#Form.ProgramID#" addtoken="No">
		</cfif>
		
	    <cfquery name="CheckProgram" datasource="#Application.dsn#">
		  Select ProgramID
		  From Programs
		  Where Title = '#form.title#'
		  AND ProgramID <> #Form.ProgramID#
		</cfquery> 
		
		<cfif CheckProgram.recordcount GT 0>
		   <cflocation url="EditProgram.cfm?e=2&PID=#Form.ProgramID#" addtoken="No">
		</cfif>
		
		<!--- @@@@ Removed Per Rick Peete <cfif Len(trim(form.BeginDate)) EQ 0>
		    <cflocation url="EditProgram.cfm?e=2" addtoken="No">
		</cfif>
	    
		<cfif Len(trim(form.EndDate)) EQ 0>
		    <cflocation url="EditProgram.cfm?e=3" addtoken="No">
		</cfif> --->
		
	     <cfset tempdesc = Trim(form.sdesc)>
		
		 <cfquery name="UpdateProgram" datasource="#Application.dsn#">
		    Update Programs
			 SET Title = '#Form.Title#',
			     BeginDate =  <cfif Len(Trim(form.begindate)) GT 0>#CreateodbcDate(form.begindate)#<cfelse>NULL</cfif>,
				 EndDate = <cfif Len(Trim(form.enddate)) GT 0>#CreateodbcDate(form.enddate)#<cfelse>NULL</cfif>,
				 ShortDesc = <cfif tempDesc NEQ "">'#tempdesc#'<cfelse>NULL</cfif>,
				 Hightlight = <cfif IsDefined("form.Highlight")>1<cfelse>0</cfif>,
				 Approved = <cfif IsDefined("form.Approve")>1<cfelse>0</cfif>,
				 HomePageDisplay = <cfif IsDefined("form.ShowOnSite")>1<cfelse>0</cfif>,
				 LastUpdated = #CreateODBCDateTime(now())#
			 Where ProgramID = #Form.ProgramID#	 
		 </cfquery>
		  
		 <cflocation url="Index.cfm" addtoken="No">	 
<cfelseif url.action EQ "AddContent">
			   <!--- Form Validation --->
	   <cfif Not IsDefined("Form.ProgramID") OR Len(trim(form.ProgramID)) EQ 0>
	      <cflocation url="index.cfm?e=1" addtoken="No">
	   </cfif> 
	   
	   <cfif Len(trim(form.Ptext)) EQ 0>
	      <cflocation url="EDITcontent.cfm?e=2&PID=#Form.ProgramID#" addtoken="No">
	   </cfif>
	   
	   <cfif Len(Trim(form.SecImg)) GT 0>
	      <cffile action="UPLOAD" 
		         filefield="form.SecImg" 
				 destination="#Application.DirPath#\Images\Programs\" 
				 nameconflict="MAKEUNIQUE">
		   
		     <cfset ImgFile = File.ServerFile>	 
	   <cfelse>
	       	<cfset ImgFile = "">	 
	   </cfif>
	   
	   	<cfquery name="GetContent" datasource="#Application.dsn#">
		   Select Max(Ranking) as TopRanking
		   From ProgramContent
		   Where ProgramID = #Form.ProgramID#
		</cfquery>
		
	   <cfif form.pranking EQ 0>
	     <cfset form.pranking = GetContent.TopRanking + 1>
	   </cfif>
	   
	   
	   
	   <cfset temptext = trim(form.ptext)>
	   
	   <cfquery name="InsertContent" datasource="#Application.DSN#">
	     Insert Into ProgramContent(
		    ProgramID, 
			Heading, 
			PText, 
			ImgName,
			ImgPosition,
			URL, 
			Ranking,  
			UpdatedBy,
			LastUpdated)
		 Values(#Form.ProgramID#,
		       '#trim(form.pHead)#', 
			   '#temptext#', 
			   <cfif ImgFile NEQ "">'#ImgFile#'<cfelse>NULL</cfif>,
			   '#form.imgPos#',
			   <cfif form.url NEQ "">'#form.url#'<cfelse>NULL</cfif>,
			   #form.pranking#, 
			   #Session.UserID#, 
			   #CreateODBCDateTime(now())#)
	   </cfquery>
	   
	   <cflocation url="EditContent.cfm?PID=#Form.ProgramID#" addtoken="No">
<cfelseif url.action EQ "UpdateContent">
	   <!--- Form Validation --->
	   <cfif Not IsDefined("Form.ProgramID") OR Len(trim(form.ProgramID)) EQ 0>
	      <cflocation url="index.cfm?e=1" addtoken="No">
	   </cfif> 
	   
	   <cfif Len(trim(form.Ptext)) EQ 0>
	      <cflocation url="Editcontent_2.cfm?e=2&PID=#Form.ProgramID#" addtoken="No">
	   </cfif>
	   
	   <cfif Len(Trim(form.SecImg)) GT 0>
	      <cffile action="UPLOAD" 
		         filefield="form.SecImg" 
				 destination="#Application.DirPath#\Images\Programs\" 
				 nameconflict="MAKEUNIQUE">
		   
		     <cfset ImgFile = File.ServerFile>	 
	   <cfelse>
	       	<cfset ImgFile = "">	 
	   </cfif>
	   
	   	<cfquery name="GetContent" datasource="#Application.dsn#">
		   Select Max(Ranking) as TopRanking
		   From ProgramContent
		   Where ProgramID = #Form.ProgramID#
		</cfquery>
		
	   <cfif form.pranking EQ 0>
	     <cfset form.pranking = GetContent.TopRanking + 1>
	   </cfif>
	   
	   
	   <cfset temptext = trim(form.ptext)>
	   
	   <cfquery name="InsertContent" datasource="#Application.DSN#">
	     Update ProgramContent
		    SET  Heading ='#trim(form.pHead)#',
			     PText ='#temptext#', 
			     <cfif ImgFile NEQ "">ImgName ='#ImgFile#',</cfif>
			     ImgPosition ='#form.imgPos#',
			     URL =<cfif form.url NEQ "">'#form.url#'<cfelse>NULL</cfif>,
			     Ranking =  #form.pranking#, 
			     UpdatedBy = #Session.UserID#,
			     LastUpdated = #CreateODBCDateTime(now())#
		 Where ProgramID = #Form.ProgramID#
		 AND  PContentID = #Form.ContentID#   
	   </cfquery>
	   
	   <cflocation url="EditContent.cfm?PID=#Form.ProgramID#" addtoken="No">
<cfelseif url.action EQ "RemoveContent">

	   <cfif IsDefined("Url.PCID") AND IsDefined("URL.PID")>
	      <cfquery name="DeletContent" datasource="#Application.dsn#">
		     Delete From ProgramContent
			 Where PContentID = #url.PCID#
			 AND ProgramID = #url.PID#
		  </cfquery>
	   </cfif>
	   
	  <cflocation url="EditContent.cfm?PID=#URL.PID#" addtoken="No">
	  
<cfelseif url.action EQ "AddEvent">
				
		<cfset ErrorList = ArrayNew(1)>
		
		<cfif Not IsDefined("Form.ProgramID") OR Len(trim(form.ProgramID)) EQ 0>
			<cflocation url="index.cfm?e=1" addtoken="No">
		</cfif> 
		
		<CFIF Form.Heading is "">
			<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Heading</b> field")>
		</CFIF>
		
		<CFIF Form.SDate is "" OR (#Form.SDate# is not "" and NOT #IsDate(Form.SDate)#)>
			<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Beginning Date & Time</b> field")>
		</CFIF>
		
		<CFIF Form.EDate is not "" and NOT #IsDate(Form.EDate)#>
			<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Ending Date & Time</b> field")>
		</CFIF>
		
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
		
			<cfset EndingDate = Form.EDate>
			<cfif Form.EDate is "">
				<cfset EndingDate = DateFormat(CreateODBCDate("#Form.SDate#"), "mm/d/yyyy") + "11:59pm">
			</cfif>
		
				<CFQUERY Name="AddRec" Datasource="#Application.dsn#">
					INSERT into Events
						(EventName,
						 BeginDate,
						 Location,
						 Contact,
						 Approved,
						 EndDate,
						 Phone,
						 ContactEmail,
						 URL,
						 Category,
						 Highlight,
						 GrpHighlight,
						 Description,
						 ProgramID
						)
					VALUES
						('#Form.Heading#',
						 #CreateODBCDateTime(Form.SDate)#,
						 '#Form.Location#',
						 '#Form.Contact#',
						 1,
					 	 #CreateODBCDateTime(EndingDate)#,
						 '#Form.Phone#',
						 '#Form.Email#',
						 '#Form.WebURL#',
						 NULL,
						  0,
						  0,
						  '#Form.Description#',
						   #Form.ProgramID#
						)
				</CFQUERY> 
				<cflocation url="EditEvents.cfm?PID=#form.ProgramID#" addtoken="No">
		  </cfif>		
		  
		 
  
<cfelseif url.action EQ "UpdateEvent">
<cfset ErrorList = ArrayNew(1)>
		
		<cfif Not IsDefined("Form.ProgramID") OR Len(trim(form.ProgramID)) EQ 0>
			<cflocation url="index.cfm?e=1" addtoken="No">
		</cfif> 
		
		<CFIF Form.Heading is "">
			<cfset x = ArrayAppend(ErrorList, "No value specified for the <b>Heading</b> field")>
		</CFIF>
		
		<CFIF Form.SDate is "" OR (#Form.SDate# is not "" and NOT #IsDate(Form.SDate)#)>
			<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Beginning Date & Time</b> field")>
		</CFIF>
		
		<CFIF Form.EDate is not "" and NOT #IsDate(Form.EDate)#>
			<cfset x = ArrayAppend(ErrorList, "Invalid value specified for the <b>Ending Date & Time</b> field")>
		</CFIF>
		
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
		
			<cfset EndingDate = Form.EDate>
			
			<cfif Form.EDate is "">
				<cfset EndingDate = DateFormat(CreateODBCDate("#Form.SDate#"), "mm/d/yyyy") + "11:59pm">
			</cfif>
			
		    <CFQUERY Name="UpdRec" Datasource="#Application.dsn#">
					UPDATE Events
					SET
						EventName	 = '#Form.Heading#',
						BeginDate	 = #CreateODBCDateTime(Form.SDate)#,
						Location	 = '#Form.Location#',
						Contact		 = '#Form.Contact#',
						EndDate		 = #CreateODBCDateTime(EndingDate)#,
						Phone		 = '#Form.Phone#',
						ContactEmail = '#Form.Email#',
						URL			 = '#Form.WebURL#',
						Description	 = '#Form.Description#'
					WHERE EventID = #Form.EventID#
					AND ProgramID = #form.ProgramID#
				</CFQUERY>
		
		<cflocation url="EditEvents.cfm?PID=#form.ProgramID#" addtoken="No"> 
	</cfif>	
	
	
<cfelseif url.action EQ "RemoveEvent">

    <cfif Not IsDefined("URL.PID") OR Len(trim(URL.PID)) EQ 0>
	    <cflocation url="index.cfm?e=1" addtoken="No">
	</cfif> 
	
	<cfif IsDefined("URL.EventID")>
	   <cfquery name="DeleteEvent" datasource="#Application.dsn#">
	     Delete From Events
		 Where EventID = #url.EventID#
	   </cfquery>
	</cfif>
	
    <cflocation url="EditEvents.cfm?PID=#URL.PID#" addtoken="No">  
	
<cfelseif url.action EQ "Confirm">
       <cfoutput>
		<table border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" colspan=2><font face="tahoma" size="-1"><strong>ARE YOU SURE YOU WANT TO DELETE THIS PROGRAM AND ALL ASSOCIATED CONTENT?</strong></font></td>
			</tr>
			<tr align="center">
			   <td><a href="UpdateProgram.cfm?Action=Remove&PID=#url.PID#">YES</a></td>
			   <td><a href="index.cfm">NO</a></td>
			</tr>
		</table>
       </cfoutput>
<cfelseif url.action EQ "Remove">
    <cfif Not IsDefined("URL.PID") OR Len(trim(URL.PID)) EQ 0>
	    <cflocation url="index.cfm?e=1" addtoken="No">
	</cfif> 
	
	<cfquery name="RemoveEvents" Datasource="#Application.dsn#">
	  Delete From Events
	  Where ProgramID = #URL.PID#
	</cfquery>
	
	<cfquery name="RemoveContent" Datasource="#Application.dsn#">
	  Delete From ProgramContent
	  Where ProgramID = #URL.PID#
	</cfquery>
	
	<cfquery name="RemoveContent" Datasource="#Application.dsn#">
	  Delete From Programs
	  Where ProgramID = #URL.PID#
	</cfquery>
	
	<cflocation url="index.cfm" addtoken="No">
</cfif>
</CFMODULE>

</HTML>