import { Controller } from "@hotwired/stimulus";

const LOCAL_STORAGE_KEY = "move_frequently::added-to-bookmarks";

export default class extends Controller {
  connect() {
    if (!localStorage.getItem(LOCAL_STORAGE_KEY)) {
      const userAgent = navigator.userAgent.toLowerCase();
      if (this.isDesktop(userAgent)) {
        if (this.isMac(userAgent)) {
          document.getElementById("shortcut-mac").classList.remove("hidden");
          document.getElementById("shortcut-pc").classList.add("hidden");
        } else {
          document.getElementById("shortcut-pc").classList.remove("hidden");
          document.getElementById("shortcut-mac").classList.add("hidden");
        }
        this.element.classList.remove("hidden");
      }
    }
  }

  dismiss() {
    localStorage.setItem(LOCAL_STORAGE_KEY, true);
    this.element.classList.add("hidden");
  }

  isDesktop(userAgent) {
    return !/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(
      userAgent
    );
  }

  isMac() {
    return /macintosh/i.test(navigator.userAgent.toLowerCase());
  }
}
