<%-- 
    Document   : manage
    Created on : May 30, 2023, 9:21:58 AM
    Author     : Viet
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="level" value="${empty param.level ? -1 : param.level}"></c:set>
<c:set var="category" value="${empty param.category ? -1 : param.category}"></c:set>
<c:set var="duration" value="${empty param.duration ? '0-0' : param.duration}"></c:set>
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
                <%@include file="/components/adminNavBar.jspf" %>
                <div class="admin-content">
                    <div class="form-container">
                        <div class="title">
                            <h1>Courses Management</h1> 
                        </div>
                        <%@include file="/components/searchBar.jspf" %>
                        <div class="filters">
                            <div>
                                Categories:  
                                <select name="category" value="${empty param.category ? -1 : param.category}" onchange="applyFilter('category', event.target.value)">
                                    <option value="-1">All</option>
                                    <c:forEach var="item" items="${categories}">
                                        <option value="${item.id}" ${category == item.id ? 'selected' : ''}> ${item.description}</option>  
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                Levels:
                                <select name="level" value="${empty param.level ? -1 : param.level}" onchange="applyFilter('level', event.target.value)">
                                    <option value="-1">All</option>
                                    <c:forEach var="item" items="${levels}">
                                        <option value="${item.id}" ${level == item.id ? "selected" : ''} >
                                            ${item.description}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div>
                                Durations:
                                <select name="duration" value="${empty param.duration ? "0-0" : param.duration}" onchange="applyFilter('duration', event.target.value)">
                                    <option value="0-0">All</option>
                                    <option value="0-36000" ${duration == "0-36000" ? "selected" : ''}>Less than 10 hours</option>
                                    <option value="36000-108000" ${duration == "36000-108000" ? "selected" : ''}>10-30 hours</option>
                                    <option value="108000-216000" ${duration == "108000-216000" ? "selected" : ''}>30-60 hours</option>
                                    <option value="216000-0" ${duration == "216000-0" ? "selected" : ''}>More than 60 hours</option>
                                </select>
                            </div>
                        </div>

                        <table>
                            <thead>
                                <tr>
                                    <th class="cel-1">Course</th>
                                    <th class="cel-2">Option</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${courseData}" var="i">
                                    <tr>
                                        <td>
                                            <div class="course-inf">
                                                <img src="${i.imgUrl}" alt="courseImage"/>
                                                <div class="inf">
                                                    <p>${i.title}</p>
                                                    <small>Publish Date: ${i.publishDate}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="options">
                                                <a href="${pageContext.request.contextPath}/teacher/edit-course?courseId=${i.id}"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <%@include file="/components/courseListingPagination.jspf" %>
                    </div>
                </div>       
            </div>

        <%@include file="/components/footer.jspf" %>
    </body>
</html>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Gắn sự kiện nghe (event listener) cho các phần tử filter
        const filterButtons = document.querySelectorAll('[name="filterValue"]');
        filterButtons.forEach(function (button) {
            button.addEventListener('click', selectFilter);
        });
    });

    function selectFilter(e) {
        let target = e.target;

        // Remove 'selected' class from all filter buttons
        let filterButtons = document.querySelectorAll('.filter-button');
        filterButtons.forEach(function (button) {
            button.classList.remove('selected');
        });

        // Add 'selected' class to the clicked filter button
        target.classList.add('selected');

        // Get the value of the selected filter
        let name = target.getAttribute('name');
        let value = target.getAttribute('value');
        applyFilter(name, value);
        e.preventDefault();
    }


    function applyFilter(name, value) {
        let searches = new URLSearchParams(location.search);
        searches.set(name, value);
        location.search = searches.toString();
    }


</script>