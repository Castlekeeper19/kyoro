const initLoadingBar = () => {
  const allBars = document.querySelectorAll(".loading-progress");
  allBars.forEach(bar => {
    bar.innerHTML = '';
   const barId = bar.dataset.id;
    new ldBar(`.bar-${barId}`, {
      // "stroke": '#f00',
      // "stroke-width": 10,
      // "preset": "fan",
      // "value": 65
    })
  });
}

export { initLoadingBar };
