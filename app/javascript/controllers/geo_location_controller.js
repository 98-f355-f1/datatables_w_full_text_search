import { Controller } from '@hotwired/stimulus';

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
}

// USE WITH gem 'geocode'
export default class GeoLocationController extends Controller {
  connect() {
    navigator.geolocation.getCurrentPosition(this.success, this.error, options)
  }

  success(position) {
    const coords = position.coords

    console.log("Your current position is:")
    console.log(`Latitude : ${coords.latitude}`)
    console.log(`Longitude : ${coords.longitude}`)
    console.log(`with ${coords.accuracy} meters accuracy`)
  }

  error(error) {
    console.log(`ERROR(${error.code}) : ${error.message}`)
  }
}
