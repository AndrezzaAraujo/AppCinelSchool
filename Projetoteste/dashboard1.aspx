<%@ Page Title="" Language="C#" MasterPageFile="~/intranet.Master" AutoEventWireup="true" CodeBehind="dashboard1.aspx.cs" Inherits="Projetoteste.dashboard1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title></title>
    <!--    Template 2108 Dashboard http://www.tooplate.com/view/2108-dashboard -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600"/>
    <!-- https://fonts.google.com/specimen/Open+Sans -->
    <link rel="stylesheet" href="../dashboard_template/css/fontawesome.min.css"/>
    <!-- https://fontawesome.com/ -->
    <link rel="stylesheet" href="../dashboard_template/css/bootstrap.min.css"/>
    <!-- https://getbootstrap.com/ -->
    <link rel="stylesheet" href="../dashboard_template/css/tooplate.css"/>
    <style>
        /*
Template Name: HTML Education Template
Author: yaminncco

Colors:
	Body 		: #798696
	Headers 	: #374050
	Primary 	: #FF6700
	Grey 		: #EBEBEB

Fonts: Lato & Montserrat

Table OF Contents
------------------------------------
1 > General
2 > Logo
3 > Navigation
4 > Hero Area
5 > About & Why Us (Feature)
6 > Courses
7 > Footer
8 > Contact Page
9 > Blog Page
10 > Blog Page Sidebar
11 > Single Post Page
12 > Responsive
13 > Preloader
------------------------------------*/

    	/*------------------------------------*\
	General
\*------------------------------------*/
    	/* --- typography --- */
body {
    font-family: 'Montserrat', sans-serif;
    font-size: 15px;
    font-weight: 400;
    color: #798696;
    overflow-x: hidden;
}

h1, h2, h3, h4, h5, h6 {
    margin-top: 12px;
    margin-bottom: 15px;
    font-weight: 600;
    color: #374050;
}

h1 {
    font-size: 38px;
}

h2 {
    font-size: 30px;
}

h3 {
    font-size: 24px;
}

h4 {
    font-size: 18px;
}

a {
    font-family: 'Lato', sans-serif;
    color: #374050;
    font-weight: 700;
}

a:hover,
a:focus {
    text-decoration: none;
    outline: none;
    color: #374050;
    opacity: 0.9;
}

ul, ol {
    margin: 0;
    padding: 0;
    list-style: none
}

.white-text {
    color: #FFF;
}

blockquote {
    position: relative;
    margin: 20px 0px;
    padding: 20px 20px 20px 60px;
    border-left: none;
    color: #374050;
}

blockquote:before {
    content: "\f10d";
    font-family: fontAwesome;
    position: absolute;
    left: 0;
    top: 0;
    color: #FF6700;
    width: 40px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border-radius: 50%;
    border: 1px solid #EBEBEB;
}


/* --- Section --- */
.section {
    position: relative;
    padding-top: 80px;
    padding-bottom: 80px;
}

.section-hr {
    margin-top: 80px;
    margin-bottom: 80px;
    border-color: #EBEBEB;
}

.section-header {
    margin-bottom: 40px;
}

/* --- Background Image --- */
.bg-image {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    background-position: center;
    background-size: cover;
}

.bg-image.bg-parallax {
    background-attachment: fixed;
}

