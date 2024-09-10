// Import and register all your controllers from the importmap via controllers/**/*_controller
import { Application } from "@hotwired/stimulus"
import DynamicSelectController from "./dynamic_select_controller"
import NestedFormController from "./nested_form_controller"

const application = Application.start()

application.register("dynamic-select", DynamicSelectController)
application.register("nested-form", NestedFormController)

export { application }

