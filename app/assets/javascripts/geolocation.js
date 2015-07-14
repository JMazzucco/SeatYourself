function geolocationSuccess(position){
	var longitude = position.coords.longitude;
	var latitude = position.coords.latitude;

	console.log(longitude, latitude);

	$('.location-error').hide();
	$.ajax({
		url: '/restaurants',
		method: 'GET',
		data: {
			longitude: longitude,
			latitude: latitude
		},
		dataType: 'script'
	});
}

function geolocationError() {
	$('.location-error').show();
}

$(document).on('ready page:load', function() {
	$('#current-location').click(function(ev) {
		ev.preventDefault();

		if ("geolocation" in navigator) {
			navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);
		} else {
			alert("Get a better browser!!");
		}
	});
});