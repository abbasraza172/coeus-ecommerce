// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.



import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

require('jquery')
require("@nathanvda/cocoon")


// require("packs/jquery-1.10.2")
require("packs/bootstrap-seller")
// require("packs/dropdownjquery")
require("packs/dropdownselect")


require("packs/jquery.metisMenu")

require("packs/custom")
<<<<<<< HEAD


// $(document).on("turbolinks:load", function () {
//      $('#multiSelect').selectpicker();
// })
=======
require("packs/dropdownmin")
require("packs/dropdownjquery")
>>>>>>> 63f3cb32a9cd6f1e49692012902cbd7022cd2f6c

Rails.start()
Turbolinks.start()
ActiveStorage.start()
