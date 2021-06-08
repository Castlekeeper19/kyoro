//slickJS
import "slick-carousel/slick/slick"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"


const initSlick = () => {
  $('.review-carousel').slick({
      mobileFirst: true,
      slidesToShow: 1,
      slidesToScroll: 1,
      autoplay: true,
      autoplaySpeed: 1800,
      responsive: [{

      breakpoint: 922,
      settings: {
        slidesToShow: 3,
        // infinite: true
      }

    }, {
      breakpoint: 768,
      settings: {
        slidesToShow: 2
      }
    }]
  });
}

export { initSlick };

