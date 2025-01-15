import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "countdown",
    "exercise",
    "countdownElement",
    "exerciseProgress",
    "exerciseTimeLeft",
  ];

  connect() {
    if ("Notification" in window && Notification.permission === "default") {
      Notification.requestPermission().then((permission) => {
        console.log("permission granted", permission);
      });
    }

    const countdownContainer = this.countdownTarget;
    const exerciseContainer = this.exerciseTarget;
    const countdownElement = this.countdownElementTarget;
    const exerciseProgress = this.exerciseProgressTarget;
    const exerciseTimeLeft = this.exerciseTimeLeftTarget;
    const exerciseTime = new Date(
      this.element.getAttribute("data-time")
    ).getTime();

    const updater = function () {
      const now = new Date().getTime();
      const dueIn = exerciseTime - now;

      if (dueIn <= 0) {
        this.#finishCountdown(
          countdownContainer,
          exerciseContainer,
          exerciseProgress,
          exerciseTimeLeft
        );
      } else {
        this.#updateCountdown(countdownElement, dueIn);
      }
    }.bind(this);

    updater();
    this.countdownInterval = setInterval(updater, 1000);
  }

  disconnect() {
    if (this.countdownInterval) {
      clearInterval(this.countdownInterval);
    }
    if (this.exerciseInterval) {
      clearInterval(this.exerciseInterval);
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

  #finishCountdown(
    countdownContainer,
    exerciseContainer,
    exerciseProgress,
    exerciseTimeLeft
  ) {
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

    if (window.Notification) {
      if (Notification.permission === "granted") {
        sendNotification();
      }
    }

    if (window.Audio) {
      const audio = new Audio(
        "https://www.myinstants.com/media/sounds/bereal.mp3"
      );
      audio
        .play()
        .catch((error) => console.error("Error playing sound:", error));
    }

    clearInterval(this.countdownInterval);
    this.#startExercise(exerciseProgress, exerciseTimeLeft);
    return;
  }

  #startExercise(exerciseProgress, exerciseTimeLeft) {
    const exerciseDuration = exerciseProgress.getAttribute(
      "data-exercise-duration-seconds"
    );
    const exerciseTargetUrl = exerciseProgress.getAttribute(
      "data-exercise-target-url"
    );
    const startTime = Date.now();

    const updater = () => {
      const timeElapsed = Date.now() - startTime;
      const percentComplete = (timeElapsed / (exerciseDuration * 1000)) * 100;
      const timeLeft = exerciseDuration - timeElapsed / 1000;

      if (percentComplete >= 100 || timeLeft <= 0) {
        this.#finishExercise(exerciseTargetUrl);
      } else {
        exerciseProgress.style.width = `${percentComplete}%`;
        const minutes = Math.floor(timeLeft / 60);
        const seconds = Math.floor(timeLeft % 60);
        exerciseTimeLeft.textContent = `${minutes
          .toString()
          .padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;
      }
    };

    this.exerciseInterval = setInterval(updater, 10);
  }

  #finishExercise(exerciseTargetUrl) {
    clearInterval(this.exerciseInterval);

    const link = document.createElement("a");
    link.setAttribute("data-turbo-frame", "body");
    link.href = exerciseTargetUrl;
    document.body.appendChild(link);
    link.click();
  }
}