.bg-image.overlay:after {
    content: "";
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    background-image: -webkit-gradient(linear, left top, left bottom, from(#374050), to(#798696));
    background-image: linear-gradient(to bottom, #374050 0%, #798696 100%);
    opacity: 0.7;
}

/* --- Buttons --- */
.main-button {
    position: relative;
    display: inline-block;
    padding: 10px 30px;
    background-color: #FF6700;
    border: 2px solid transparent;
    border-radius: 40px;
    color: #FFF;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.main-button:hover, .main-button:focus {
    background-color: #fff;
    border: 2px solid #FF6700;
    color: #FF6700;
}

.main-button.icon-button:hover, .main-button.icon-button:focus {
    padding-right: 45px;
}

.main-button.icon-button:after {
    content: "\f178";
    font-family: FontAwesome;
    position: absolute;
    width: 30px;
    right: 15px;
    text-align: center;
    opacity: 0;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.main-button.icon-button:hover:after, .main-button.icon-button:focus:after {
    opacity: 1;
}

/* --  Input  -- */
input[type="text"], input[type="email"], input[type="password"], input[type="number"], input[type="date"], input[type="url"], input[type="tel"], textarea {
    height: 40px;
    width: 100%;
    border: 1px solid #EBEBEB;
    border-radius: 4px;
    background: transparent;
    padding-left: 15px;
    padding-right: 15px;
    -webkit-transition: 0.2s border-color;
    transition: 0.2s border-color;
}

textarea {
    padding: 10px 15px;
}

input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus, input[type="number"]:focus, input[type="date"]:focus, input[type="url"]:focus, input[type="tel"]:focus, textarea:focus {
    border-color: #FF6700;
}

/*------------------------------------*\
	Logo
\*------------------------------------*/
.navbar-brand {
    padding: 0;
}

.navbar-brand .logo {
    margin-top: 10px;
    display: inline-block;
}

.navbar-brand .logo > img {
    max-height: 30px;
    max-width: 106px; /*..*/
}

@media only screen and (max-width: 767px) {
    .navbar-brand {
    	margin-left: 15px;
    }
}

/*------------------------------------*\
	Navigation
\*------------------------------------*/
#header {
    position: relative;
    left: 0;
    right: 0;
    top: 0;
    z-index: 99;
    border-bottom: 1px solid rgba(235, 235, 235, 0.25);
    background-color: #FFF; /*background-color: #FFF;*/
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

#header.transparent-nav {
    position: absolute;
    background-color: lightgray; /* cor de fundo NAV: background-color: transparent;*/
}

#header.transparent-nav .main-menu li a {
    color: #FFF; /*color: #FFF;*/
}

.main-menu li a {
    text-transform: uppercase;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.main-menu li a:hover, .main-menu li a:focus {
    background-color: transparent; /*background-color: transparent;*/
}

.main-menu li a:after {
    content: "";
    display: block;
    height: 2px;
    background-color: #FF6700; /*background-color: #FF6700;*/
    width: 100%;
    -webkit-transform: translateY(5px);
    -ms-transform: translateY(5px);
    transform: translateY(5px);
    opacity: 0;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.main-menu li a:hover:after, .main-menu li a:focus:after {
    -webkit-transform: translateY(0px);
    -ms-transform: translateY(0px);
    transform: translateY(0px);
    opacity: 1;
}

/* -- Mobile Nav -- */
@media only screen and (max-width: 767px) {
    #nav {
    	position: fixed;
    	top: 0;
    	right: 0;
    	width: 0%;
    	max-width: 250px;
    	height: 100vh;
    	background: #FFF;
    	-webkit-box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.1);
    	box-shadow: 0px 5px 10px 0px rgba(0, 0, 0, 0.1);
    	padding-top: 80px;
    	padding-bottom: 40px;
    	-webkit-transform: translateX(100%);
    	-ms-transform: translateX(100%);
    	transform: translateX(100%);
    	-webkit-transition: 0.4s all cubic-bezier(.77,0,.18,1);
    	transition: 0.4s all cubic-bezier(.77,0,.18,1);
    	z-index: 9;
    }

#header.nav-collapse #nav {
    width: 100%;
    -webkit-transform: translateX(0%);
    -ms-transform: translateX(0%);
    transform: translateX(0%);
}

.main-menu {
    margin: 0;
}

.main-menu li a {
    color: #374050 !important; /*color: #374050 !important;*/
    display: inline-block;
    margin-left: 40px;
}
}

/* -- Mobile Toggle Btn -- */
.navbar-toggle {
    position: fixed;
    right: 0;
    padding: 0;
    height: 40px;
    width: 40px;
    margin-top: 5px;
    z-index: 99;
}

.navbar-toggle > span {
    position: absolute;
    top: 50%;
    left: 50%;
    -webkit-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    -webkit-transition: 0.2s background;
    transition: 0.2s background;
}

.navbar-toggle > span:before, .navbar-toggle > span:after {
    content: '';
    position: absolute;
    left: 0;
    -webkit-transition: 0.2s -webkit-transform;
    transition: 0.2s -webkit-transform;
    transition: 0.2s transform;
    transition: 0.2s transform, 0.2s -webkit-transform;
}

.navbar-toggle > span, .navbar-toggle > span:before, .navbar-toggle > span:after {
    height: 2px;
    width: 25px;
    background-color: #374050; /*background-color: #374050;*/
}

.navbar-toggle > span:before {
    top: -10px;
}

.navbar-toggle > span:after {
    top: 10px;
}

#header.nav-collapse .navbar-toggle > span {
    background: transparent;
}

