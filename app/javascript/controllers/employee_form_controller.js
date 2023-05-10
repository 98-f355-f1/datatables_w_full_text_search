import { Controller } from "@hotwired/stimulus";

export default class EmployeeFormController extends Controller {
  static targets = ["form"]
  static classes = ["css"]
  static values = {
    label: String,
    url: String
  }

  submit(_event) {
    this.submitRequest();
  }

  submitRequest() {
    console.log(this.element)
    console.log(this.formTarget)
    this.formTarget.requestSubmit()
  }

  toggle(event) {
    event.preventDefault()
    console.log(this.element == event.target)
    console.log(this.labelValue)
    console.log(event.target)
    console.log(this.cssClass)
    console.log(this.urlValue)
    this.element.classList.toggle(this.cssClass)

    // this.element.setAttribute('contenteditable', "true")

    this.fetchData(event)
  }

  async fetchData(event) {
    const csrfToken = document.querySelector("[name='csrf-token']").content
    const myOptions = {
      method: 'GET', // *GET, POST, PUT, DELETE, etc.
      mode: 'cors', // no-cors, *cors, same-origin
      cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
      credentials: 'same-origin', // include, *same-origin, omit
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      // body: JSON.stringify({}) // body data type must match "Content-Type" header, GET requests cannot have body
    }

    const response     = await fetch(`${this.urlValue}`, myOptions)
    const jsonResponse = await response.json()
    const employee     = JSON.parse(jsonResponse.employee)
    const content      = JSON.parse(jsonResponse.content)

    Object.entries(employee).forEach(([key, value]) => {
      console.log(`${key}: ${value}`)
    })

    console.log(content)


    // fetch(`${this.urlValue}`, myOptions)
    //   .then((response) => response.json())
    //   .then((response) => {
    //     const employee = JSON.parse(response.employee)
    //     const content  = JSON.parse(response.content)

    //     Object.entries(employee).forEach(([key, value]) => {
    //       console.log(`${key}: ${value}`)
    //     })

    //     console.log(content)
    //   })
  }
}
