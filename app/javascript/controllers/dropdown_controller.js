import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["button", "dropdown", "arrow"]

	toggle(e) {
		e.stopPropagation()

		this.dropdownTarget.classList.toggle("show")
  	this.arrowTarget.classList.toggle("arrow")
	}
}
