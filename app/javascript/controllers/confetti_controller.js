import { Controller } from "@hotwired/stimulus";
import JSConfetti from "js-confetti";

// Connects to data-controller="confetti"
export default class extends Controller {
  connect() {
    // // Create a copy of the button that is not displayed
    this.button = this.element.querySelector("a").cloneNode(true);
    this.button.removeAttribute("data-action");
    this.button.style.display = "none";
    this.element.appendChild(this.button);
  }

  async launch(event) {
    event.preventDefault();

    const confetti = new JSConfetti();
    await confetti.addConfetti({
      confettiNumber: 200,
      confettiSize: 1,
    });

    this.button.click();
  }
}
