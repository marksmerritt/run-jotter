import { Controller } from "@hotwired/stimulus"
import { scrollToElement } from "../helpers/dom_helper"
import { turboRequest } from "../helpers/turbo_helper"

export default class extends Controller {
	static targets = [ "weekGroup", "week", "upCursor", "downCursor", "startDate", "endDate", "day" ]
	static classes = [ "flash" ]
	static values = { url: String }

	#selectedDay

	connect() {
		this.#selectedDay = this.dayTargets.find((day) => day.dataset.calendarSelectedDate == "true")
		this.#jumpToSelectedDay()
		this.#initCursorObserver()
	}

	handleCusor(cursor) {
		const cursorDirection = cursor == this.upCursorTarget ? "up" : "down"
		const startDate = cursor == this.upCursorTarget ? this.dayTargets[0].id : this.dayTargets[this.dayTargets.length - 1].id
		const url = `${this.urlValue}?start_date=${startDate}&direction=${cursorDirection}`

    turboRequest(url)
	}

	weekGroupTargetConnected(element) {
		const scrollDirection = element.dataset.weeklyCalendarScrollDirection

		switch (scrollDirection) {
			case "up":
				scrollToElement(this.weekGroupTargets[1], "start")
			case "down":
				scrollToElement(this.weekGroupTargets[-2], "end")
		}
	}

	#jumpToSelectedDay() {
		if (this.#selectedDay) {
			scrollToElement(this.#selectedDay)
			this.#flashDay(this.#selectedDay)
			this.#clearSelectedDay()
		}
	}

	#initCursorObserver() {
		const observer = new IntersectionObserver((entries) => {
		  if(entries[0].isIntersecting){
		    this.handleCusor(entries[0].target)
		  }
		})

		observer.observe(this.upCursorTarget)
		observer.observe(this.downCursorTarget)
	}

	#flashDay(dayElement) {
		dayElement?.classList?.add(this.flashClass)
	}

	#clearSelectedDay() {
		if (this.#selectedDay) {
			this.#selectedDay.dataset.calendarSelectedDate = false
		}
	}
}
