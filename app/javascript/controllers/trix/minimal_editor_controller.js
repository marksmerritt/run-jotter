import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  get toolGroupsToRemove() {
    return ["history-tools"]
  }

  get toolsToRemove() {
    return ["strike", "code", "quote"]
  }

  connect() {
    this.#removeToolGroups()
    this.#removeTools()
  }

  #removeToolGroups() {
    for(const groupName of this.toolGroupsToRemove) {
      this.#removeToolGroup(groupName)
    }
  }

  #removeToolGroup(groupName) {
    const toolGroup = this.element.querySelector(`[data-trix-button-group='${groupName}']`)
    if (toolGroup) toolGroup.remove()
  }

  #removeTools() {
    for(const toolName of this.toolsToRemove) {
      this.#removeTool(toolName)
    }
  }

  #removeTool(toolName) {
    const toolElement = this.element.querySelector(`[data-trix-attribute='${toolName}']`)
    if (toolElement) toolElement.remove()
  }
}
