var intervalId;

function launchAudio(section) {
    var audios = section.getElementsByTagName("audio");
    if (audios.length === 0)
	return;
    var audio = audios[0];
    
    function playbackHandler() {
	var lis = section.getElementsByTagName("li");
	if(lis.length != 0) {
	    for(var i = 0; i < lis.length; i++) {
		var li = lis[i];
		
		if(li.dataset.timecode) {
		    var timecode = parseFloat(li.dataset.timecode);
		    if(!isNaN(timecode) && audio.currentTime < timecode)
			li.style.opacity = 0;
		    else
			li.style.opacity = 1;
		}
	    }
	}
    }
    
    intervalId = window.setInterval(playbackHandler,500);
    audio.play();
}

function stopAll() {
    var audios = document.getElementsByTagName("audio");
    for(var i = 0; i < audios.length; i++) {
	var audio = audios[i];
	audio.pause();
	window.clearInterval(intervalId);
    }    
}

function changeTo(section) {    
    return function() {
	if(document.body.id == "show-" + section.id)
	    return;
	
	stopAll();
	
	document.body.id = "show-" + section.id;
	launchAudio(section);
    };
}

function init() {
    var sections = document.querySelectorAll("body > section");
    for(var i = 0; i < sections.length; i++) {
	var section = sections[i];
	
	section.onclick = changeTo(section);
	
	/*var lis = section.getElementsByTagName("li");
	if(lis.length != 0) {
	    for(var j = 0; j < lis.length; j++) {
		lis[j].style.opacity = 0;
		lis[j].style.transition = "opacity 0.3s";
	    }
	}*/
	
	if(document.body.id == "show-" + section.id)
	    launchAudio(section);
    }
}
