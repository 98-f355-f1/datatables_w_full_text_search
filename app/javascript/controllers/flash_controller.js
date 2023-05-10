import { Controller } from "@hotwired/stimulus";

export default class FlashController extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove()
    }, 6000)
  }
}
