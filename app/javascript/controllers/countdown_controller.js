import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["countdown", "exercise", "countdownElement"];

  connect() {
    const countdownContainer = this.countdownTarget;
    const exerciseContainer = this.exerciseTarget;
    const countdownElement = this.countdownElementTarget;

    const exerciseTime = new Date(
      this.element.getAttribute("data-time")
    ).getTime();

    const updater = this.#updater(
      countdownContainer,
      exerciseContainer,
      countdownElement,
      exerciseTime
    );

    updater();
    this.interval = setInterval(updater, 1000);
  }

  disconnect() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  }

  #update(countdownElement, dueIn) {
    const minutes = Math.floor((dueIn % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((dueIn % (1000 * 60)) / 1000);

    const timeString = `${minutes.toString().padStart(2, "0")}:${seconds
      .toString()
      .padStart(2, "0")}`;
    countdownElement.textContent = timeString;
    document.title = `LiveLonger - ${timeString} until next exercise`;
  }

  #finish(countdownContainer, exerciseContainer) {
    countdownContainer.style.display = "none";
    exerciseContainer.style.display = "flex";
    document.title = "LiveLonger - Time to Exercise!";

    if (Notification.permission === "granted") {
      new Notification("Time to Exercise!", {
        body: "Your next exercise is ready",
        icon: "/icon.png",
      });
    }

    const audio = new Audio(
      "https://www.myinstants.com/media/sounds/bereal.mp3"
    );
    audio.play().catch((error) => console.error("Error playing sound:", error));
    clearInterval(this.interval);

    return;
  }

  #updater(
    countdownContainer,
    exerciseContainer,
    countdownElement,
    exerciseTime
  ) {
    return function () {
      const now = new Date().getTime();
      const dueIn = exerciseTime - now;

      if (dueIn <= 0) {
        this.#finish(countdownContainer, exerciseContainer);
      } else {
        this.#update(countdownElement, dueIn);
      }
    }.bind(this);
  }
}
