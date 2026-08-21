document.addEventListener("turbo:load", () => {
  const allClasses = document.getElementById("allClasses");
  const selectedClasses = document.getElementById("selectedClasses");
  const classesSelection = document.getElementById("classesSelection");

  const selectAllClasses = document.getElementById("selectAllClasses");
  const clearAllClasses = document.getElementById("clearAllClasses");

  if (!allClasses || !selectedClasses || !classesSelection) {
    return;
  }

  function updateClassesSelection() {
    if (selectedClasses.checked) {
      classesSelection.classList.remove("d-none");
    } else {
      classesSelection.classList.add("d-none");
    }
  }

  allClasses.addEventListener("change", updateClassesSelection);
  selectedClasses.addEventListener("change", updateClassesSelection);

  selectAllClasses.addEventListener("click", () => {
    document.querySelectorAll(".class-checkbox").forEach((checkbox) => {
      checkbox.checked = true;
    });
  });

  clearAllClasses.addEventListener("click", () => {
    document.querySelectorAll(".class-checkbox").forEach((checkbox) => {
      checkbox.checked = false;
    });
  });

  updateClassesSelection();
});