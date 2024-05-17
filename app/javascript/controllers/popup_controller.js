import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"
import { generateGetBoundingClientRect, elementIsFullyVisible } from "../helpers/dom_helper"

export default class extends Controller {
	static targets = ["button", "closeButton", "popupContainer", "popupContent", "backdrop", "arrow"]
	static classes = ["hide"]
	static values = {
										placement: { type: String, default: "top" },
										strategy: { type: String, default: "fixed" },
	                  preventDefault: { type: Boolean, default: true },
	                }

	#isOpen

	connect() {
		this.#isOpen = false
	}

	toggle(event) {
		if (this.preventDefaultValue) event.preventDefault()

		if (this.popupContainerTarget.classList.contains(this.hideClass)) {
			this.open(event)
		} else {
			this.close(event)
		}
	}

	open(event) {
		if (this.preventDefaultValue) event.preventDefault()

		this.#isOpen = true
		this.#createPopper(event)
		if (this.hasPopupContentTarget) this.popupContentTargetConnected()
	}

	close(event) {
		this.popupContainerTarget.classList.add(this.hideClass)
		this.backdropTarget.classList.add(this.hideClass)
		this.#isOpen = false
	}

	submitEnd(event) {
		if (event.detail.success) {
			this.close()
		}
	}

	popupContentTargetConnected(element) {
		if (this.#isOpen) {
			this.popperInstance?.update()
			this.popupContainerTarget.classList.remove(this.hideClass)
			this.backdropTarget.classList.remove(this.hideClass)
		}
	}

	#createPopper(event) {
		this.popperInstance =
			createPopper(this.buttonTarget, this.popupContainerTarget, {
				placement: this.placementValue,
				modifiers: [
					{
			      name: "offset",
			      options: {
			        offset: [0, 8],
			      },
			    },
			    {
			    	name: "eventListeners",
			    	options: {
			    		scroll: false
			    	}
			    },
				]
			})
	}
}