#header.nav-collapse .navbar-toggle > span:before {
    -webkit-transform: translateY(10px) rotate(45deg);
    -ms-transform: translateY(10px) rotate(45deg);
    transform: translateY(10px) rotate(45deg);
}

#header.nav-collapse .navbar-toggle > span:after {
    -webkit-transform: translateY(-10px) rotate(-45deg);
    -ms-transform: translateY(-10px) rotate(-45deg);
    transform: translateY(-10px) rotate(-45deg);
}

/*------------------------------------*\
	Hero Area
\*------------------------------------*/
.hero-area {
    position: relative;
    padding-top: 80px;
    padding-bottom: 80px;
}

#home.hero-area {
    height: calc(100vh - 80px);
    padding-top: 0px;
    padding-bottom: 0px;
}

.home-wrapper {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
    -ms-transform: translateY(-50%);
    transform: translateY(-50%);
    left: 0;
    right: 0;
}

/* -- Breadcrumb -- */
.hero-area-tree li {
    display: inline-block;
    font-family: 'Lato', sans-serif;
    font-weight: 600;
    font-size: 14px;
    color: rgba(255, 255, 255, 0.8);
}

.hero-area-tree li > a {
    color: rgba(255, 255, 255, 0.8);
}

.hero-area-tree li + li:before {
    content: "/";
    display: inline-block;
    margin: 0px 5px;
    color: rgba(235, 235, 235, 0.25);
}

/*------------------------------------*\
	About & Why Us (Feature)
\*------------------------------------*/
/* -- Feature -- */
.feature {
    position: relative;
}

.feature + .feature {
    margin-top: 40px;
}

.feature .feature-icon {
    position: absolute;
    left: 0;
    top: 0;
    width: 80px;
    height: 80px;
    line-height: 80px;
    text-align: center;
    border-radius: 50%;
    font-size: 30px;
    border: 1px solid #EBEBEB;
    color: #FF6700;
}

.feature-content {
    padding-left: 100px;
}

/* -- About Img -- */
.about-img {
    margin-top: 40px;
}

.about-img > img {
    width: 100%;
}

/* -- About Video -- */
.about-video {
    position: relative;
    display: block;
    border-radius: 4px;
    overflow: hidden;
}

.about-video > img {
    width: 100%;
}

.about-video .play-icon {
    position: absolute;
    top: 50%;
    left: 50%;
    -webkit-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    width: 80px;
    height: 80px;
    line-height: 80px;
    text-align: center;
    background: #fff;
    border-radius: 50%;
    font-size: 24.027px;
    z-index: 10;
    -webkit-animation: 2s play-animation infinite;
    animation: 2s play-animation infinite;
    -webkit-transition: 0.2s color;
    transition: 0.2s color;
}

.about-video:hover .play-icon {
    color: #FF6700;
}

@-webkit-keyframes play-animation {
    from {
    	-webkit-box-shadow: 0px 0px 0px 0px #FFF;
    	box-shadow: 0px 0px 0px 0px #FFF;
    }

    to {
    	-webkit-box-shadow: 0px 0px 0px 10px transparent;
    	box-shadow: 0px 0px 0px 10px transparent;
    }
}

@keyframes play-animation {
    from {
    	-webkit-box-shadow: 0px 0px 0px 0px #FFF;
    	box-shadow: 0px 0px 0px 0px #FFF;
    }

    to {
    	-webkit-box-shadow: 0px 0px 0px 10px transparent;
    	box-shadow: 0px 0px 0px 10px transparent;
    }
}

.about-video:after {
    content: "";
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    top: 0;
    background-color: #FF6700;
    opacity: 0.7;
}

/*------------------------------------*\
	Courses
\*------------------------------------*/
.course {
    margin-top: 20px;
    margin-bottom: 20px;
}

