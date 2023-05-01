
var geocoder;
var map;

function initMap() {
  navigator.geolocation.getCurrentPosition(function(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    
    var latlng = new google.maps.LatLng(latitude, longitude);
      
    const blueIcon = {
      url: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png",
      scaledSize: new google.maps.Size(35, 35),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(25, 50),
    };
    window.map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
      center: latlng
    });
    geocoder = new google.maps.Geocoder();

    geocoder.geocode({ 'latLng': latlng }, function(results, status) {
        if (status === 'OK') {
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
          icon: blueIcon,
          title: "Your location"
        });
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });

    addStations()
    
  });

}

function addStations() {
  var station_info = $('.temp_information').data('temp')
 

  let all_stations = station_info[0]; 
  let page_stations = station_info[1];

  
  const infoWindow = new google.maps.InfoWindow();

  for (let station of all_stations) {
    const stationLatLng = { lat: Number(station["latitude"]), lng: Number(station["longitude"]) };
    const docked_bikes_id = station["id"] + "_docked"
    const station_element = document.getElementById(`${docked_bikes_id}`);

    const isPageStation = () => {
      var x;
      for (x of page_stations) {
        if (x["identifier"] === station["identifier"]){
          return true
        }
      }
      return false
    }

    const marker = new google.maps.Marker({
      map: map,
      position: stationLatLng,
      title: `${station["name"]}`,
      label: `${station["identifier"]}`,
      animation: null,
      optimized: false,
    });

    if (isPageStation()) {
      map.setCenter(stationLatLng);

      const contentString =
        "<div>" +
        `<h1>${station["name"]}</h1>` +
        '<div id="bodyContent" justify=space-between>' +
        `<p>${station["address"]}</p>` +
        `<p>${station_element.getAttribute('value')}</p>` +
        '<p>Total Docks: 10</p>' +
        "</div>" +
        "</div>";

      marker.addListener("click", () => {
        infoWindow.close();
        infoWindow.setContent(contentString);
        infoWindow.open(marker.getMap(), marker);
      });

      marker.setAnimation(google.maps.Animation.BOUNCE);
    }
  }
}