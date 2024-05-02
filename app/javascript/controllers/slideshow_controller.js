import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["button", "item"]
	static classes = ["activeButton", "hide"]
	static values = { currentItemIndex: Number }

	connect() {
		this.currentItemIndexValue ||= 0
	}

	changeItem(e) {
		e.preventDefault()

		const newItemIndex = this.buttonTargets.indexOf(e.target)

		e.target.classList.add(this.activeButtonClass)
		this.buttonTargets[this.currentItemIndexValue].classList.remove(this.activeButtonClass)

		this.itemTargets[this.currentItemIndexValue].classList.add(this.hideClass)
		this.itemTargets[newItemIndex].classList.remove(this.hideClass)

		this.currentItemIndexValue = newItemIndex
	}
}
