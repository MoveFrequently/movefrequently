import { Controller } from "@hotwired/stimulus";
import JSConfetti from "js-confetti";

// Connects to data-controller="confetti"
export default class extends Controller {
  connect() {}

  async launch(event) {
    event.preventDefault();
    const target = event.currentTarget.href;

    const confetti = new JSConfetti();
    await confetti.addConfetti({
      confettiNumber: 200,
      confettiSize: 1,
    });

    window.location.href = target;
  }
}