.course .course-img {
    position: relative;
    display: block;
    margin-bottom: 20px;
    border-radius: 4px;
    overflow: hidden;
}

.course .course-img > img {
    width: 100%;
}

.course-img:after {
    content: "";
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    top: 0;
    background-color: #FF6700;
    opacity: 0;
    -webkit-transition: 0.2s opacity;
    transition: 0.2s opacity;
}

.course .course-img:hover:after {
    opacity: 0.7;
}

.course .course-img .course-link-icon {
    position: absolute;
    left: 50%;
    top: 50%;
    -webkit-transform: translate(-50%, calc(-50% - 15px));
    -ms-transform: translate(-50%, calc(-50% - 15px));
    transform: translate(-50%, calc(-50% - 15px));
    width: 40px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border: 2px solid #fff;
    color: #fff;
    border-radius: 50%;
    opacity: 0;
    z-index: 10;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.course .course-img:hover .course-link-icon {
    -webkit-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    opacity: 1;
}

.course .course-title {
    display: block;
    height: 42px;
}

.course .course-details {
    margin-top: 20px;
    padding-top: 10px;
    border-top: 1px solid #EBEBEB;
}

.course .course-details .course-price {
    float: right;
}

.course .course-details .course-price.course-free {
    color: green;
}

.course .course-details .course-price.course-premium {
    color: #FF6700;
}

#courses .center-btn {
    text-align: center;
    margin-top: 40px;
}

/*------------------------------------*\
	Footer
\*------------------------------------*/

#bottom-footer {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px solid #EBEBEB;
}

/* -- Footer Logo -- */
.footer-logo .logo {
    margin-top: 20px;
    display: inline-block;
}

.footer-logo .logo > img {
    max-height: 30px;
}

/* -- Footer Nav -- */
.footer-nav {
    text-align: right;
    padding: 20px 0px;
}

.footer-nav li {
    display: inline-block;
    margin-left: 15px
}

.footer-nav li a {
    display: block;
    text-transform: uppercase;
    -webkit-transition: 0.2s color;
    transition: 0.2s color;
}

.footer-nav li a:hover, .footer-nav li a:focus {
    color: #FF6700;
}

.footer-nav li a:after {
    content: "";
    display: block;
    height: 2px;
    background-color: #FF6700;
    width: 100%;
    -webkit-transform: translateY(5px);
    -ms-transform: translateY(5px);
    transform: translateY(5px);
    opacity: 0;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.footer-nav li a:hover:after, .footer-nav li a:focus:after {
    -webkit-transform: translateY(0px);
    -ms-transform: translateY(0px);
    transform: translateY(0px);
    opacity: 1;
}

/* -- Footer copyright -- */
.footer-copyright {
    line-height: 40px;
}

/* -- Footer Social -- */
.footer-social {
    text-align: right;
}

.footer-social li {
    display: inline-block;
    margin-left: 10px;
}

.footer-social li a {
    display: block;
    width: 40px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border-radius: 50%;
    color: #FFF;
    background-color: #EBEBEB;
    -webkit-transition: 0.2s opacity;
    transition: 0.2s opacity;
}

.footer-social li a.facebook {
    background-color: #3b5998;
}

.footer-social li a.twitter {
    background-color: #55acee;
}

.footer-social li a.google-plus {
    background-color: #dd4b39;
}

.footer-social li a.instagram {
    background-color: #e95950;
}

.footer-social li a.youtube {
    background-color: #ff0000;
}

.footer-social li a.linkedin {
    background-color: #007bb5;
}

/*------------------------------------*\
	Contact Page
\*------------------------------------*/
/* -- Contact Form -- */
.contact-form:after {
    content: "";
    display: block;
    clear: both;
}

.contact-form .input {
    margin-bottom: 20px;
}

.contact-form textarea.input {
    height: 200px;
}

/* -- Contact Information -- */
.contact-details li {
    margin-bottom: 20px;
}

.contact-details li i {
    color: #FF6700;
    margin-right: 15px;
    border: 1px solid #EBEBEB;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    line-height: 40px;
    text-align: center;
}

/* -- Contact Map -- */
#contact-map {
    height: 260px;
    border-radius: 4px;
}

