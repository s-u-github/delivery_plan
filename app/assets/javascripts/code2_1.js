
var latitude = gon.latitude;
var longitude = gon.longitude;
var count = gon.count;
var pointArray = [];

function initialize() {
  if (GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById("map_canvas"));
    map.setCenter(new GLatLng(35.681379,139.765577), 13);

    var directions = new GDirections(map, document.getElementById('route'));
    
        // var point0 = new GLatLng(latitude[i], longitude[i]);
      // var point1 = new GLatLng(latitude[0], longitude[0]);
      // var point1 = new GLatLng(35.62758190931674,139.88754272460938);
    // var point2 = new GLatLng(35.63100031817364,139.77622032165527);
    // var point3 = new GLatLng(35.66489743718014,139.76690769195557);
    
    
    for(var i = 0; i < 2; i++){
    　this["point" + i] = new GLatLng(latitude[i], longitude[i]);  // 配列latitude,longitudeの値を変数point1~連番で挿入

    pointArray.push(this["point" + i]);  // 作成したpoin1~を地図表示用の配列に挿入
    }
    directions.loadFromWaypoints(pointArray, {locale: 'ja_JP'});  // 地図上に指定した場所間のルート表示
  }
}
