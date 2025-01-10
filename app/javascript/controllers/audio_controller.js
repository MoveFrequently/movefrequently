import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {}

  resumeAudioContext() {
    // Resume AudioContext if it was suspended (needed for some browsers)
    if (window.AudioContext || window.webkitAudioContext) {
      const AudioContext = window.AudioContext || window.webkitAudioContext;
      window.audioContext = new AudioContext();
      if (window.audioContext.state === "suspended") {
        window.audioContext.resume();
      }
    }
  }
}
