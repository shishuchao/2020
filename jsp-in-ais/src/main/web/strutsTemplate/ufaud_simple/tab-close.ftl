<#-- Set the tag is or not display@LIHAIFENG www.ufaud.com@lihf@ufaud.com -->
<#if parameters.display?exists>
	<#assign x="${parameters.display?html}"/>
</#if>
<#if x?exists&&x=="false">
	<#stop "display"/>
</#if>
<#-- Set the tag is or not display@LIHAIFENG www.ufaud.com@lihf@ufaud.com -->
</div>