/*------------------------------------*\
	Blog Page
\*------------------------------------*/
/* -- Single Blog -- */
.single-blog {
    margin-bottom: 40px;
}

.single-blog .blog-img > a {
    position: relative;
    display: block;
    border-radius: 4px;
    overflow: hidden;
}

.single-blog .blog-img img {
    width: 100%;
}

.single-blog .blog-img > a:after {
    content: "";
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    right: 0;
    background-color: #FF6700;
    opacity: 0;
    -webkit-transition: 0.2s opacity;
    transition: 0.2s opacity;
}

.single-blog .blog-img > a:hover:after {
    opacity: 0.7;
}

.single-blog .blog-meta {
    margin-top: 20px;
    padding-top: 10px;
    border-top: 1px solid #EBEBEB;
}

.single-blog .blog-meta .blog-meta-author > a {
    color: #FF6700;
}

.single-blog .blog-meta .blog-meta-comments {
    margin-left: 10px;
}

.single-blog .blog-meta .blog-meta-comments > a {
color: #798696;
}

/* -- Pagination -- */
.post-pagination {
    margin-top: 40px;
    text-align: center;
}

.post-pagination .pages {
    display: inline-block;
}

.post-pagination .pages li {
    display: inline-block;
}

.post-pagination .pages li + li {
    margin-left: 10px;
}

.post-pagination .pages li {
    width: 40px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    border-radius: 50%;
    background-color: #EBEBEB;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.post-pagination .pages li a {
    display: block;
    -webkit-transition: 0.2s color;
    transition: 0.2s color;
}

.post-pagination .pages li:hover, .post-pagination .pages li.active {
    background-color: #FF6700;
    color: #FFF;
}

.post-pagination .pages li:hover a {
    color: #FFF;
}

.pagination-back, .pagination-next {
    display: block;
    text-align: center;
    border-radius: 40px;
    background-color: #EBEBEB;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
    height: 40px;
    padding: 0px 30px;
    line-height: 40px;
}

.pagination-next:hover, .pagination-back:hover {
    color: #FFF;
    background-color: #FF6700;
}

.pagination-next:after {
    content: "\f178";
    font-family: FontAwesome;
    margin-left: 15px;
}

.pagination-back:before {
    content: "\f177";
    font-family: FontAwesome;
    margin-right: 15px;
}

/*------------------------------------*\
	Blog Page Sidebar
\*------------------------------------*/
.widget + .widget {
    margin-top: 40px;
}

/*-- Search --*/
.widget.search-widget {
    position: relative
}

.widget.search-widget .input {
    padding-right: 60px;
}

.widget.search-widget button {
    position: absolute;
    right: 0;
    top: 0;
    height: 40px;
    width: 40px;
    background-color: transparent;
    border: none;
}

.widget.search-widget .input:focus + button {
    color: #FF6700;
}

/*-- Category --*/
.category-widget .category {
    display: block;
    text-transform: uppercase;
    padding-top: 10px;
    padding-bottom: 10px;
}

.category-widget .category + .category {
    border-top: 1px solid #EBEBEB;
}

.category-widget .category:before {
    content: "";
    display: inline-block;
    width: 4px;
    height: 4px;
    border-radius: 50%;
    background-color: #FF6700;
    margin-right: 10px;
}

.category-widget .category span {
    font-size: 14px;
    margin-left: 10px;
    color: #798696;
}

/*-- Sidebar Posts --*/
.single-post:after {
    content: "";
    display: block;
    clear: both;
}

.single-post + .single-post {
    margin-top: 20px;
}

.single-post .single-post-img {
    position: relative;
    width: 80px;
    display: block;
    float: left;
    margin-right: 10px;
    margin-top: 3px;
    border-radius: 4px;
    overflow: hidden;
}

.single-post .single-post-img img {
    width: 100%;
}

.single-post-img:after {
    content: "";
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    right: 0;
    background-color: #FF6700;
    opacity: 0;
    -webkit-transition: 0.2s opacity;
    transition: 0.2s opacity;
}

.single-post-img:hover:after {
    opacity: 0.7;
}

