<cfparam name="url.action" default="">
<cfparam name="url.e" default="">
<HTML>
<HEAD>
	<cfoutput>
	<TITLE>#Application.SiteNfo.AppName#: Group Programs</TITLE>
	</cfoutput>
</HEAD>
<cfquery name="MyPrograms" datasource="#Application.dsn#">
   Select P.ProgramID, P.Title, P.begindate, P.enddate, G.Highlight
   From Programs P, GrpPrograms G
   Where G.ProgramID = P.ProgramID
   AND G.GroupID = #url.GroupID# 
   AND Approved = True
</cfquery> 

<cfquery name="GetPrograms" datasource="#Application.dsn#">
   Select ProgramID, Title, begindate, enddate
   From Programs
   where  Approved = True
   <cfif MyPrograms.recordcount GT 0>
    AND ProgramID NOT IN (#valuelist(MyPrograms.ProgramID, ",")#)
   </cfif>
</cfquery> 



<CFMODULE Template="#Application.Header#"  Section="Admin" PageTitle="Site Administration" SubTitle="Group Programs">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
   <td>
	<cfif url.action EQ "ADD">
	    <cfif form.program EQ "">
	      <cflocation url="programs.cfm?e=1" addtoken="NO">
	    </cfif>
	   
	   <cfquery name="Addprogram" datasource="#Application.dsn#">
	      Insert Into GrpPrograms(
		          GroupID, 
				  ProgramID, 
				  Highlight, 
				  AddedBy, 
				  LastUpdated
				  )
		  Values  ( #Url.GroupID#, 
		            #form.Program#,
					#form.Highlight#,
					#Session.UserID#,
					#Createodbcdatetime(now())#
				  )
	   </cfquery> 
	   
	   <table border="0" cellpadding="3" cellspacing="0" width="100%">
         <tr>
            <td align="center"><font face="tahoma" color="#009900" size="-1"><strong>THIS PROGRAM WAS SUCCESSFULLY ADDED TO YOUR GROUPS SUBSITE.</strong></font></td>
         </tr>
		 <tr>
		   <td>&nbsp;</td>
		 </tr>
		 <cfoutput>
		   <tr>
		      <td align="center"><font face="arial" size="-1"><a href="index.cfm?groupID=#url.groupID#">Click Here</a> to administer more programs</font></td>
		   </tr>
		 </cfoutput>
       </table>
	<cfelseif url.action EQ "REMOVE">
	   <cfif url.ProgID EQ "">
	        <cflocation url="programs.cfm?e=2" addtoken="NO">
	   </cfif>
	   <cfquery name="RemoveProgram" datasource="#Application.dsn#">
	      Delete From GrpPrograms
		  Where ProgramID = #url.ProgID#
		  AND GroupID = #url.GroupID#
	   </cfquery> 
	   <table border="0" cellpadding="3" cellspacing="0" width="100%">
         <tr>
            <td align="center"><font face="tahoma" color="#0033ff" size="-1"><strong>THIS PROGRAM WAS SUCCESSFULLY REMOVED FROM GROUPS SUBSITE.</strong></font></td>
         </tr>
		  <tr>
		   <td>&nbsp;</td>
		 </tr>
		 <cfoutput>
		   <tr>
		      <td align="center"><font face="arial" size="-1"><a href="index.cfm?groupID=#url.groupID#">Click Here</a> to administer more programs</font></td>
		   </tr>
		 </cfoutput>
       </table>
	<cfelse>
	  
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
		  <tr>
		      <td><font face="arial" size="-1">Add the upcoming or currently active programs to this group subsite below. To add a new program <a href="/admin/programs/index.cfm">click here</a></font></td>
		  </tr>
		  <tr>
		    <td>&nbsp;</td>
		  </tr> 
		  <cfif GetPrograms.recordcount GT 0>
			  <cfif url.e EQ 1>
			    <tr>
				  <td><font face="verdana" size="-2" color="##cc0000"><strong>Error! You must choose a program to add to your subsite.</strong></font></td>
				</tr>
			  </cfif>
			  <tr>
			    <td><font face="arial" size="-1"><strong>Select a Program to Add:</strong></font></td>
			  </tr>
			  <cfform name="addprogram" action="index.cfm?action=Add&GroupID=#url.groupID#" method="POST">
				  <tr>
				    <td><select name="Program">
					        <option value="">--- Select One ---</option>
					       <cfoutput query="GetPrograms">
							<option value="#GetPrograms.ProgramID#">#dateformat(GetPrograms.begindate, 'mm/dd/yy')#-#dateformat(GetPrograms.enddate, 'mm/dd/yy')#: #GetPrograms.Title#</option>
					       </cfoutput>
					    </select>
				    </td>
				  </tr>
				  <tr>
				    <td><font face="arial" size="-1">Do you want to highlight this program on your site?</font> <font face="verdana" size="-2"><strong><input type="radio" name="Highlight" value="1"> YES <input type="radio" name="Highlight" value="0" checked> NO</strong></font></td>
				  </tr>
				  <tr>
				    <td>&nbsp;</td>
				  </tr>
				  <tr>
				    <td><input type="submit" name="submit" value="Add Program >>"></td>
				  </tr>
			  </cfform>
		  <cfelse>
		    <tr>
			  <td align="center"><font face="verdana" size="-1"><strong>There are currently no active programs to add to your subsite.</strong></font></td>
			</tr>	
			<tr>
			  <td>&nbsp;</td>
			</tr>  
		  </cfif>
		  <cfif MyPrograms.recordcount GT 0>
			  <tr>
			    <td><hr noshade size=1></td>
			  </tr>
			  <tr>
			    <td><font face="tahoma" color="#000066" size="-1"><strong>PROGRAMS ON YOUR GROUP SUBSITE</strong></font></td>
			  </tr>
			  <cfif url.e EQ 1>
		        <tr>
			        <td><font face="verdana" size="-2" color="##cc0000"><strong>Error! You must choose a program to remove from your subsite.</strong></font></td>
			    </tr>
		      </cfif>
			  <tr>
			    <td>
				   <table border="0" cellpadding="3" cellspacing="1" width="100%">
			         <tr bgcolor="eeeeee">
					    <td width="1%"><font face="arial" size="-1"><strong>Highlighted</strong></font></td>
			            <td width="30%" align="center"><font face="arial" size="-1"><strong>Begin Date - End Date</strong></font></td>
						<td width="39%"><font face="arial" size="-1"><strong>Title</strong></font></td>
						<td width="30%"><font face="arial" size="-1"><strong>Action</strong></font></td>
			          </tr>
					  <tr>
					    <td colspan=5>
						  <table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
							    <td bgcolor="#000000" ><img src="/images/blank.gif" width="1" height="1" border="" alt=""></td>
							</tr>
						  </table>
						</td>
					  </tr>
					  <cfoutput query="MyPrograms">
					  <tr>
					    <td width="1%" align="center"><cfif MyPrograms.Highlight EQ 1><font face="verdana" size="-1"><strong>*</strong></font></cfif></td>
					
						<td width="30%" align="center"><font face="verdana" size="-1">#DateFormat(MyPrograms.BeginDate, 'MM/DD/YY')# - #DateFormat(MyPrograms.EndDate, 'MM/DD/YY')#</font></td>
						<td width="39%"><font face="verdana" size="-1">#MyPrograms.Title#</font></td>
						<td width="30%"><font face="verdana" size="-2"><a href="index.cfm?action=remove&ProgID=#MyPrograms.ProgramID#&GroupID=#url.groupID#" style="font-color:red;">[REMOVE FROM SITE]</a></font></td>
					  </tr>
					  </cfoutput>
			       </table>
				</td>
			  </tr>
		  </cfif>
		</table>
	</cfif>
	</td>
  </tr>
</table>
</CFMODULE>

</HTML>