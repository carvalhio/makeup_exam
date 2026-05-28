// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import ExamRequestController from "./exam_request_controller"

application.register(
  "exam-request",
  ExamRequestController
)