/*-- Tags --*/
.tags-widget .tag {
    display: inline-block;
    font-size: 14px;
    text-transform: uppercase;
    margin-right: 0px;
    margin-top: 5px;
    padding: 5px 15px;
    border-radius: 40px;
    border: 1px solid #EBEBEB;
    color: #798696;
    -webkit-transition: 0.2s all;
    transition: 0.2s all;
}

.tags-widget .tag:hover {
    background-color: #FF6700;
    border-color: #FF6700;
    color: #FFF;
}

/*------------------------------------*\
	Single Post Page
\*------------------------------------*/
/* --- Blog Post Meta --- */
.blog-post-meta {
    margin-top: 40px;
}

.blog-post-meta li {
    display: inline-block;
}

.blog-post-meta li + li {
    margin-left: 15px;
}

.blog-post-meta li, .blog-post-meta li > a {
    color: rgba(255, 255, 255, 0.8);
}

.blog-post-meta .blog-meta-author > a {
color: #FF6700;
}

/* --- Blog Share --- */
.blog-share {
    border-top: 1px solid #EBEBEB;
    padding-top: 10px;
    margin-top: 40px;
}

.blog-share > h4 {
    display: inline-block;
    margin: 0;
}

.blog-share a {
    display: inline-block;
    margin-left: 10px;
    width: 40px;
    height: 40px;
    line-height: 40px;
    text-align: center;
    color: #FFF;
    background-color: #EBEBEB;
    border-radius: 50%;
    -webkit-transition: 0.2s opacity;
    transition: 0.2s opacity;
}

.blog-share a.facebook {
    background-color: #3b5998;
}

.blog-share a.twitter {
    background-color: #55acee;
}

.blog-share a.google-plus {
    background-color: #dd4b39;
}

/* --- Blog Comments --- */
.blog-comments {
    margin-top: 40px;
}

.blog-comments .media {
    margin-top: 20px;
    margin-bottom: 20px;
}

.blog-comments .media .media {
    margin-left: 20px;
}

.blog-comments .media .media:nth-last-child(1) {
    margin-bottom: 0px;
}

.blog-comments .media .media-body {
    padding: 20px;
    background-color: #EBEBEB;
    border-radius: 0px 4px 4px;
}

.blog-comments .media .media-left:before {
    content: "";
    position: absolute;
    right: 0;
    top: 0;
    border-style: solid;
    border-width: 0px 15px 15px;
    border-color: transparent #EBEBEB transparent transparent;
}

.blog-comments .media-left {
    position: relative;
    padding-right: 20px;
}

.blog-comments .media-left img {
    width: 80px;
    height: 80px;
    background-color: #EBEBEB;
    border-radius: 50%;
}

.blog-comments .media .date-reply {
    font-size: 12px;
    text-transform: uppercase;
    color: #374050;
}

.blog-comments .media .date-reply .reply {
    margin-left: 15px;
}

/* --- Blog Reply Form --- */
.blog-reply-form {
    margin-top: 40px;
}

.blog-reply-form .input {
    margin-bottom: 20px;
}

.blog-reply-form .input.name-input, .blog-reply-form .input.email-input {
    width: calc(50% - 10px);
    float: left;
}

.blog-reply-form .input.email-input {
    margin-left: 20px;
}

.blog-reply-form textarea {
height: 90px;
}

/*------------------------------------*\
	Responsive
\*------------------------------------*/
@media only screen and (max-width: 991px) {
    .section-header h2 {
    	font-size: 24px;
    }

    /*-- Why us --*/
    #why-us .feature {
    	margin-top: 40px;
    }

    .about-video {
    	margin-top: 40px;
    }

    /*-- Call to action --*/
    #cta {
    	text-align: center;
    }

    /*-- Footer --*/
    .footer-logo {
    	text-align: center;
    }

    .footer-nav {
    	text-align: center;
    }

    .footer-nav li {
    	margin-top: 10px;
    }

    .footer-social {
    	text-align: center;
    }

    .footer-social li {
    	margin-top: 10px;
    }

    .footer-copyright {
    	text-align: center;
    	line-height: inherit;
    	margin-top: 20px;
    }

    /*-- Contact page --*/
    .contact-form {
    	margin-bottom: 40px;
    }

    .contact-form button {
    	float: none !important;
    }

    /*-- Blog page --*/
    #main {
    	margin-bottom: 80px;
    }
}

