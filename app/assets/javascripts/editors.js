$(function(){
  $("#bjeditor").click(function(){
    alert(1);
    $(".xiugai").css("display", "table-cell");
  });

  $("form.fxg select").change(function(e){
    $(this).parent().submit();
  });

})
