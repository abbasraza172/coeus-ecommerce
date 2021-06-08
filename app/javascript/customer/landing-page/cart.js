$(document).on("turbolinks:load", function () {
    CART.init();
    showCart();
})

/*
 * Adds a product to cart
 * @param {Integer} id - The Id of product
 * @param {String} name - The name of product
 * @param {Integer} quantity - The quantity of product
 * @param {Float} price - The price of product
 * @param {String} image - The image path of the product
 * @return {void}
 */
window.addToCart = function (id, name, quantity, price, image) {
    let product = { id: 0, name: "", qty: 0, price: 0.0, image: "" };
    product.id = id;
    product.name = name;
    product.qty = quantity;
    product.price = price;
    product.image = image;

    addItem(product);
}

/*
 * Constant CART object
 */
const CART = {
    KEY: 'bkasjbdfkjasdkfjhaksdfjskd',
    contents: [],

    /*
    * Initializes the contents of CART object
    * @return {void}
    */
    init() {
        //check localStorage and initialize the contents of CART.contents
        let _contents = localStorage.getItem(CART.KEY);
        if (_contents) {
            CART.contents = JSON.parse(_contents);
        } else {
            //initializing contents
            CART.contents = [];
            CART.sync();
        }
    },

    /*
    * Syncronizes local storage with contents of CART
    * @return {void}
    */
    async sync() {
        let _cart = JSON.stringify(CART.contents);
        await localStorage.setItem(CART.KEY, _cart);
    },

    /*
    * Finds the product from contents with given product id
    * @param {Integer} id - The Id of product to be found
    * @return {Object} match[0] - The product object if found
    */
    find(id) {
        //find an item in the cart by it's id
        let match = CART.contents.filter(item => {
            if (item.id == id)
                return true;
        });
        if (match && match[0])
            return match[0];
    },
    
    /*
    * Adds a product to contents
    * @param {Object} prod - The object of product to be added
    * @return {void}
    */
    add(prod) {
        //add a new item to the cart
        //check that it is not in the cart already
        if (CART.find(prod.id)) {
            CART.increase(prod.id, 1);
        } else {
            CART.contents.push(prod);
            //update localStorage
            CART.sync();
        }
    },

    /*
    * Increases the qunatity of product
    * @param {Integer} id - The Id of product
    * @param {Integer} quantity - The quantity of product, default is 1
    * @return {void}
    */
    increase(id, qty = 1) {
        //increase the quantity of an item in the cart
        CART.contents = CART.contents.map(item => {
            if (item.id === id)
                item.qty = item.qty + qty;
            return item;
        });
        //update localStorage
        CART.sync()
    },

    /*
    * Reduces the qunatity of product
    * @param {Integer} id - The Id of product
    * @param {Integer} quantity - The quantity of product, default is 1
    * @return {void}
    */
    reduce(id, qty = 1) {
        //reduce the quantity of an item in the cart
        CART.contents = CART.contents.map(item => {
            if (item.id === id)
                item.qty = item.qty - qty;
            return item;
        });
        CART.contents.forEach(async item => {
            if (item.id === id && item.qty === 0)
                await CART.remove(id);
        });
        //update localStorage
        CART.sync()
    },

    /*
    * Removes the product
    * @param {Integer} id - The Id of product
    * @return {void}
    */
    remove(id) {
        //remove an item entirely from CART.contents based on its id
        CART.contents = CART.contents.filter(item => {
            if (item.id !== id)
                return true;
        });
        //update localStorage
        CART.sync()
    },

    /*
    * Set empty the contents
    * @return {void}
    */
    empty() {
        //empty whole cart
        CART.contents = [];
        //update localStorage
        CART.sync()
    },

    /*
    * Sorts the contents by given field
    * @param {String} field - The attribute of product
    * @return {void}
    */
    sort(field = 'name') {
        //sort by field - name, price
        //return a sorted shallow copy of the CART.contents array
        let sorted = CART.contents.sort((a, b) => {
            if (a[field] > b[field]) {
                return 1;
            } else if (a[field] < a[field]) {
                return -1;
            } else {
                return 0;
            }
        });
        return sorted;
        //NO impact on localStorage
    },
};

/*
 * Creates the view for cart according to present products in local storage
 * @return {void}
 */