@media only screen and (max-width: 767px) {
    /*-- Hero area --*/
    .hero-area h1 {
    	font-size: 30px;
    }

    /* -- Breadcrumb -- */
    .hero-area-tree li {
    	font-size: 12px;
    }

    /*-- Pagination --*/
    .post-pagination .pages {
    	display: none;
    }
}

@media only screen and (max-width: 480px) {
    /*-- Courses --*/
    #courses-wrapper [class*='col-xs'] {
    	width: 100%;
    }

    /*-- Blog Comments --*/
    .blog-comments .media .media {
    	margin-left: 0px;
    }

    /*-- Blog Reply Form --*/
    .blog-reply-form .input.name-input, .blog-reply-form .input.email-input {
    	width: 100%;
    	float: none;
    }

    .blog-reply-form .input.email-input {
    	margin-left: 0px;
    }
}

/*------------------------------------*\
	Preloader
\*------------------------------------*/
#preloader {
    position: fixed;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    background-color: #FFF;
    z-index: 9999;
}

#preloader .preloader {
    position: absolute;
    left: 50%;
    top: 50%;
    -webkit-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
}

#preloader .preloader:after {
    content: "";
    display: block;
    width: 40px;
    height: 40px;
    border: 1px solid #EBEBEB;
    border-top: 1px solid #FF6700;
    border-radius: 50%;
    -webkit-animation: 1s preloader linear infinite;
    animation: 1s preloader linear infinite;
}

@-webkit-keyframes preloader {
    from {
    	-webkit-transform: rotate(0deg);
    	transform: rotate(0deg);
    }

    to {
    	-webkit-transform: rotate(360deg);
    	transform: rotate(360deg);
    }
}

@keyframes preloader {
    from {
    	-webkit-transform: rotate(0deg);
    	transform: rotate(0deg);
    }

    to {
    	-webkit-transform: rotate(360deg);
    	transform: rotate(360deg);
    }
}

li {
    list-style: none;
    float: left;
}

.main-menu li:hover .submenu-intranet {
    display: block;
}

