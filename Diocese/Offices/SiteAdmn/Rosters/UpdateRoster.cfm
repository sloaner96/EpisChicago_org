<cfparam name="url.action" default="">

<cfif url.action EQ "Add">
   <!--- Add a member form another Group --->
   <cfif Url.Type EQ "M">
      <cfif Not IsDefined("form.MbrID")>
	    <cflocation url="AddMember.cfm?Type=#Url.Type#&GroupID=#url.GroupID#&e=1" addtoken="No">
	  </cfif>
	  
	  <cfif Not IsDefined("url.GroupID")>
	    <cflocation url="index.cfm?e=1" addtoken="No">
	  </cfif>
	  
	  <cfif Len(form.MbrID) EQ 0>
	    <cflocation url="AddMember.cfm?Type=#Url.Type#&GroupID=#url.GroupID#&e=1" addtoken="No">
	  </cfif>
	  <cfif IsDefined("Form.ISAdmin")>
	    <cfif Len(Trim(form.username)) EQ 0>
		  <cflocation url="AddMember.cfm?Type=#Url.Type#&GroupID=#url.GroupID#&e=2" addtoken="No">
		</cfif>
		<cfif Len(Trim(form.password)) EQ 0>
		  <cflocation url="AddMember.cfm?Type=#Url.Type#&GroupID=#url.GroupID#&e=2" addtoken="No">
		</cfif>
	  </cfif>
	  <!--- Add the Existing Member to the GroupMembers Table --->
	  
	  <cfquery name="GetHighRank" datasource="#Application.dsn#">
	    Select Max(Ranking) as MaxRank 
		From GrpMembers 
		where GroupID = #url.GroupID#
	  </cfquery>
	  
	  <cfif GetHighRank.recordcount GT 0>
	     <cfif GetHighRank.MaxRank NEQ "">
	         <cfset NextRank = GetHighRank.MaxRank + 1>
		 <cfelse>
		    <cfset NextRank = 1>	
		 </cfif>
	  <cfelse>
	     <cfset NextRank = 1>	 
	  </cfif>
	  
	  <cfif IsDefined("form.username")>
		  <cfquery name="AddLogin" datasource="#Application.dsn#">
		    Update Members
			  Set UserName = '#Trim(Form.username)#',
			      pswd = '#Trim(form.Password)#'
			  Where MemberID = #Form.MbrID#	  
		  </cfquery>
	  </cfif>
	  
	  <cfquery name="AddNewMbr" datasource="#Application.dsn#">
	    Insert Into GrpMembers(GroupID, MemberID, IsPrimary, IsAdmin, Ranking)
		Values(#url.GroupID#, #Form.MbrID#, <cfif IsDefined("form.IsPrimary")>1,<cfelse>0,</cfif> <cfif IsDefined("form.IsAdmin")>1,<cfelse>0,</cfif> <cfif IsDefined("form.IsPrimary")>1<cfelse>#NextRank#</cfif>)
	  </cfquery>
	  
	  <cflocation url="index.cfm?groupID=#url.GroupID#" addtoken="No">
   <!--- Add a new Member --->
   <cfelseif Url.Type EQ "N">
      <cfif Len(Trim(Form.firstname)) EQ 0>
	     <cflocation url="AddNewmember.cfm?Type=#Url.Type#&GroupID=#form.GroupID#&E=1" addtoken="No">
	  </cfif>
	  
      <cfif Len(Trim(Form.lastname)) EQ 0>
	    <cflocation url="AddNewmember.cfm?Type=#Url.Type#&GroupID=#form.GroupID#&E=2" addtoken="No">
	  </cfif>
	  
       <cfif Len(Trim(Form.email)) EQ 0 AND Len(Trim(Form.Phone)) EQ 0>
	     <cflocation url="AddNewmember.cfm?Type=#Url.Type#&GroupID=#form.GroupID#&E=3" addtoken="No">
	   </cfif>
	   
	  <cfif IsDefined("form.IsAdmin")>
	     <cfif Len(Trim(form.username)) EQ 0>
		  <cflocation url="AddNewmember.cfm?Type=#Url.Type#&GroupID=#form.GroupID#&E=4" addtoken="NO">
		</cfif>
		<cfif Len(Trim(form.password)) EQ 0>
		  <cflocation url="AddNewmember.cfm?Type=#Url.Type#&GroupID=#form.GroupID#&E=4" addtoken="No">
		</cfif>
	   </cfif>
	   
	  <cfquery name="AddNewMbr" datasource="#Application.dsn#">
	    Insert Into Members(
		    StaffID,
			Title,
		 	Prefix,
			FirstName, 
			MI, 
			LastName, 
			Suffix, 
			Phone,
			FAX,
			Email,
			Address1,
			Address2,
			City,
			State,
			ZipCode,
			UserName,
			pswd,
			LastUpdated
		 )
		Values(
		     <cfif Isdefined("Form.IsStaff")>
			  99,
			 <cfelse>
			   Null, 
			 </cfif>
			  <cfif Len(Trim(form.Title)) GT 0>
			'#Form.Title#',
			<cfelse>
			  Null,
			</cfif>
		    <cfif Len(Trim(form.Prefix)) GT 0>
			'#Form.Prefix#',
			<cfelse>
			  Null,
			</cfif>
			'#Form.Firstname#',
			<cfif Len(Trim(form.MI)) GT 0>
			'#Form.MI#',
			<cfelse>
			  Null,
			</cfif>
			'#Form.Lastname#',
			<cfif Len(Trim(form.Suffix)) GT 0>
			'#Form.suffix#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.Phone)) GT 0>
			'#form.Phone#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.fax)) GT 0>
			'#form.Fax#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.Email)) GT 0>
			'#form.Email#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.address1)) GT 0>
			'#form.Address1#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.address2)) GT 0>
			'#form.Address2#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.city)) GT 0>
			'#form.City#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.state)) GT 0>
			'#form.State#',
			<cfelse>
			  Null,
			</cfif>
			<cfif Len(Trim(form.zipcode)) GT 0>
			'#form.ZipCode#',
			<cfelse>
			  Null,
			</cfif>
			<cfif IsDefined("Form.IsAdmin")>
			  '#form.UserName#',
			  '#form.Password#',
			<cfelse>
			  NULL,
			  NULL,  
			</cfif>
			#CreateodbcDateTime(now())#
		 )
	  </cfquery>
	  
	  <cfquery name="GetMbrID" datasource="#Application.dsn#">
	    Select Max(MemberID) as NewMbrID From Members
	  </cfquery>
	  
	  <cfquery name="GetHighRank" datasource="#Application.dsn#">
	    Select Max(Ranking) as MaxRank 
		From GrpMembers 
		where GroupID = #form.GroupID#
	  </cfquery>
	  
	  <cfif GetHighRank.MaxRank NEQ "">
	     <cfset NextRank = GetHighRank.MaxRank + 1>
	  <cfelse>
	     <cfset NextRank = 1>	 
	  </cfif>
	  
	  <cfquery name="AddNewMbr" datasource="#Application.dsn#">
	    Insert Into GrpMembers(GroupID, MemberID, IsPrimary, IsAdmin, Ranking)
		Values(#Form.GroupID#, #GetMbrID.NewMbrID#, <cfif IsDefined("form.IsPrimary")>1,<cfelse>0,</cfif> <cfif IsDefined("form.IsAdmin")>1,<cfelse>0,</cfif> <cfif IsDefined("form.IsPrimary")>1<cfelse>#NextRank#</cfif>)
	  </cfquery>
	  
	  <cflocation url="index.cfm?GroupID=#form.GroupID#&s=1" addtoken="No">
	 
   </cfif>
<cfelseif url.action EQ "Update">
   <cfif Len(Trim(Form.firstname)) EQ 0>
	     <cflocation url="EditRoster.cfm?ID=#form.mbrID#&Type=#Url.Type#&GroupID=#form.GroupID#&E=1" addtoken="No">
	  </cfif>
	  
      <cfif Len(Trim(Form.lastname)) EQ 0>
	    <cflocation url="EditRoster.cfm?ID=#form.mbrID#&Type=#Url.Type#&GroupID=#form.GroupID#&E=2" addtoken="No">
	  </cfif>
	  
       <cfif Len(Trim(Form.email)) EQ 0 AND Len(Trim(Form.Phone)) EQ 0>
	     <cflocation url="EditRoster.cfm?ID=#form.mbrID#&Type=#Url.Type#&GroupID=#form.GroupID#&E=3" addtoken="No">
	   </cfif>
	   
	  <cfif IsDefined("form.IsAdmin")>
	        <cfif Len(Trim(form.username)) EQ 0>
		      <cflocation url="EditRoster.cfm?ID=#form.mbrID#&Type=#Url.Type#&GroupID=#form.GroupID#&E=4" addtoken="NO">
		    </cfif>
		    <cfif Len(Trim(form.password)) EQ 0>
		      <cflocation url="EditRoster.cfm?ID=#form.mbrID#&Type=#Url.Type#&GroupID=#form.GroupID#&E=4" addtoken="No">
		    </cfif>
	   </cfif>
	   
	   <cfquery name="UpdMember" datasource="#Application.dsn#">
	      Update Members 
		    Set Title = <cfif Len(Trim(form.Title)) GT 0>'#Form.Title#',<cfelse>Null,</cfif>
				Prefix = <cfif Len(Trim(form.Prefix)) GT 0>'#Form.Prefix#',<cfelse>Null,</cfif>
				FirstName ='#Form.Firstname#',
				MI = <cfif Len(Trim(form.MI)) GT 0>'#Form.MI#',<cfelse>Null,</cfif>
				LastName = '#Form.Lastname#', 
				Suffix = <cfif Len(Trim(form.Suffix)) GT 0>'#Form.suffix#',<cfelse>Null,</cfif> 
				Phone =<cfif Len(Trim(form.Phone)) GT 0>'#form.Phone#',<cfelse>Null,</cfif> 
				FAX = <cfif Len(Trim(form.fax)) GT 0>'#form.Fax#',<cfelse>Null,</cfif>
				Email = <cfif Len(Trim(form.Email)) GT 0>'#form.Email#',<cfelse>Null,</cfif>
				Address1 = <cfif Len(Trim(form.address1)) GT 0>'#form.Address1#',<cfelse>Null,</cfif>
				Address2 = <cfif Len(Trim(form.address2)) GT 0>'#form.Address2#',<cfelse>Null,</cfif>
				City = <cfif Len(Trim(form.city)) GT 0>'#form.City#',<cfelse>Null,</cfif>
				State = <cfif Len(Trim(form.state)) GT 0>'#form.State#',<cfelse>Null,</cfif>
				ZipCode = <cfif Len(Trim(form.zipcode)) GT 0>'#form.ZipCode#',<cfelse>Null,</cfif>
				LastUpdated = #CreateODBCDateTime(now())#
		  Where MemberID = #Form.MbrID# 
	   </cfquery>
	   
	   <cfquery name="UpdMember" datasource="#Application.dsn#">
	      Update GrpMembers
		    Set Ranking = #Form.Ranking#
		  Where MemberID = #Form.MbrID# 
		  AND GroupID = #Form.GroupID#
	   </cfquery>
	   <cflocation url="index.cfm?GroupID=#form.GroupID#&s=2" addtoken="No">
<cfelseif url.action EQ "Delete">
       <cfquery name="DeleteUser" datasource="#Application.dsn#">
	     Delete From GrpMembers
		 Where MemberID = #url.ID#
		 AND GroupID = #Url.GroupID#
	   </cfquery>
	 <!---   <cfquery name="DeleteUser" datasource="#Application.dsn#">
	     Delete From Members
		 Where MemberID = #url.ID#
	   </cfquery> --->
	   <cflocation url="index.cfm?GroupID=#url.GroupID#&s=3" addtoken="No">
<cfelse>
     <cflocation url="index.cfm?GroupID=#form.GroupID#&e=1" addtoken="No">
</cfif>