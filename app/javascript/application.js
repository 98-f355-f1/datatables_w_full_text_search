// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@fortawesome/fontawesome-free"
import "@iconify/icons-icons8"
// import morphdom from "morphdom"

Turbo.setConfirmMethod((message, element) => {
  const dialog = document.getElementById("turbo-confirm")
  dialog.querySelector("p").textContent = message
  dialog.showModal()

  return new Promise((resolve, _reject) => {
    dialog.addEventListener("close", () => {
      resolve(dialog.returnValue == "confirm")
    }, { once: true })
  })
})

Turbo.setProgressBarDelay(100)

// ONLY GET REQUESTS
document.addEventListener("turbo:before-visit", (event) => {
  const eventUrl = event.detail.url
  console.log(`before-visit: ${eventUrl}`)
})

// ALL REQUESTS
document.addEventListener("turbo:before-fetch-request", (event) => {
  event.preventDefault()

  const token = document.querySelector("meta[name='csrf-token']")
  console.log(`before-fetch-request: CSRF-TOKEN: ${token.content}`)

  event.detail.resume()
})

// ONLY GET REQUESTS
document.addEventListener("turbo:before-render", (event) => {
  event.preventDefault()

  const token = document.querySelector("meta[name='csrf-token']")
  console.log(`before-render: CSRF-TOKEN: ${token.content}`)

  event.detail.resume()
})

// https://fullstackheroes.com/tutorials/stimulus/create-custom-events/
// const event = new CustomEvent("increment-pagy-total");
// window.dispatchEvent(event);
