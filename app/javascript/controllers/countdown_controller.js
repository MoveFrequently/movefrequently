import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const timeElement = this.element.querySelector(".utc-time");
    this.exerciseTime = new Date(timeElement.dataset.time);
    this.exerciseContainer = document.getElementById("exercise-container");
    this.countdownContainer = document.getElementById("countdown-container");
    this.countdownElement = document.getElementById("countdown");
    this.notificationSent = false;

    // Request notification permission on connect
    if (Notification.permission === "default") {
      Notification.requestPermission();
    }

    this.updateCountdown();
    this.interval = setInterval(this.updateCountdown.bind(this), 1000);
  }

  disconnect() {
    if (this.interval) {
      clearInterval(this.interval);
    }
  }

  updateCountdown() {
    const now = new Date();
    const diff = this.exerciseTime - now;

    if (diff <= 0) {
      this.countdownContainer.style.display = "none";
      this.exerciseContainer.style.display = "flex";
      document.title = "LiveLonger - Time to Exercise!";

      // Send notification if not already sent
      if (!this.notificationSent && Notification.permission === "granted") {
        new Notification("Time to Exercise!", {
          body: "Your next exercise is ready",
          icon: "/icon.png",
        });
        this.notificationSent = true;
      }
      return;
    }

    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    const timeString = `${minutes.toString().padStart(2, "0")}:${seconds
      .toString()
      .padStart(2, "0")}`;
    this.countdownElement.textContent = timeString;
    document.title = `LiveLonger - Next in ${timeString}`;
  }
}
