<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Menu</title>
    <style><%@include file="/css/cart.css"%></style>
    <style><%@include file="/css/payment.css"%></style>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"
            type="text/javascript"></script>
    <script><%@include file="/js/payment.js"%></script>
    <script><%@include file="/js/cart.js"%></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&family=Rubik:wght@400;500&display=swap" rel="stylesheet">
</head>
<fmt:setLocale value='<%=request.getSession().getAttribute("lang")%>'/>
<fmt:setBundle basename="lang" var="loc"/>
<fmt:message bundle="${loc}" key="lang.label.checkout" var="checkout"/>
<fmt:message bundle="${loc}" key="lang.label.your_order" var="your_order"/>
<fmt:message bundle="${loc}" key="lang.label.sticks" var="sticks"/>
<fmt:message bundle="${loc}" key="lang.label.fork" var="fork"/>
<fmt:message bundle="${loc}" key="lang.label.ginger" var="ginger"/>
<fmt:message bundle="${loc}" key="lang.label.wasabi" var="wasabi"/>
<fmt:message bundle="${loc}" key="lang.label.soy_sauce" var="soy_sauce"/>
<fmt:message bundle="${loc}" key="lang.label.extra" var="extra"/>
<fmt:message bundle="${loc}" key="lang.label.delivery" var="delivery"/>
<fmt:message bundle="${loc}" key="lang.label.pickup" var="pickup"/>
<fmt:message bundle="${loc}" key="lang.label.city" var="city"/>
<fmt:message bundle="${loc}" key="lang.label.street" var="street"/>
<fmt:message bundle="${loc}" key="lang.label.house" var="house"/>
<fmt:message bundle="${loc}" key="lang.label.entrance" var="entrance"/>
<fmt:message bundle="${loc}" key="lang.label.floor" var="floor"/>
<fmt:message bundle="${loc}" key="lang.label.flat" var="flat"/>
<fmt:message bundle="${loc}" key="lang.label.delivery_time" var="delivery_time"/>
<fmt:message bundle="${loc}" key="lang.label.as_soon_as_possible" var="as_soon_as_possible"/>
<fmt:message bundle="${loc}" key="lang.label.certain_time" var="certain_time"/>
<fmt:message bundle="${loc}" key="lang.label.payment_method" var="payment_method"/>
<fmt:message bundle="${loc}" key="lang.label.cash" var="cash"/>
<fmt:message bundle="${loc}" key="lang.label.bank_card" var="bank_card"/>
<fmt:message bundle="${loc}" key="lang.label.payment_by_card_online" var="payment_by_card_online"/>
<fmt:message bundle="${loc}" key="lang.label.promo_code" var="promo_code"/>
<fmt:message bundle="${loc}" key="lang.label.enter_promo_code" var="enter_promo_code"/>
<fmt:message bundle="${loc}" key="lang.label.your_comment" var="your_comment"/>
<body>
    <%@ include file="/jsp/header/header-user.jsp"%>
    <div class="payment-container">
        <div class="payment-header">
            <h2 class="payment-title">${checkout}</h2>
        </div>
        <form action="controller" method="post">
        <input type="hidden" name="command" value="checkout">
        <div class="payment-body">
            <div class="payment-cart">
                <h4 class="payment-section-header">${your_order}</h4>
                <ul class="payment-cart-items">
                    <c:forEach var="item" items="${cart_items}">
                        <li class="payment-cart-item">
                            <input type="hidden" name="cart_item_id" value="${item.getKey().getDishId()}">
                            <div class="cart-item-information">
                                <img src="${pageContext.request.contextPath}${item.getKey().getPictureName()}"
                                     alt="${item.getKey().getName()}" class="cart-item-image">
                                <div class="cart-item-title">
                                    <h4 class="cart-item-name">${item.getKey().getName()}</h4>
                                    <p class="cart-item-description">something</p>
                                </div>
                            </div>
                            <div class="cart-item-manage">
                                <div class="cart-item-price">
                                    <p class="cart-item-price-value">${item.getKey().getPrice()}</p>
                                    <span class="cart-item-price-currency">$</span>
                                </div>
                                <div class="cart-item-count">
                                    <div class="cart-item-count-update">
                                        <input type="hidden" name ="command" value="add_to_guest_cart">
                                        <span class="plus-minus-button">+</span>
                                    </div>
                                    <p class="cart-item-count-label">${item.getValue()}</p>
                                    <div class="cart-item-count-update">
                                        <input type="hidden" name ="command" value="delete_from_guest_cart">
                                        <span class="plus-minus-button">-</span>
                                    </div>
                                </div>
                                <div class="cart-item-delete">
                                    <input type="hidden" name ="command" value="delete_from_guest_cart">
                                    <div class="cart-item-delete-button">
                                        <i class="fa fa-trash" id="delete-item"></i>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="payment-extra-items">
                <h4 class="payment-section-header">${extra}</h4>
                <ul class="extra-items">
                    <li class="extra-item">
                        <input type="checkbox" id="sticks"><label for="sticks" class="extra-item-title">${sticks}</label>
                    </li>
                    <li class="extra-item">
                        <input type="checkbox" id="fork"><label for="fork" class="extra-item-title">${fork}</label>
                    </li>
                    <li class="extra-item">
                        <input type="checkbox" id="ginger"><label for="ginger" class="extra-item-title">${ginger}</label>
                    </li>
                    <li class="extra-item">
                        <input type="checkbox" id="wasabi"><label for="wasabi" class="extra-item-title">${wasabi}</label>
                    </li>
                    <li class="extra-item">
                        <input type="checkbox" id="soy_sauce"><label for="soy_sauce" class="extra-item-title">${soy_sauce}</label>
                    </li>
                </ul>
            </div>
            <div class="payment-delivery">
                <div class="delivery-or-pickup">
                    <div class="delivery-or-pickup-item is-active">${delivery}</div>
                    <div class="delivery-or-pickup-item">${pickup}</div>
                </div>
                <div class="delivery-address">
                    <div class="delivery-address-house">
                        <div class="delivery-address-field">
                            <label class="delivery-address-label" for="city">${city}</label>
                            <input class="delivery-address-input-long" id="city" type="text"
                                   placeholder="Город" required>
                        </div>
                        <div class="delivery-address-field">
                            <label class="delivery-address-label" for="street">${street}</label>
                            <input class="delivery-address-input-long" id="street" type="text"
                                   placeholder="Улица" required>
                        </div>
                    </div>
                    <div class="delivery-address-house">
                        <div class="delivery-address-field">
                            <label class="delivery-address-label" for="house">${house}</label>
                            <input class="delivery-address-input-short" id="house" type="text"
                                   placeholder="Дом" required pattern="[1-9][0-9]{0,3}">
                        </div>
                        <div class="delivery-address-field">
                            <label class="delivery-address-label" for="entrance">${entrance}</label>
                            <input class="delivery-address-input-short" id="entrance" type="text"
                                   placeholder="Подъезд" equired pattern="[1-9][0-9]{0,2}">
                        </div>
                        <div class="delivery-address-field">
                            <label class="delivery-address-label" for="floor">${floor}</label>
                            <input class="delivery-address-input-short" id="floor" type="text"
                                   placeholder="Этаж" required pattern="(-|[1-9])[0-9]{0,3}">
                        </div>
                        <div class="delivery-address-field">
                            <label class="delivery-address-label" for="flat">${flat}</label>
                            <input class="delivery-address-input-short" id="flat" type="text"
                                   placeholder="Квартира" required pattern="[1-9][0-9]{0,5}">
                        </div>
                    </div>
                </div>
                <div class="pick-up-info">
                    <c:forEach var="item" items="${cafe_addresses}">
                        <label><input class="pickup-address" type="radio">${item.getAddress()}</label>
                    </c:forEach>
                </div>
                <div class="delivery-time">
                    <h4 class="payment-section-header">${delivery_time}</h4>
                    <div class="delivery-or-pickup">
                        <div class="delivery-or-pickup-item is-active">${as_soon_as_possible}</div>
                        <div class="delivery-or-pickup-item">${certain_time}</div>
                    </div>
                </div>
                <div class="promo-code">
                    <h4 class="payment-section-header">${promo_code}</h4>
                    <div class="promo-code-field">
                        <label class="promo-code-label" for="promo-code">${enter_promo_code}</label>
                        <input class="promo-code-input" id="promo-code" type="text" placeholder="Promo code"
                        pattern="[A-Za-zА-Яа-яёЁ0-9_]{5,20}">
                    </div>
                </div>
                <div class="payment-method">
                    <h4 class="payment-section-header">${payment_method}</h4>
                    <div class="delivery-or-pickup">
                        <div class="delivery-or-pickup-item is-active">${cash}</div>
                        <div class="delivery-or-pickup-item">${bank_card}</div>
                        <div class="delivery-or-pickup-item">${payment_by_card_online}</div>
                    </div>
                </div>

            </div>
        </div>
        <div class="payment-footer">
            <div class="comment-order">
                <h4 class="payment-section-header">${your_comment}</h4>
                <textarea class="comment-order-input" placeholder="Your comment..."></textarea>
            </div>
            <div class="payment-confirm">
                <button class="payment-confirm-button" type="submit">${checkout}</button>
            </div>
        </div>
        </form>
    </div>
</body>
</html>