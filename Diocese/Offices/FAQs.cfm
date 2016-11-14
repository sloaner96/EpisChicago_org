<cfquery name="GetFAQ" datasource="#Application.dsn#">
  SELECT F.*, L.CodeDesc
  FROM FAQs F, Lookups L
  WHERE F.GroupID = #Attributes.GroupID#
  AND F.Category = L.CodeValue
  AND L.CodeGroup = 'FAQ'
  Order By L.CodeDesc, F.Ranking
</cfquery>

<blockquote>
<cfif GetFAQ.recordcount GT 0>
 <br>

<table width="80%" border=0 cellspacing=0 cellpadding=0>
<tr valign=top>
	<td>
		<font face="Verdana" size="-1">
		
		<p>This page contains a categorized list of frequently asked questions that might be helpful.</p>
		
		<cfoutput query="getfaq" group="Category">
		
			<table width="100%" border=0>
			<tr bgcolor="##eeeeee"><td width="100%"><font face="tahoma" color="Navy" size="-1"><strong>#CodeDesc#</strong></font></td></tr>
			</table>
			<cfoutput>
			<p><font face="Verdana" size="-1"><b style="color:##cc0033;">#Question#</b><br>#Replace(Response,"#chr(13)##chr(10)#","<br>","ALL")#</font></p>
			</cfoutput>
		
		</cfoutput>
		
		</font>
	</td>
</tr>
</table>
<cfelse>
  <div align="center"><font color="#3333CC" size="-1" face="Verdana"><strong>THERE ARE CURRENTLY NO FAQS FOR THIS GROUP</strong></font></div> 
</cfif>

</blockquote>
