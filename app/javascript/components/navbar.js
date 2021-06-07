
const navbarScroll = () => {
  const navbar = document.querySelector('.navbar');
  // const showBgc = document.querySelector('.navbar-collapse');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 60) {
        navbar.classList.add('navbar-lewagon-dark');
      } else {
        navbar.classList.remove('navbar-lewagon-dark');
      }
    })
  }
}

export { initUpdateNavbarOnScroll };
