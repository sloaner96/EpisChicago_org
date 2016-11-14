<cfquery name="ConfNfo" datasource="#Application.DSN#">
	SELECT * From Conferences
		WHERE ConfID = 2
</cfquery>
<cfquery name="Courses" datasource="#Application.DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
SELECT * From Workshops
		WHERE ConfID = 2
		ORDER BY CourseNbr
</cfquery>
<cfquery name="Parishes" datasource="#Application.DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		ORDER BY ParishName
</cfquery>


<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="workshops, conferences, seminars, episcopal, episcopal church, diocese, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<cfoutput><TITLE>Chicago Diocese -- #ConfNfo.ConfName# Registration</TITLE></cfoutput>
</head>

<cfmodule template="#Application.header#" NavAlign="center" Banner="No">

<blockquote>	

<cfoutput query="ConfNfo">
<cfif LogoImage neq ""><a href="#HomeURL#"><img src="/images/#LogoImage#" alt="" border="0" align=right></a></cfif>
<p align=center>
<font color="Blue" face="Tahoma,Arial" size="+3">
#ConfName#
</font><br><br>

<cfif Theme neq "">
	<font color="Navy" face="Tahoma,Arial" size="+1">
	<i>#Theme#</i>
	</font><br><br>
</cfif>

<font face="Tahoma" color="Maroon" size="+2">Workshop Registration</font><br>
<font face="Verdana" color="black" size="-1">
<a href="#HomeURL#">Home</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="Workshops.cfm">Workshop Descriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;
<a href="Register.cfm">Register online!</a>
</font>
</p><br clear=all>

</cfoutput>

<FONT SIZE="-1" face="Verdana,Arial">

<cfif DateCompare(now(), ConfNfo.RegDeadline, "d") le 0>
<cfoutput><p>Please fill out the interactive form below to register for this workshop.  Fill in your complete name, address, daytime phone number, and home parish.  Then select the breakout sessions you would like to attend.  Finally, identify if you would like lunch provided and whether or not you require childcare.  <i>(If you prefer to register via postal mail, click <a href="/Forms#ConfNfo.RegForm#">here</a> for a printable PDF form to fill out.)</i></p></cfoutput>

<cfform name="Register" action="RegConfirmation.cfm" method="POST">
<input type="hidden" name="ConfID" value="2">

<table border=0 cellpadding=1 cellspacing=0>
<tr>
	<td colspan=2><font face="Tahoma,Arial" color="navy" size="+1">Participant Information</font></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Name</b>:</font></td>
	<td width=*><cfinput type="text" name="Name" size=30 maxlength=40 required="yes" message="Your name is required!"></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Address</b>:</font></td>
	<td width=*><input type="text" name="Address" size=30 maxlength=40></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>City</b>:</font></td>
	<td width=*><cfinput type="text" name="City" size=20 maxlength=30 required="yes" message="Your city is required!">  <font face="Verdana,Arial" size="-1"><b>State</b>:</font> <input type="text" name="State" size=2 maxlength=2>  <font face="Verdana,Arial" size="-1"><b>Zip</b>:</font> <input type="text" name="Zipcode" size=10 maxlength=10></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Day Phone</b>:</font></td>
	<td width=*><cfinput type="text" name="Phone" size=20 maxlength=20></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Email&nbsp;Address</b>:</font></td>
	<td width=*><input type="text" name="Email" size=35 maxlength=80></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Home Parish</b>:</font></td>
	<td width=*><cfselect name="Parish" size=1 query="Parishes" display="PName" value="OrgID" required="no"><option selected value="*">--- Select one ---</option></cfselect></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Ministry&nbsp;Interest</b>:</font></td>
	<td width=*><input type="text" name="Interest" size=30 maxlength=40></td>
</tr>

<tr>
	<td colspan=2><br><font face="Tahoma,Arial" color="navy" size="+1">Workshop Courses</font></td>
</tr>

<cfloop index="Nbr" from="1" to="#ConfNfo.NSessions#">
<tr valign=top>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><cfoutput><b>Choice ###Nbr#</b>:</cfoutput></font></td>
	<td width=*><cfselect name="Session#Nbr#" size=1 query="Courses" display="Workshop" value="CourseNbr" required="yes" message="You must select a workshop for choice ###Nbr#"><option selected value="*">--- Select a workshop ---</option></cfselect></td>
</tr>
</cfloop>

<cfif ConfNfo.MealOffered neq "">
<tr>
	<td colspan=2><br><br><font face="Verdana,Arial" size="-1">Please check the radio button below to identify the type of lunch you desire.  Lunch will include a deli sandwich, salad, pretzels, cookies, and a beverage.</font></td>
</tr>
<tr valign=top>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Lunch Choice</b>:</font></td>
	<td width=*>
		<font face="Verdana" size="-1">
		<input type="Radio" name="Meal" value="Meat" >Meat<br>
		<input type="Radio" name="Meal" value="Vegetarian" >Vegetarian
		</font>
	</td>
</tr>
</cfif>

<cfif ConfNfo.DayCare is True>
<tr>
	<td colspan=2><br><cfoutput><font size="-1" face="Verdana,Arial">If you are interested in childcare, please list the ages of your children.  You must register by #DateFormat(ConfNfo.RegDeadline, "mmmm d")# to assure arrangements can be made.  <i>You will need to provide/bring lunch for your children.</i></font></cfoutput></td>
</tr>
<tr>
	<td width=110 align=left><font size="-1" face="Verdana"><b>Child Ages</b>:</font></td>
	<td width=*>
		<font face="Verdana" size="-1">
		<cfinput type="text" name="Infant"  validate="integer" size=2 maxlength=2> Infants
		<cfinput type="text" name="Toddler" validate="integer" size=2 maxlength=2> Toddler
		<cfinput type="text" name="Age3to5" validate="integer" size=2 maxlength=2> 3-5 yrs
		<cfinput type="text" name="Age6to8" validate="integer" size=2 maxlength=2> 6-8 yrs
		<cfinput type="text" name="Age9up"  validate="integer" size=2 maxlength=2> 9 & up
		</font>
	</td>
</tr>
</cfif>

<tr>
	<td colspan=2><br><br><input type="Submit" value="Register Now!">&nbsp;&nbsp;&nbsp;<input type="Reset" value="Clear Form"></td>
</tr>
</table>

</cfform>

<cfelse>
	<cfoutput query="ConfNfo"><p>I'm sorry but the registration deadline of #DateFormat(RegDeadline, "mmmm d, yyyy")# has passed.  No additional registrations for this workshop are being accepted.  If you have questions, please contact #ContactName# at #Phone# or via email at <a href="mailto:#Email#">#Email#</a>.</p></cfoutput>
</cfif>


</font>
</blockquote>
</cfmodule>

</HTML>
