
$(document).ready(function(){

  window.addEventListener("message", function(event){
    if (event.data.action == "updateStatus"){
      updateStatus(event.data.eat, event.data.drink);
    }else if (event.data.action == "updateImage"){
      updateImage(event.data.mugshotStr)
    }
    else if (event.data.action == "toggle"){
			if (event.data.show){
				$('#uist').show();
			} else{
				$('#uist').hide();
      }
    }
  });
  
  function updateStatus(eat, drink){



    setProgress(eat+'%','.progress-hunger');
    setProgress(drink+'%','.progress-thirst');
	setProgress(drink+'%','.progress-armor');
  }	
  // Functions
  // Update health/thirst bars
  function setProgress(percent, element){
    $(element).width(percent);
  }

  // Clock based on user's local hour
  function updateClock() {
    var now = new Date(),
        time = (now.getHours()<10?'0':'') + now.getHours() + ':' + (now.getMinutes()<10?'0':'') + now.getMinutes();
    setTimeout(updateClock, 1000);
  }
  updateClock();

});

