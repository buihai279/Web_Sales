<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Web_Sales.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
        <div class="main-child">
            <nav>
                <ul class="top-menu">
                    <li><a class="active" href="default.asp">Home</a>
                    </li>
                    <li><a href="news.asp">News</a>
                    </li>
                    <li><a href="contact.asp">Contact</a>
                    </li>
                    <li><a href="about.asp">About</a>
                    </li>
                    <li><a>Login</a>
                    </li>
                </ul>
            </nav>
            <!-- Slide Show -->
            <div class="slideshow-container">
                <div class="mySlides fade">
                    <div class="numbertext">1 / 3</div>
                    <img src="slides/img1.jpg">
                </div>
                <div class="mySlides fade">
                    <div class="numbertext">2 / 3</div>
                    <img src="slides/img2.jpg">
                </div>
                <div class="mySlides fade">
                    <div class="numbertext">3 / 3</div>
                    <img src="slides/img3.jpg">
                </div>
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
                <div style="text-align:center" class="control">
                    <span class="dot" onclick="currentSlide(1)"></span>
                    <span class="dot" onclick="currentSlide(2)"></span>
                    <span class="dot" onclick="currentSlide(3)"></span>
                </div>
            </div>
            <!-- end slide -->
        </div>
        <!-- end box menu slide -->
        <!-- Product grid -->
        <div class="grid-product">
            <div class="item">
                <img src="product-images/jeans1.jpg" style="width:100%">
                <p>Ripped Skinny Jeans
                    <br><b>$24.99</b>
                </p>
            </div>
            <div class="item">
                <img src="product-images/jeans2.jpg" style="width:100%">
                <p>Mega Ripped Jeans
                    <br><b>$19.99</b>
                </p>
            </div>
            <div class="item">
                <img src="product-images/jeans1.jpg" style="width:100%">
                <p>Ripped Skinny Jeans
                    <br><b>$24.99</b>
                </p>
            </div>
            <div class="item">
                <img src="product-images/jeans2.jpg" style="width:100%">
                <p>Mega Ripped Jeans
                    <br><b>$19.99</b>
                </p>
            </div>
            <div class="item">
                <img src="product-images/jeans1.jpg" style="width:100%">
                <p>Ripped Skinny Jeans
                    <br><b>$24.99</b>
                </p>
            </div>
            <div class="item">
                <img src="product-images/jeans2.jpg" style="width:100%">
                <p>Mega Ripped Jeans
                    <br><b>$19.99</b>
                </p>
            </div>
        <div style="clear: both;"></div>
        <ul class="pagination">
            <li><a href="#">&laquo;</a>
            </li>
            <li><a href="#">1</a>
            </li>
            <li><a class="active" href="#">2</a>
            </li>
            <li><a href="#">&raquo;</a>
            </li>
        </ul>
        </div>
    </div>
    <script src="asset/js/slide.js" type="text/javascript" charset="utf-8" async defer></script>
</asp:Content>

