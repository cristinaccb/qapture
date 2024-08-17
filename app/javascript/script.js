let imgCounter = 3;  

document.addEventListener("click", function (event) {
  const clickSound = new Audio("./assets/click-sfx.mp3");
  clickSound.play();

  let container = document.createElement("div");
  container.innerHTML = `<div class="img-container">
                             <img src="./assets/img-${imgCounter}.jpg" alt="" />
                         </div>`;
  imgCounter = imgCounter >= 5 ? 3 : imgCounter + 1;  // Resets after 5, cycles back to 3

  const appendedElement = container.firstChild;
  document.querySelector(".items-container").appendChild(appendedElement);

  appendedElement.style.left = `${event.clientX - 700 / 2}px`;  // assuming elementWidth = 700
  appendedElement.style.top = `${event.clientY}px`;
  const randomRotation = Math.random() * 10 - 5;

  gsap.set(appendedElement, {
    scale: 0,
    rotation: randomRotation,
    transformOrigin: "center",
  });

  const tl = gsap.timeline();
  const randomScale = Math.random() * 0.5 + 0.5;
  tl.to(appendedElement, {
    scale: randomScale,
    duration: 0.5,
    delay: 0.1,
  });

  tl.to(
    appendedElement,
    {
      y: () => `-=500`,
      opacity: 1,
      duration: 4,
      ease: "none",
    },
    "<"
  ).to(
    appendedElement,
    {
      opacity: 0,
      duration: 1,
      onComplete: () => {
        appendedElement.parentNode.removeChild(appendedElement);
        const index = itemsArray.indexOf(appendedElement);
        if (index > -1) {
          itemsArray.splice(index, 1);
        }
      },
    },
    "-=0.5"
  );
});
