import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'dropdown' ];
  connect() {
    // this.dropdownTarget.style.height = "0"
    this.dropdownTarget.style.overflow = "hidden"
    this.dropdownTarget.style.display = "none"
    this.dropdownTarget.style.transition = "display 0.2s ease-in"

  }

  expandDropdown(event) {
  if (this.dropdownTarget.style.display === "none") {
    this.dropdownTarget.style.display = "block";
  } else {
    this.dropdownTarget.style.display = "none";
  }
}
}
