import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["countdown", "exercise", "countdownElement"];

  connect() {
    const countdownContainer = this.countdownTarget;
    const exerciseContainer = this.exerciseTarget;
    const countdownElement = this.countdownElementTarget;

    const workerPath = this.element.getAttribute("data-worker-path");
    const exerciseTime = this.element.getAttribute("data-time");

    this.worker = new Worker(workerPath);
    this.worker.onmessage = function (event) {
      const { status, timeString } = event.data;

      if (status === "exercise") {
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
        audio
          .play()
          .catch((error) => console.error("Error playing sound:", error));
      } else if (status === "countdown") {
        countdownElement.textContent = timeString;
        document.title = `LiveLonger - Next in ${timeString}`;
      }
    };

    this.worker.postMessage({ exerciseTime });
  }

  disconnect() {
    this.worker.terminate();
  }
}
