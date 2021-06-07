
const navbarScroll = () => {
  const navbar = document.querySelector('.navbar');
  console.log(navbar);
  // const showBgc = document.querySelector('.navbar-collapse');
  if (navbar) {
    window.addEventListener('scroll', () => {
      console.log(window.scrollY);
      if (window.scrollY >= 5) {
        navbar.classList.add('navbar-white');
      } else {
        navbar.classList.remove('navbar-white');
      }
    })
  }
}

export { navbarScroll };