.submenu-intranet {
    display: none;
    position: absolute;
    /*background-color: #f9f9f9;*/
    min-width: 160px;            
    z-index: 1;
    text-align: center; /*Alinha os itens do submenu ao centro /*/
}
.submenu-intranet li a {
        /*padding: 2px; */ /*Ajusta o espaçamento entre os itens */

}
#pieChart {
    height: 7px;
}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">

        <ContentTemplate>

   
    <div style="margin: 20% 0 0px 0;"></div>

        <%---dashboard----%>
         <div class="" id="home">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <%--<nav class="navbar navbar-expand-xl navbar-light bg-light">
                        <a class="navbar-brand" href="#">
                            <i class="fas fa-3x fa-tachometer-alt tm-site-icon"></i>
                            <h1 class="tm-site-title mb-0">Dashboard</h1>
                        </a>
                        <button class="navbar-toggler ml-auto mr-0" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mx-auto">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#">Dashboard
                                        <span class="sr-only">(current)</span>
                                    </a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        Reports
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#">Daily Report</a>
                                        <a class="dropdown-item" href="#">Weekly Report</a>
                                        <a class="dropdown-item" href="#">Yearly Report</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="products.html">Products</a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link" href="accounts.html">Accounts</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        Settings
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <a class="dropdown-item" href="#">Profile</a>
                                        <a class="dropdown-item" href="#">Billing</a>
                                        <a class="dropdown-item" href="#">Customize</a>
                                    </div>
                                </li>
                            </ul>
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link d-flex" href="login.html">
                                        <i class="far fa-user mr-2 tm-logout-icon"></i>
                                        <span>Logout</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </nav>--%>
                </div>
            </div>
            <!-- row -->
            <div class="row tm-content-row tm-mt-big"> <%--1º box--%>
                <div class="tm-col tm-col-big">
                    <div class="bg-white tm-block h-100">
                        <h2 class="tm-block-title">Total de Cursos Terminados</h2>
                        <canvas id="lineChart"></canvas>
                    </div>
                </div>
                <div class="tm-col tm-col-big"> <%--2º box--%>
                    <div class="bg-white tm-block h-100">
                        <h2 class="tm-block-title">Número de Cursos Por Área</h2>
                        <asp:Chart ID="barChart" runat="server">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="nome_curso"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>                       
                    </div>
                </div>
                <div class="tm-col tm-col-small"> <%--3º box--%>
                    <div class="bg-white tm-block h-50">
                       <asp:Label ID="lbl_mensagem1" runat="server" Text="Label"></asp:Label>
                    </div>
                </div>

                <div class="tm-col tm-col-big"><%--4º box--%>
                    <div class="bg-white tm-block h-100">
                        <div class="row">
                            <div class="col-8">
                                <h2 class="tm-block-title d-inline-block">Top 10 Formadores</h2>

                            </div>
                            <div class="col-4 text-right">
                                <%--<a href="products.html" class="tm-link-black">View All</a>--%>
                            </div>
                        </div>
                        <%--<ol class="tm-list-group tm-list-group-alternate-color tm-list-group-pad-big">
                            <li class="tm-list-group-item">
                                Donec eget libero
                            </li>
                            <li class="tm-list-group-item">
                                Nunc luctus suscipit elementum
                            </li>
                            <li class="tm-list-group-item">
                                Maecenas eu justo maximus
                            </li>
                            <li class="tm-list-group-item">
                                Pellentesque auctor urna nunc
                            </li>
                            <li class="tm-list-group-item">
                                Sit amet aliquam lorem efficitur
                            </li>
                            <li class="tm-list-group-item">
                                Pellentesque auctor urna nunc
                            </li>
                            <li class="tm-list-group-item">
                                Sit amet aliquam lorem efficitur
                            </li>
                        </ol>--%>
                    </div>
                </div>
               <div class="tm-col tm-col-small"> <%--6º box--%>
                    <div class="bg-white tm-block h-100">
                       <h2 class="tm-block-title">Total de Cursos a Decorrer</h2>
                         <%--<ol class="tm-list-group">
                            <li class="tm-list-group-item">List of tasks</li>
                            <li class="tm-list-group-item">Lorem ipsum doloe</li>
                            <li class="tm-list-group-item">Read reports</li>
                            <li class="tm-list-group-item">Write email</li>
                            
                            <li class="tm-list-group-item">Call customers</li>
                            <li class="tm-list-group-item">Go to meeting</li>
                            <li class="tm-list-group-item">Weekly plan</li>
                            <li class="tm-list-group-item">Ask for feedback</li>
                            
                            <li class="tm-list-group-item">Meet Supervisor</li>
                            <li class="tm-list-group-item">Company trip</li>--%>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div> 
         </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        <!-- jQuery Plugins -->
        <script type="text/javascript" src="../main_template/js/jquery.min.js"></script>
		<script type="text/javascript" src="../main_template/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="../main_template/js/main.js"></script>
    <%--/script navbar--%>
    <%--script dashboard--%>
    <script src="../dashboard_template/js/jquery-3.3.1.min.js"></script>
    <!-- https://jquery.com/download/ -->
    <script src="../dashboard_template/js/moment.min.js"></script>
    <!-- https://momentjs.com/ -->
    <script src="../dashboard_template/js/utils.js"></script>
    <script src="../dashboard_template/js/Chart.min.js"></script>
    <!-- http://www.chartjs.org/docs/latest/ -->
    <script src="../dashboard_template/js/bootstrap.min.js"></script>
    <!-- https://getbootstrap.com/ -->
    <script src="../dashboard_template/js/tooplate-scripts.js"></script>
    <script>
            let ctxLine,
            ctxBar,
            ctxPie,
            optionsLine,
            optionsBar,
            optionsPie,
            configLine,
            configBar,
            configPie,
            lineChart;
            barChart, pieChart;
            // DOM is ready
            $(function () {
                updateChartOptions();
            drawLineChart(); // Line Chart
            drawBarChart(); // Bar Chart
            drawPieChart(); // Pie Chart

            $(window).resize(function () {
                updateChartOptions();
            updateLineChart();
            updateBarChart();
            reloadPage();
            });
        })
    </script>

</asp:Content>
