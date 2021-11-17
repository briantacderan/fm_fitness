var isClicked = false;

document.querySelector("#original-content").addEventListener("click", function() {
  if (isClicked) {
    document.querySelector("#original-content").classList.remove("show");
    document.querySelector("#seasonal-content").classList.remove("hide");
    document.querySelector("img.seasonal").classList.remove("hide");
    document.querySelector("#category-background").classList.remove("hide");
    document.querySelector("#menu-section").classList.remove("move-og");
    document.querySelector("h1#original").classList.remove("move");
    document.querySelector("h1#seasonal").classList.remove("hide");
    document.querySelector("#bulletin-left.og").classList.remove("hide");
    document.querySelector("#bulletin-left.new").classList.remove("show");
    document.querySelector("#original-content").classList.remove("back");
  } else {
    document.querySelector("#original-content").classList.add("show");
    document.querySelector("#seasonal-content").classList.add("hide");
    document.querySelector("img.seasonal").classList.add("hide");
    document.querySelector("#category-background").classList.add("hide");
    document.querySelector("#menu-section").classList.add("move-og");
    document.querySelector("h1#original").classList.add("move");
    document.querySelector("h1#seasonal").classList.add("hide");
    document.querySelector("#bulletin-left.og").classList.add("hide");
    document.querySelector("#bulletin-left.new").classList.add("show");
    document.querySelector("#original-content").classList.add("back");
  }
  isOrigin = !isOrigin;
});

document.querySelector("#seasonal-content").addEventListener("click", function() {
  if (isSeason) {
    document.querySelector("#seasonal-content").classList.remove("show");
    document.querySelector("#original-content").classList.remove("hide");
    document.querySelector("img.original").classList.remove("hide");
    document.querySelector("#category-background").classList.remove("hide");
    document.querySelector("#menu-section").classList.remove("move-new");
    document.querySelector("h1#original").classList.remove("hide");
    document.querySelector("h1#seasonal").classList.remove("move");
    document.querySelector("#bulletin-left.og").classList.remove("show");
    document.querySelector("#bulletin-left.new").classList.remove("hide");
    document.querySelector("#seasonal-content").classList.remove("back");
  } else {
    document.querySelector("#seasonal-content").classList.add("show");
    document.querySelector("#original-content").classList.add("hide");
    document.querySelector("img.original").classList.add("hide");
    document.querySelector("#category-background").classList.add("hide");
    document.querySelector("#menu-section").classList.add("move-new");
    document.querySelector("h1#original").classList.add("hide");
    document.querySelector("h1#seasonal").classList.add("move");
    document.querySelector("#bulletin-left.og").classList.add("show");
    document.querySelector("#bulletin-left.new").classList.add("hide");
    document.querySelector("#seasonal-content").classList.add("back");
  }
  isSeason = !isSeason;
});
