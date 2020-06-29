<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<c:choose>
    <c:when test="${pm.isHaveChild eq 'Y'}">
        <c:choose>
            <c:when test="${not empty pm.iconCls}">
                <div data-options="iconCls:'${pm.iconCls}'">
            </c:when>
            <c:otherwise>
                <div>
            </c:otherwise>
        </c:choose>
            <span>${pm.ffundisplay}</span>
            <div>
                <c:forEach items="${pm.list}" var="pp">
                    <c:set var="pm" value="${pp}" scope="request"></c:set>
                    <jsp:include page="_r.jsp"/>
                </c:forEach>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div onclick="goMenu('${pm.ffundisplay}','${pm.flink}','${pm.ffunid}');">${pm.ffundisplay}</div>
    </c:otherwise>
</c:choose>