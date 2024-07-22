export function showElement(element, cssClass="hidden") {
  element.classList.remove(cssClass)
}

export function hideElement(element, cssClass="hidden") {
  element.classList.add(cssClass)
}

export function scrollToElement(element, position = "center") {
	element?.scrollIntoView({ behavior: "instant", block: position, inline: position })
}

export function generateGetBoundingClientRect(x = 0, y = 0) {
  return () => ({
    width: 0,
    height: 0,
    top: y,
    right: x,
    bottom: y,
    left: x,
  });
}

export function elementIsFullyVisible(element) {
  const rect = element.getBoundingClientRect()

  return (
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
    rect.right <= (window.innerWidth || document.documentElement.clientWidth)
  )
}