function showCart() {

    let cartDetailBody = $("#cart-detail");
    cartDetailBody.empty();
    let cartShortQuantity = $("#cart-short-quantity");
    let cartShortBill = $("#cart-short-bill");
    let s = CART.sort('qty');
    let totalBill = 0;
    let i = 0;
    s.forEach(item => {

        let tr = $('<tr>');
        let tdImage = $('<td>');
        let tdName = $('<td>');
        let tdUnitPrice = $('<td>');
        let tdQty = $('<td>');
        let tdTotalPrice = $('<td>');

        tr.attr("id", "tr" + item.id);

        let img = $('<img>');
        img.attr({ width: "100", alt: item.name });
        img.attr("src", "https://micoedward.com/wp-content/uploads/2018/04/Love-your-product.png")
        tdImage.append(img);
        tdImage.load(self);
        tr.append(tdImage);

        tdName.text(item.name);
        tr.append(tdName);

        tdUnitPrice.text("$" + item.price);
        tr.append(tdUnitPrice);

        let input = $('<input>');
        input.attr({
            style: "max-width:34px", placeholder: "1",
            id: "appendedInputButtons", size: "16", type: "text", value: item.qty, data_id: item.id
        });
        input.addClass("span1")
        let mainQtyDiv = $('<div>');
        mainQtyDiv.addClass("input-append");

        let btnMinus = $('<button>');
        btnMinus.attr({ type: "button", style: "margin-left:5px", data_id: item.id, onclick: "decrementCart(" + item.id + ")" });
        btnMinus.addClass("btn btn-mini");
        let spanMinus = $('<span>');
        spanMinus.addClass("fa fa-minus");
        btnMinus.append(spanMinus);
        mainQtyDiv.append(btnMinus);

        let btnPlus = $('<button>');
        btnPlus.attr({ type: "button", data_id: item.id, onclick: "incrementCart(" + item.id + ")" });
        btnPlus.addClass("btn btn-mini");
        let spanPlus = $('<span>');
        spanPlus.addClass("fa fa-plus");
        btnPlus.append(spanPlus);
        mainQtyDiv.append(btnPlus);

        let btnRemove = $('<button>');
        btnRemove.attr({ type: "button", onclick: "removeCart(" + item.id + ")" });
        btnRemove.addClass("btn btn-mini btn-danger")
        let spanRemove = $('<span>');
        spanRemove.addClass("fa fa-remove");
        btnRemove.append(spanRemove);
        mainQtyDiv.append(btnRemove);

        tdQty.append(input);
        tdQty.append(mainQtyDiv);

        tr.append(tdQty);

        tdTotalPrice.text("$" + (item.price * item.qty));
        tr.append(tdTotalPrice);

        cartDetailBody.append(tr);

        totalBill = totalBill + (item.price * item.qty);
        i = i + 1;
    });

    let tr = $('<tr>');
    let tdLabel = $('<td>');
    let tdBill = $('<td><strong>');
    let strng = $('<strong>');

    tdLabel.attr("colspan", 6);
    tdLabel.addClass("alignR");
    tdLabel.text("Total Bill:");
    tr.append(tdLabel);


    strng.text("$" + totalBill);
    tdBill.append(strng);
    tr.append(tdBill);
    cartDetailBody.append(tr);

    cartShortQuantity.text(i);
    cartShortBill.text("$" + totalBill);
}

/*
 * Increases a product quantity by 1 in cart
 * @param {Integer} id - The Id of product
 * @return {void}
 */
window.incrementCart = function (id) {
    CART.increase(id, 1);
    let item = CART.find(id);
    showCart();
}

/*
 * Decreases a product quantity by 1 in cart
 * @param {Integer} id - The Id of product
 * @return {void}
 */
window.decrementCart = function (id) {
    CART.reduce(id, 1);
    let item = CART.find(id);
    showCart();
}

/*
 * Remove a product from cart
 * @param {Integer} id - The Id of product
 * @return {void}
 */
window.removeCart = function (id) {
    CART.remove(id, 1);
    let item = CART.find(id);
    showCart();
}

/*
 * Adds a product in cart
 * @param {Object} prod - The object of a product
 * @return {void}
 */
function addItem(prod) {
    CART.add(prod);
    showCart();
}
