$(window).scroll(function () {
   if ($(window).scrollTop() >= $(document).height() - $(window).height() - 500) {
      console.log("LOAD");
   }
});
