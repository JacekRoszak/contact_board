import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ContactCounterController from "./contact_counter_controller"
application.register("contact-counter", ContactCounterController)

import InlineEditController from "./inline_edit_controller"
application.register("inline-edit", InlineEditController)
