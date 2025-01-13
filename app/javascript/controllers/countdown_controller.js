import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["countdown", "exercise", "countdownElement"];

  updateCountdown() {
    const countdownContainer = this.countdownTarget;
    const exerciseContainer = this.exerciseTarget;
    const countdownElement = this.countdownElementTarget;

    const now = new Date().getTime();
    const diff = this.exerciseTime - now;

    if (diff <= 0) {
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
      return;
    }

    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    const timeString = `${minutes.toString().padStart(2, "0")}:${seconds
      .toString()
      .padStart(2, "0")}`;
    countdownElement.textContent = timeString;
    document.title = `LiveLonger - Next in ${timeString}`;
  }

  connect() {
    this.exerciseTime = new Date(
      this.element.getAttribute("data-time")
    ).getTime();

    updateCountdown();
    this.interval = setInterval(updateCountdown, 1000);
  }

  disconnect() {
    clearInterval(this.interval);
  }
}
