<cfquery name="Parishes" datasource="#Application.DSN#" cachedwithin="#CreateTimeSpan(0,1,0,0)#">
	SELECT OrgID, Trim(ParishName+' - '+City) as PName From Directory
		WHERE ParishType IN ('M','P')
		ORDER BY ParishName
</cfquery>

<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-language" CONTENT="en-US">
	<META NAME="rating" CONTENT="General">
	<META NAME="revisit-after" CONTENT="7 days">
	<META NAME="ROBOTS" CONTENT="ALL">
	<META NAME="keywords" CONTENT="episcopal, episcopal church, anglican, communion, diocese, diocesan center, bishop griswold, st. james, cathedral, st. james cathedral, episcopal charities, church, apostolic, christianity, christian, chicago, illinois, IL">
	<META NAME="description" CONTENT="As the Diocese of Chicago, we are called to be a diverse and interactive community, gathered around one table, seeking through continual conversion to have the mind and heart of Christ.">
	<LINK REV=made href="mailto:rpeete@rlpsolutions.com">
	<TITLE>Chicago Diocese -- Contact the Diocese</TITLE>
</head>


<CFMODULE Template="#Application.header#"
	PageTitle="Contact your Diocese"
	SubTitle="65 East Huron Street&nbsp;<b>&middot;</b>&nbsp;Chicago, IL  60611">

<blockquote>
<font face="Verdana" size="-1">

<p>If you have questions about the Diocese or its ministries,  or if you just want to communicate some comments about us or this web site, please take a moment to share your thoughts with us.</p>
<p>Fill in your complete name, address, daytime phone number, and email address (if you have one).  We need this information to be able respond back to you in a timely manner.  Then type in your message -- the textbox below will scroll to accommodate as long a message as you need to express your inquiry fully.</p>

<cfform name="GetInq" action="inquiry.cfm" method="POST">

<center>
<table border="0" cellspacing="0" cellpadding="1" bgcolor="#F3F3F3">
<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Name:</b></font></td>
	<td width=*><cfinput type="text" name="Name" size=30 maxlength=50 required="Yes" message="Please enter your name so we know who to respond back to"></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Address:</b></font></td>
	<td width=*><cfinput type="text" name="Address" size=30 maxlength=30></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>City:</b></font></td>
	<td width=*>
		<cfinput type="text" name="City" size=20 maxlength=30>  
		<font face="Verdana" size="-1"><b>State:</b></font> <cfinput type="text" name="State" size=2 maxlength=2>
	</td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Zipcode:</b></font></td>
	<td width=*><cfinput type="text" name="Zipcode" size=10 maxlength=10></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Phone:</b></font></td>
	<td width=*><cfinput type="text" name="Phone" size=20 maxlength=20></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Email&nbsp;Address:</b></font></td>
	<td width=*><cfinput type="text" name="Email" size=30 maxlength=130></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Home Parish:</b></font></td>
	<td width=*><cfselect name="Parish" size=1 query="Parishes" display="PName" value="PName" required="no"><option selected value="None Specified">--- None selected ---</option></cfselect></td>
</tr>

<tr>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Subject:</b></font></td>
	<td width=*>
		<cfselect name="Subject" size="1" required="Yes" Message="A Subject must be selected">
		<option value="" selected>--- Select a topic ---</option>
		<option value="Parish Info">Requesting information on parishes within the Diocese</option>
		<option value="Faith Q&A">Questions about the Episcopal Faith</option>
		<option value="Youth Ministry">Information on Youth/Young Adult Ministry</option>
		<option value="Re-Development">Comments on the Church Center Redevelopment</option>
		<option value="Cathedral">Inquiry about St. James Cathedral</option>
		<option value="Feedback">Feedback about the web site</option>
		<option value="Other Topic">Another Topic</option>
		</cfselect>
	</td>
</tr>

<tr valign=top>
	<td width=120 align=left><font size="-1" face="Verdana"><b>Comments:</b></font></td>
	<td width=*><textarea name="Message" cols="35" rows="8" wrap="VIRTUAL"></textarea></td>
</tr>

<tr valign=top>
	<td align=center colspan=2><br><input type="Submit" value="Send My Message Now!">&nbsp;&nbsp;&nbsp;<input type="Reset" value="Clear Form"></td>
</tr>
</table>
</center>

</cfform>


<br>
<p align=center><i>This site is operated by the Office of Communications, Diocese of Chicago.</i></p>

</font>
</blockquote>

</CFMODULE>
</HTML>
