import { Controller } from "@hotwired/stimulus";

const LOCAL_STORAGE_KEY = "move_frequently::tips::v1";

export default class extends Controller {
  connect() {
    console.log("tips connected");
    if (!localStorage.getItem(LOCAL_STORAGE_KEY)) {
      const userAgent = navigator.userAgent.toLowerCase();

      const onDismiss = () => {
        localStorage.setItem(LOCAL_STORAGE_KEY, true);
      };

      if (this.isDesktop(userAgent) && !this.isPWA()) {
        if (this.isChrome()) {
          this.showInstallPWA(onDismiss);
        } else {
          const saveShortcut = this.isMac(userAgent) ? "⌘ + D" : "Ctrl + D";
          this.showAddBookmarkTooltip(saveShortcut, onDismiss);
        }
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

  isChrome() {
    return /chrome/i.test(navigator.userAgent.toLowerCase());
  }

  isPWA() {
    return window.matchMedia("(display-mode: standalone)").matches;
  }

  isMac() {
    return /macintosh/i.test(navigator.userAgent.toLowerCase());
  }

  showAddBookmarkTooltip(shortcut, onDismiss = null) {
    const icon = `      
      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 0 24 24" width="24px" fill="#000000"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2zm0 15l-5-2.18L7 18V5h10v13z"/></svg>
    `;
    const inner = `
      <p>
        <b>Mara's tip:</b> Press <span class="text-gray-700 hover:text-gray-900 mono bg-gray-200 px-1">${shortcut}</span> to add Move Frequently to your bookmarks, then pin your tab, and never miss an exercise again!
      </p>
    `;

    this.showTooltip(icon, inner, onDismiss);
  }

  showInstallPWA(onDismiss = null) {
    const icon = `
      <svg xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" height="24px" viewBox="0 0 24 24" width="24px" fill="#000000"><g><rect fill="none" height="24" width="24"/></g><g><g><path d="M20,17H4V5h8V3H4C2.89,3,2,3.89,2,5v12c0,1.1,0.89,2,2,2h4v2h8v-2h4c1.1,0,2-0.9,2-2v-3h-2V17z"/><polygon points="17,14 22,9 20.59,7.59 18,10.17 18,3 16,3 16,10.17 13.41,7.59 12,9"/></g></g></svg>
    `;
    const inner = `
      <p>
        <b>Pablo's tip:</b> Using Chrome? Install Move Frequently as an app on your desktop.
      </p>
      <p>
        Find the download icon in the right side of the address bar,
      </p>
    `;
    this.showTooltip(icon, inner, onDismiss);
  }

  showTooltip(icon, inner, onDismiss = null) {
    const html = `
     <div class="tooltip fixed w-[300px] top-2 right-2 bg-white shadow-lg rounded-lg p-3 border border-gray-200 z-50">
        <div class="absolute -top-2 left-[50%] w-4 h-4 bg-white border-t border-l border-gray-200 transform rotate-45"></div>
        <div class="flex flex-row items-start gap-2 text-xs">
          <div class="flex w-5 -mt-1">
            ${icon}
          </div>          
          <div id="tooltiop-contents" class="flex flex-col space-y-2">
            ${inner}
              <p>
                <button class="dismiss-button text-xs underline text-gray-700 hover:text-gray-900 cursor-pointer">Dismiss</button>
              </p>
          </div>          
        </div>
      </div>
    `;

    const el = document.createElement("div");
    el.innerHTML = html;
    document.body.appendChild(el);
    el.querySelector(".dismiss-button").addEventListener("click", () => {
      if (onDismiss) {
        onDismiss();
      }
      document.body.removeChild(el);
    });
  }
}
