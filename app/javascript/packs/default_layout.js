// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("customer/landing-page/bootstrp.js")
require("customer/landing-page/jquery.js")
require("customer/landing-page/jquery.easing-1.3.min.js")
require("customer/landing-page/jquery.scrollTo-1.4.3.1-min.js")
require("customer/landing-page/shop.js")

Rails.start()
Turbolinks.start()
ActiveStorage.start()
