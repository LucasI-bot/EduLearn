function deleteOption(button){
  if(button.parentNode.nextElementSibling){
    if( button.parentNode.nextElementSibling.nodeName === "INPUT" ){
      button.parentNode.nextElementSibling.remove();
    };
  };
  
  button.parentNode.remove();
}