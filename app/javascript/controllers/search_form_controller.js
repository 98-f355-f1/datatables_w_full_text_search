import { Controller } from "@hotwired/stimulus";
import debounce from "debounce";

export default class SearchFormController extends Controller {
  static targets = [ "form", "query", "checked" ]
  static values  = { match: Boolean }
  static outlets = [ "pagy" ]

  initialize() {
    this.submit = debounce(this.submit.bind(this), 1000)
  }

  connect() {
    const checkbox = document.getElementById("match")
    this.matchValue = checkbox.checked ? "1" : "0"
  }

  pagyOutletConnected(outlet, element) {
    console.log(outlet)
    console.log(element)
  }

  submit(_event) {
    this.submitRequest();
  }

  changeSelect() {
    this.submitRequest()
  }

  submitRequest() {
    this.formTarget.requestSubmit()
  }

  checked() {
    this.matchValue = this.checkedTarget.checked ? "1" : "0"
  }

  clearSearch(evt) {
    console.log(evt.target.parentElement);
    console.log(evt.currentTarget);
    console.log(evt.currentTarget.previousElementSibling);
    console.log(this.element);
    this.queryTarget.value = ""
    this.submitRequest()
  }
}
