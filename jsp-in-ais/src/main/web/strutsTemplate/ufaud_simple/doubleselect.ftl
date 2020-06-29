<#if parameters.firstName?exists>
	<span<#rt/>
<#if parameters.firstNameId?exists>
	id="${parameters.firstNameId}"<#rt/>
</#if>
<#if parameters.firstNameCssStyle?exists>
	style="${parameters.firstNameCssStyle}"<#rt/>
</#if>
<#if parameters.firstNameCssClass?exists>
	class="${parameters.firstNameCssClass}"<#rt/>
</#if>
>${parameters.firstName}</span>
</#if>
<#include "/${parameters.templateDir}/ufaud_simple/select.ftl" />
<#assign startCount = 0/>
<#if parameters.headerKey?exists && parameters.headerValue?exists>
    <#assign startCount = startCount + 1/>
</#if>
<#if parameters.emptyOption?exists>
    <#assign startCount = startCount + 1/>
</#if>
<#-- Delete line_break LIHAIFENG 2007-10-30 -->
<#if parameters.secondName?exists>
	<span<#rt/>
<#if parameters.secondNameId?exists>
	id="${parameters.secondNameId}"<#rt/>
</#if>
<#if parameters.secondNameCssStyle?exists>
	style="${parameters.secondNameCssStyle}"<#rt/>
</#if>
<#if parameters.secondNameCssClass?exists>
	class="${parameters.secondNameCssClass}"<#rt/>
</#if>
>${parameters.secondName}</span>
</#if>
<select<#rt/>
 name="${parameters.doubleName?default("")?html}"<#rt/>
<#if parameters.disabled?default(false)>
 disabled="disabled"<#rt/>
</#if>
<#if parameters.doubleTabindex?exists>
 tabindex="${parameters.doubleTabindex?html}"<#rt/>
</#if>
<#if parameters.doubleId?exists>
 id="${parameters.doubleId?html}"<#rt/>
</#if>
<#if parameters.doubleCss?exists>
 class="${parameters.doubleCss?html}"<#rt/>
</#if>
<#if parameters.doubleStyle?exists>
 style="${parameters.doubleStyle?html}"<#rt/>
</#if>
<#if parameters.doubleDisabled?default(false)>
 disabled="disabled"<#rt/>
</#if>
<#if parameters.title?exists>
 title="${parameters.title?html}"<#rt/>
</#if>
<#if parameters.multiple?default(false)>
 multiple="multiple"<#rt/>
</#if>
<#if parameters.get("doubleSize")?exists>
 size="${parameters.get("doubleSize")?html}"<#rt/>
</#if>
>
</select>
<script type="text/javascript">
<#assign itemCount = startCount/>
    var ${parameters.id}Group = new Array(${parameters.listSize} + ${startCount});
    for (i = 0; i < (${parameters.listSize} + ${startCount}); i++)
    ${parameters.id}Group[i] = new Array();

<@s.iterator value="parameters.list">
    <#if parameters.listKey?exists>
        <#assign itemKey = stack.findValue(parameters.listKey)/>
    <#else>
        <#assign itemKey = stack.findValue('top')/>
    </#if>
    <#if parameters.listValue?exists>
        <#assign itemValue = stack.findString(parameters.listValue)/>
    <#else>
        <#assign itemValue = stack.findString('top')/>
    </#if>
    <#assign doubleItemCount = 0/>
    <@s.iterator value="${parameters.doubleList}">
        <#if parameters.doubleListKey?exists>
            <#assign doubleItemKey = stack.findValue(parameters.doubleListKey)/>
        <#else>
            <#assign doubleItemKey = stack.findValue('top')/>
        </#if>
        <#assign doubleItemKeyStr = doubleItemKey.toString() />
        <#if parameters.doubleListValue?exists>
            <#assign doubleItemValue = stack.findString(parameters.doubleListValue)/>
        <#else>
            <#assign doubleItemValue = stack.findString('top')/>
        </#if>
    ${parameters.id}Group[${itemCount}][${doubleItemCount}] = new Option("${doubleItemValue}", "${doubleItemKeyStr}");

        <#assign doubleItemCount = doubleItemCount + 1/>
    </@s.iterator>
    <#assign itemCount = itemCount + 1/>
</@s.iterator>

    var ${parameters.id}Temp = document.${parameters.formName}['${parameters.doubleName}'];
<#assign itemCount = startCount/>
<#assign redirectTo = 0/>
<@s.iterator value="parameters.list">
    <#if parameters.listKey?exists>
        <#assign itemKey = stack.findValue(parameters.listKey)/>
    <#else>
        <#assign itemKey = stack.findValue('top')/>
    </#if>
    <#if tag.contains(parameters.nameValue, itemKey)>
        <#assign redirectTo = itemCount/>
    </#if>
    <#assign itemCount = itemCount + 1/>
</@s.iterator>
    ${parameters.id}Redirect(${redirectTo});
    function ${parameters.id}Redirect(x) {
    	var selected = false;
        for (m = ${parameters.id}Temp.options.length - 1; m >= 0; m--) {
            ${parameters.id}Temp.options[m] = null;
        }
        
        <#if parameters.display?default(true)>
            if(${parameters.id}Group[x].length==0){
	        	${parameters.id}Temp.style.display="none";
	        }else{
	        	${parameters.id}Temp.style.display="inline";
	        }
        </#if>

        for (i = 0; i < ${parameters.id}Group[x].length; i++) {
            ${parameters.id}Temp.options[i] = new Option(${parameters.id}Group[x][i].text, ${parameters.id}Group[x][i].value);
            <#if parameters.doubleNameValue?exists>
            	if (${parameters.id}Temp.options[i].value == '${parameters.doubleNameValue}') {
            		${parameters.id}Temp.options[i].selected = true;
            		selected = true;
            	}
            </#if>
        }

        if ((${parameters.id}Temp.options.length > 0) && (! selected)) {
           	${parameters.id}Temp.options[0].selected = true;
        }
    }
</script>
<#if parameters.doubleDisabled?default(false)>
<input type="hidden" id="${parameters.doubleId?html}" name="${parameters.doubleName?default("")?html}" value="${parameters.doubleNameValue?default("")}"></input>
</#if>