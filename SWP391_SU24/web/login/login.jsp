<%-- 
    Document   : login
    Created on : May 24, 2023, 8:15:50 PM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/logreg.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .google {
                cursor: pointer;
                text-decoration: none;
            }
            .left-heading {
                color: orange;
                font-size: 54px;
                padding: 0 72px 24px 82px;
                margin-top: 82px;
                font-weight: 600;
            }
            .btn {
                height: 46px;
                margin-left: 52px;
                display: flex;
                padding: 0.5rem 4rem;
                font-size: 0.875rem;
                font-weight: 700;
                align-items: center;
                border-radius: 0.5rem;
                border: 1px solid rgba(0, 0, 0, 0.25);
                gap: 1.6rem;
                cursor: pointer;
                transition: all .6s ease;
            }
            .btn svg {
                height: 24px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="container-form">
                <div class="left-part_space"></div>
                <div class="left_part">
                    <h6 class="left-heading">
                        <span>FPT EDUCATION</span>
                    </h6>
                </div>
                <div class="right_part">
                    <div class="spacing_top"></div>
                    <div class="right-head">
                        <h3 class="right-title">Login</h3>
                        <p class="right-desc">Fill your info</p>
                    </div>
                    <div class="form-group">
                        <input id="email" name="email" value="${email==null?'admin@gmail.com':email}" type="text" placeholder="Email" class="form-control">
                        <span class="form-message"></span>
                    </div>
                    <div class="form-group">
                        <input id="password" name="password" value="${password==null?'12345678':password}" type="password" placeholder="Password" class="form-control">
                        <span class="form-message"></span>
                    </div>
                    <div>
                        <button class="btn"> 
                            <svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid" viewBox="0 0 256 262">
                            <path fill="#4285F4" d="M255.878 133.451c0-10.734-.871-18.567-2.756-26.69H130.55v48.448h71.947c-1.45 12.04-9.283 30.172-26.69 42.356l-.244 1.622 38.755 30.023 2.685.268c24.659-22.774 38.875-56.282 38.875-96.027"></path>
                            <path fill="#34A853" d="M130.55 261.1c35.248 0 64.839-11.605 86.453-31.622l-41.196-31.913c-11.024 7.688-25.82 13.055-45.257 13.055-34.523 0-63.824-22.773-74.269-54.25l-1.531.13-40.298 31.187-.527 1.465C35.393 231.798 79.49 261.1 130.55 261.1"></path>
                            <path fill="#FBBC05" d="M56.281 156.37c-2.756-8.123-4.351-16.827-4.351-25.82 0-8.994 1.595-17.697 4.206-25.82l-.073-1.73L15.26 71.312l-1.335.635C5.077 89.644 0 109.517 0 130.55s5.077 40.905 13.925 58.602l42.356-32.782"></path>
                            <path fill="#EB4335" d="M130.55 50.479c24.514 0 41.05 10.589 50.479 19.438l36.844-35.974C195.245 12.91 165.798 0 130.55 0 79.49 0 35.393 29.301 13.925 71.947l42.211 32.783c10.59-31.477 39.891-54.251 74.414-54.251"></path>
                            </svg>
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:9999/SWP391_SU24/login&response_type=code&client_id=751407796002-7ojn2teuinouq43pkr7lg6bjjsvapa56.apps.googleusercontent.com&approval_prompt=force" class="google">
                                Login with Google</a>
                        </button>
                    </div>
                    <span class="validate-message">${validate}</span>
                    <div>
                        <button id="form-submit" class="form-submit">Login</button>
                    </div>
                    <div class="spacing_bottom"></div>
                </div>
                <div class="right-part_space"></div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/assets/js/login.js"></script>
        <script>
            Validator({
                form: "#form-1",
                formGroupSelector: ".form-group",
                querySelector: ".form-message",
                rules: [
                    Validator.isEmail("#email"),
                    Validator.isRequired("#email"),
                    Validator.isRequired("#password")
                ]
            });
        </script>
    </body>

</html>
