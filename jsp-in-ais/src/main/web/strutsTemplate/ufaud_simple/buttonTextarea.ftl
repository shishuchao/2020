
<#include "/${parameters.templateDir}/simple/textarea.ftl" />
<#if parameters.hiddenName?exists>
    <input type="hidden" name="${parameters.hiddenName?html}"<#rt/>
    <#if parameters.hiddenId?exists>
    	id="${parameters.hiddenId?html}"<#rt/>
    </#if>
    <#if parameters.hiddenNameValue?exists>
	 		value="<@s.property value="parameters.hiddenNameValue"/>"<#rt/>
		</#if>
    <#if parameters.hiddenValue?exists>
   		value="${parameters.hiddenValue?html}"<#rt/>
    </#if>/><#t/>
</#if>
<#if parameters.doubleDisabled?default(false)==false>
<img <#rt/>
<#if parameters.doubleTitle?exists>
 title="${parameters.doubleTitle?html}"<#rt/>
</#if>
<#if parameters.doubleCssClass?exists>
 class="${parameters.doubleCssClass?html}"<#rt/>
</#if>
<#if parameters.doubleValue?exists>
 value="${parameters.doubleValue?html}"<#rt/>
</#if>
<#if parameters.doubleCssStyle?exists>
 style="${parameters.doubleCssStyle?html}"<#rt/>
</#if>
<#if parameters.doubleSrc?exists>
 src="${parameters.doubleSrc?html}"<#rt/>
</#if>
<#if parameters.doubleOnclick?exists>
 	onclick="${parameters.doubleOnclick}"<#rt/>
</#if><#t/>

    <#if parameters.doubleOndblclick?exists><#t/>
    ondblclick="${parameters.doubleOndblclick?html}"
    </#if><#t/>
    <#if parameters.doubleOnmousedown?exists><#t/>
    onmousedown="${parameters.doubleOnmousedown?html}"
    </#if><#t/>
    <#if parameters.doubleOnmouseup?exists><#t/>
    onmouseup="${parameters.doubleMnmouseup?html}"
    </#if><#t/>
    <#if parameters.doubleOnmousemove?exists><#t/>
    onmousemove="${parameters.doubleOnmousemove?html}"
    </#if><#t/>
    <#if parameters.doubleOnmouseout?exists><#t/>
    onmouseout="${parameters.doubleOnmouseout?html}"
    </#if><#t/>
    <#if parameters.doubleOnfocus?exists><#t/>
    onfocus="${parameters.doubleOnfocus?html}"
    </#if><#t/>
    <#if parameters.doubleOnblur?exists><#t/>
    onblur="${parameters.doubleOnblur?html}"
    </#if><#t/>
    <#if parameters.doubleOnkeypress?exists><#t/>
    onkeypress="${parameters.doubleOnkeypress?html}"
    </#if><#t/>
    <#if parameters.doubleOnKeydown?exists><#t/>
    onkeydown="${parameters.doubleOnkeydown?html}"
    </#if><#t/>
    <#if parameters.doubleOnkeyup?exists><#t/>
    onkeyup="${parameters.doubleOnkeyup?html}"
    </#if><#t/>
    <#if parameters.doubleOnselect?exists><#t/>
    onselect="${parameters.doubleOnselect?html}"
    </#if><#t/>
    <#if parameters.doubleOnchange?exists><#t/>
    onchange="${parameters.doubleOnchange?html}"
    </#if><#t/>
    <#if parameters.doubleAccesskey?exists><#t/>
    accesskey="${parameters.doubleAccesskey?html}"
    </#if>
><#if parameters.label?exists><@s.property value="parameters.label"/><#rt/></#if></img></#if>