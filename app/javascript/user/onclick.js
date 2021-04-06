document.addEventListener("turbolinks:load",
function(){
  $(document).ready(function(){
    $(".iconClick").click(function(){
      if ($("#trigger").css("display")=="none"){
        $("#trigger").css("display","block");
      }
      else {
        $("#trigger").css("display","none");
      }
    });
  });
})
