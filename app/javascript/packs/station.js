setTimeout(function(){
    if(document.querySelector(".notice")){
      var msg = document.querySelector(".notice");
    }
    else {
      var msg = document.querySelector(".alert");
    }
    msg.parentNode.removeChild(msg);
}, 3000);
