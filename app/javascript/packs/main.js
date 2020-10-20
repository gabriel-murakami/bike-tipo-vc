setTimeout(function(){
    var msg = '';
    if(document.querySelector(".notice")){
      msg = document.querySelector(".notice");
    }
    else {
      msg = document.querySelector(".alert");
    }
    msg.parentNode.removeChild(msg);
}, 3000);
