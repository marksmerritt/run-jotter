import { Controller } from "@hotwired/stimulus"
import jstz from "jstz"

export default class extends Controller {
  connect() {
    this.timeZone = jstz.determine().name()
    this.setCookie()
  }

  setCookie() {
  	let expires = new Date()
  	expires.setTime(expires.getTime() + (24 * 60 * 60 * 1000))
  	document.cookie = "run_jotter_time_zone=" + this.timeZone + ";expires=" + expires.toUTCString()
  }
}
