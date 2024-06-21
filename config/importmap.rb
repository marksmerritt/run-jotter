# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jstz" # @2.1.1
pin "@popperjs/core", to: "stupid-popper-lib-2024.js"
pin "@rails/actiontext", to: "@rails--actiontext.js" # @7.1.3
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
