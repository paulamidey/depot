//= require jquery
//= require jquery_ujs
//= require ckeditor-jquery
//= require_self
//= require_tree .

$(function(){
  $(document).on("click",'#select',function(){
    $('#nav').toggle();
  });
});

$(function(){
  $(document).on("click",'#pop',function(){
    $('#img').bPopup({
            follow: [false, false], //x, y
            position: [150, 400] //x, y
        });

  });
});

    
