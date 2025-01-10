self.onmessage = function (event) {
  const { exerciseTime } = event.data;
  console.log("exerciseTime", exerciseTime);
  const targetTime = new Date(exerciseTime).getTime();

  function updateCountdown() {
    const now = new Date().getTime();
    const diff = targetTime - now;

    if (diff <= 0) {
      self.postMessage({ status: "exercise" });
      clearInterval(interval);
      return;
    }

    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    self.postMessage({
      status: "countdown",
      timeString: `${minutes.toString().padStart(2, "0")}:${seconds
        .toString()
        .padStart(2, "0")}`,
    });
  }

  updateCountdown();
  const interval = setInterval(updateCountdown, 1000);
};
