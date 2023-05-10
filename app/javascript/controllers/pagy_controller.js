import { Controller } from "@hotwired/stimulus"
import { PagyActionsDelegator as PagyActionsDelegator } from "../pagy_actions"

export default class PagyController extends Controller {
  static values = { total: Number }

  totalValueChanged(newValue, _prevValue) {
    this.updatePagyTotal(newValue)
  }

  updatePagyTotal(newValue) {
     const action = this.element.dataset.action

    if (action) {
      const newAction = action.slice(action.indexOf("#") + 1)
      console.log(newAction)
      const func = PagyActionsDelegator[newAction]
      if (typeof func === "function") {
        func.call(this, newValue)
      }
    }
  }

  incrementTotal(newValue) {
    console.log("TOTAL INCREMENTED BY 1")
    const pagyTotalTag = document.getElementById("total-count")
    pagyTotalTag.innerText = newValue
  }

  decrementTotal(newValue) {
    console.log("TOTAL DECREMENTED BY 1")
    const pagyTotalTag = document.getElementById("total-count")
    pagyTotalTag.innerText = newValue
  }
}
