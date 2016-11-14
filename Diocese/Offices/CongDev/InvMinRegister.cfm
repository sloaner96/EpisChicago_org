<cfquery name="Courses" datasource="#Application.DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
SELECT * From Workshops
		WHERE ConfID = 1
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
	<META NAME="keywords" CONTENT="Congregational development, evangelism, workshops, conference, tim hall, episcopal, episcopal church, diocese, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Invitational Ministry Workshop Registration</TITLE>
</head>

<cfmodule template="#Application.header#" NavAlign="center" Banner="No">

<blockquote>	

<a href="InvMinistry.cfm"><img src="/images/Cow.gif" width=133 height=169 alt="" border="0" align=left></a>
<p align=center>
<font color="Blue" face="Tahoma" size="+2">
"Leaving the Table"
</font><br><br>

<font color="Navy" face="Tahoma" size="+1">
<i>GATEWAYS TO EVANGELISM</i>
</font><br><br>

<font face="Tahoma" color="Navy" size="+3">Workshop Registration</font><br>
<font face="Verdana" color="black"><a href="InvLeaders.cfm">Leader Biographies</a> | <a href="InvWorkshops.cfm">Workshop Descriptions</a></font>
</p><br clear=all>

<FONT SIZE="-1" face="Verdana,Arial">

<p>Please fill out the interactive form below to register for this workshop.  Fill in your complete name, address, daytime phone number, and home parish.  Then select the breakout sessions you would like to attend.  Finally, identify if you would like lunch provided and whether or not you require childcare.  <i>(If you prefer to register via postal mail, click <a href="/Forms/InvMinistry.pdf">here</a> for a <a href="/Forms/InvMinistry.pdf">printable PDF form</a> to fill out.)</i></p>

<cfform name="Register" action="InvRegConfirmation.cfm" method="POST">

<table border=0 cellpadding=1 cellspacing=0 width="90%">
<tr>
	<td colspan=2><font face="Tahoma,Arial" color="navy" size="+1">Participant Information</font></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Name</b>:</font></td>
	<td width=*><cfinput type="text" name="Name" size=30 maxlength=40 required="yes"></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Address</b>:</font></td>
	<td width=*><input type="text" name="Address" size=30 maxlength=40></td>
</tr>

<tr>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>City</b>:</font></td>
	<td width=*><cfinput type="text" name="City" size=20 maxlength=30 required="yes">  <font face="Verdana,Arial" size="-1"><b>State</b>:</font> <input type="text" name="State" size=2 maxlength=2>  <font face="Verdana,Arial" size="-1"><b>Zip</b>:</font> <input type="text" name="Zipcode" size=10 maxlength=10></td>
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
	<td colspan=2><br><font face="Tahoma,Arial" color="navy" size="+1">Workshop Courses</font></td>
</tr>

<tr valign=top>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Morning</b>:</font></td>
	<td width=*><cfselect name="MSession" size=1 query="Courses" display="Workshop" value="Workshop" required="yes" message="You must select a workshop"><option selected value="*">--- Select a morning workshop ---</option></cfselect></td>
</tr>

<tr valign=top>
	<td width=110 align=left><font size="-1" face="Verdana,Arial"><b>Afternoon</b>:</font></td>
	<td width=*><cfselect name="ASession" size=1 query="Courses" display="Workshop" value="Workshop" required="yes" message="You must select a workshop"><option selected value="*">--- Select an afternoon workshop ---</option></cfselect></td>
</tr>

<tr>
	<td colspan=2><br><br><font face="Verdana,Arial" size="-1">Please check the radio button below if you want to order a lunch prepared by the Area-wide Youth Ministries at a cost of $10.00 each.  Lunch will include sandwich, chips, fruit, dessert and beverage. A percent of the cost of lunch is being donated to the Area-wide Ministries' Appalachia Service Project Fund.</font></td>
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

<tr>
	<td colspan=2><br><br><font size="-1" face="Verdana,Arial">If you are interested in childcare, please list the ages of your children.  You must register by April 23rd to assure arrangements can be made.</font></td>
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

<tr>
	<td colspan=2><br><br><input type="Submit" value="Register Now!">&nbsp;&nbsp;&nbsp;<input type="Reset" value="Clear Form"></td>
</tr>
</table>

</cfform>


</font>
</blockquote>
</cfmodule>

</HTML>
