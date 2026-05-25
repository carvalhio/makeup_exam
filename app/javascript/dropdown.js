const initDropdown = () => {

  // MENU PRINCIPAL
  const button = document.getElementById("second-call-btn");
  const menu = document.getElementById("second-call-menu");

  if (!button || !menu) return;

  // EVITAR DUPLICAÇÃO
  if (button.dataset.dropdownInitialized === "true") return;

  button.dataset.dropdownInitialized = "true";

  // ABRIR MENU PRINCIPAL
  button.addEventListener("click", (event) => {

    event.stopPropagation();

    menu.classList.toggle("show");

  });

  // SUBMENUS
  const submenuTitles =
    document.querySelectorAll(".submenu-title");

  submenuTitles.forEach((title) => {

    title.addEventListener("click", (event) => {

      event.stopPropagation();

      const submenu =
        title.parentElement.querySelector(".submenu-content");

      if (submenu) {

        submenu.classList.toggle("show");

      }

    });

  });

  // FECHAR AO CLICAR FORA
  document.addEventListener("click", () => {

    menu.classList.remove("show");

    document
      .querySelectorAll(".submenu-content")
      .forEach((submenu) => {

        submenu.classList.remove("show");

      });

  });

  // IMPEDIR FECHAMENTO INTERNO
  menu.addEventListener("click", (event) => {

    event.stopPropagation();

  });

};

// TURBO
document.addEventListener("turbo:load", initDropdown);