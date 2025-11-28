<html>
<body>
    <h1>Goals</h1>
    <ul>
        <c:forEach var="goal" items="${goals}">
            <li>${goal.description} - <c:choose>
                <c:when test="${goal.isCompleted}">Completed</c:when>
                <c:otherwise>Pending</c:otherwise>
            </c:choose></li>
        </c:forEach>
    </ul>
</body>
</html>
