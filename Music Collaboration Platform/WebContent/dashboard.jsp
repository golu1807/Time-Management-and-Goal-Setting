<%@ page import="User"%>
<%@ page session="true" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
</head>
<body>
    <div class="dashboard">
      <h2>Welcome, <%=((User)session.getAttribute("user")).getName()%>!</h2>
      <p>Role: <%=((User)session.getAttribute("user")).getRole()%></p>
      <div>
        <h3>Collaboration Projects</h3>
        <ul>
          <li>Demo Project - Track 1</li>
          <li>Demo Project - Track 2</li>
        </ul>
      </div>
      <button onclick="notify('New collab started!')">Show Notification</button>
    </div>
</body>
</html>
