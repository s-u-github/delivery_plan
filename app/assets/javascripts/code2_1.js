
var latitude = gon.latitude;
var longitude = gon.longitude;
var address = gon.address
var count = gon.count;
var pointArray = [];

// function initialize() {
//   if (GBrowserIsCompatible()) {
//     var map = new GMap2(document.getElementById("map_canvas"));
//     map.setCenter(new GLatLng(latitude[0],longitude[0]), 13);

//     var directions = new GDirections(map, document.getElementById('route'));
    
//         // var point0 = new GLatLng(latitude[i], longitude[i]);
//       // var point1 = new GLatLng(latitude[0], longitude[0]);
//       // var point1 = new GLatLng(35.62758190931674,139.88754272460938);
//     // var point2 = new GLatLng(35.63100031817364,139.77622032165527);
//     // var point3 = new GLatLng(35.66489743718014,139.76690769195557);
    
    
//     for(var i = 0; i < count; i++){
//     // 　this["point" + i] = new GLatLng(latitude[i], longitude[i]);  // 配列latitude,longitudeの値を変数point1~連番で挿入

//     pointArray.push(this["point" + i]);  // 作成したpoin1~を地図表示用の配列に挿入
//     // pointArray.push(address[i]);  住所指定で作成する場合
//     }
//     directions.loadFromWaypoints(pointArray, {locale: 'ja_JP'});  // 地図上に指定した場所間のルート表示
//   }
// }

/* ページ読み込み時に地図を初期化 */
function initialize() {
  /* 緯度・経度：日本, 表参道駅（東京）*/
  var latlng=new google.maps.LatLng(35.6652470, 139.7123140);
  /* 地図のオプション設定 */
  var myOptions = {
    zoom: 14, /*初期のズーム レベル */
    center: latlng, /* 地図の中心地点 */
    mapTypeId: google.maps.MapTypeId.HYBRID /* 地図タイプ */
  };
  /* 地図オブジェクト生成 */
  var map=new google.maps.Map(document.getElementById('map_canvas'), myOptions);
}


// function initialize() {
// var latlng = new google.maps.LatLng(33.889577,130.885284);
// var opts = {
// //地図の縮尺
// zoom: 15,
// //地図の中心座標
// center: latlng,
// //地図の種類
// mapTypeId: google.maps.MapTypeId.ROADMAP,
// };
// //マップの表示
// var map = new GMap2(document.getElementById("map_canvas"), opts);
// }
// window.onload = initialize;