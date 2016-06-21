/*!
 * Start Bootstrap - Agency Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({
    target: '.navbar-fixed-top'
})

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});


function video_controller() {
	var video = document.getElementById("video-background");
	if (video.paused) {
        video.play();
     } else {
        video.pause();
     }	
}

function video_controller2() {
	var video = document.getElementById("video-background");
	//div>a.collapsed는 Stop&Play 버튼의 상태를 찾는 것임
	//Stop&Play를 눌러서 동영상이 정지되고 이미지가 뜨게 되면  collapsed라는 클래스가 생김.
	var check_pause = $("div>a.collapsed").val();
	//Stop&Play 버튼을 누르지 않고 동영상이 실행되고 있는경우
	if (check_pause == null && !video.paused) {
		video.pause();
	//Stop&Play 버튼을 누르지 않고 동영상이 정지되어 있는경우
	} else if(check_pause == null && video.paused) {
		video.play();
	//Stop&Play 버튼을 눌렀고 동영상이 정지되어 있는경우
	} else if(check_pause != null && video.paused) {
		video.pause();
	//그외의 모든 경우
	} else {
		video.pause();
	}
}