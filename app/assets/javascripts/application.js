// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  $(document).keydown(function(e){
    if (e.which == 37) {
      prev = $("nav.pagination .page.current").prev().children();
      console.log(prev.text());
      //prev.click();
      if (typeof prev.attr('href')  !== "undefined" )
        window.location.href = prev.attr('href');
    }

    if (e.which == 39) {
      next = $("nav.pagination .page.current").next().children();
      console.log(next.text());
      //prev.click();
      if (typeof next.attr('href')  !== "undefined" )
        window.location.href = next.attr('href');
    }
    console.log(e.which);
  });

});
