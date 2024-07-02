export function turboRequest(url) {
	const token = document.head.querySelector("meta[name='csrf-token']").getAttribute("content")

  fetch(url, {
    headers: {
      "X-CSRF-Token": token,
      "Accept": "text/vnd.turbo-stream.html",
    },
  }).then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
}
