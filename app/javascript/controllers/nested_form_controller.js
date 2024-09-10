import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["add_item", "template"]

  add_association(event) {
    event.preventDefault()
    const pattern = `TEMPLATE_RECORD_${this.element.dataset.level}`;
    let content = this.templateTarget.innerHTML.replace(new RegExp(pattern, "g"), new Date().getTime());
    this.add_itemTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }
}