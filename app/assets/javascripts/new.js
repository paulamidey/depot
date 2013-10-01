$(function(){
  $(document).on("click","#pop",function(){
    $('#popup').bPopup({
            follow: [false, false], //x, y
            position: [150, 400] //x, y
        });

  });
});
           