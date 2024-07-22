import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"
import { showElement, hideElement, generateGetBoundingClientRect, elementIsFullyVisible } from "../helpers/dom_helper"

export default class extends Controller {
	static targets = ["button", "closeButton", "popupContainer", "popupContent", "backdrop", "arrow"]
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
		hideElement(this.popupContainerTarget)
		hideElement(this.backdropTarget)
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
			showElement(this.popupContainerTarget)
			showElement(this.backdropTarget)
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
