import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:click", (event) => {
      const eventName = event.target.getAttribute("data-analytics-event");
      if (eventName) {
        if (window.sa_event) window.sa_event(eventName);
      }
      if (window.sa_pageview) window.sa_pageview(event.detail.url);
    });
  }
}
