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

    const updater = function () {
      const now = new Date().getTime();
      const dueIn = exerciseTime - now;

      if (dueIn <= 0) {
        this.#finishCountdown(countdownContainer, exerciseContainer);
      } else {
        this.#updateCountdown(countdownElement, dueIn);
      }
    }.bind(this);

    updater();
    this.refreshInterval = setInterval(updater, 1000);
  }

  disconnect() {
    if (this.refreshInterval) {
      clearInterval(this.refreshInterval);
    }
  }

  #updateCountdown(countdownElement, dueIn) {
    const minutes = Math.floor((dueIn % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((dueIn % (1000 * 60)) / 1000);

    const timeString = `${minutes.toString().padStart(2, "0")}:${seconds
      .toString()
      .padStart(2, "0")}`;
    countdownElement.textContent = timeString;
    document.title = `${timeString} until next exercise`;
  }

  #finishCountdown(countdownContainer, exerciseContainer) {
    const sendNotification = () => {
      const exerciseName = exerciseContainer.querySelector("h1").textContent;
      new Notification(`Time to Exercise!`, {
        body: `${exerciseName.trim()} is ready`,
        icon: "/icon.png",
      });
    };

    countdownContainer.style.display = "none";
    exerciseContainer.style.display = "flex";
    document.title = "Time to Exercise!";

    if (Notification.permission === "granted") {
      sendNotification();
    } else if (Notification.permission !== "denied") {
      Notification.requestPermission().then((permission) => {
        if (permission === "granted") {
          sendNotification();
        }
      });
    }

    const audio = new Audio(
      "https://www.myinstants.com/media/sounds/bereal.mp3"
    );
    audio.play().catch((error) => console.error("Error playing sound:", error));
    clearInterval(this.refreshInterval);

    return;
  }
}
