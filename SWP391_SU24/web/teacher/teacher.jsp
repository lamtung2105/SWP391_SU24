<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="semester" value="${empty param.semester ? -1 : param.semester}"></c:set>
    <!DOCTYPE html>

    <style>
        .filter-btn {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .filter-button {
            background-color: #eaeaea;
            color: #333333;
            border: none;
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
        }

        .filter-button:hover {
            background-color: #d4d4d4;
        }

        .filter-button.selected {
            background-color: #333333;
            color: #ffffff;
        }

        .title {
            display: flex;
            align-content: flex-start;
            align-items: center;
            justify-content: center;
        }
        .title a{
            padding: 10px 20px;
            border-radius: 4px;
            background-color: #99ff66;
        }

    </style>

    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/headCommon.jspf" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">  
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="/components/header.jspf" %>
        <div class="grid">
            <div class="admin-sidebar">
            </div>
            <div class="admin-content">
                <div class="form-container">
                    <div class="title">
                        <h1>Your Courses</h1>
                    </div>
                    <div class="filters">
                        <form method="get" action="${pageContext.request.contextPath}/teacher">
                            <div>
                                Semesters:
                                <select name="semester" value="${empty param.semester ? -1 : param.semester}" onchange="this.form.submit()">
                                    <option value="-1">All</option>
                                    <c:forEach var="item" items="${semesters}">
                                        <option value="${item.id}" ${semester == item.id ? "selected" : ''} >
                                            ${item.description}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th class="cel-1">Courses</th>
                                <th>Options</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${courses}" var="x">
                                <tr>
                                    <td>
                                        <div class="course-inf">
                                            <img src="${x.imgUrl}" alt="courseImage"/>
                                            <div class="inf">
                                                <p>${x.title}-${x.description}</p>
                                                <small>Publish Date: ${x.publishDate}</small><br>
                                                <small>Lecturer: ${x.lecturer}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="options">
                                            <a href="${pageContext.request.contextPath}/teacher/view-course?courseId=${x.id}"><i class="fa-solid fa-pen-to-square"></i>View</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>       
        </div>
        <%@include file="/components/footer.jspf" %>
    </body>
</html>