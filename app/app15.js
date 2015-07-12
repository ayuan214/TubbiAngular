var cusine_types_en = ["Schezwan", "Taiwanese", "Beijing", "Cantonese"];
var cusine_types_ch = ["川菜", "台灣小吃", "京菜", "廣東菜"];
/*$.each(crusine_types_en, function(index,value){
console.log(index,value);
});*/
var formdata = new Object();
formdata.lat_local = 38.537205;
formdata.long_local = -121.752466;
formdata.asr_results = "All";
formdata.language_local = "cmn-Hant-TW";
formdata.reco_language = formdata.language_local;
formdata.gps_bool = false; 
var init_markers = [];
var init_map; 
//formdata.gps_first = 0;
//formdata.asr_results = "台灣小吃";
//formdata.language_local = "cmn-Hant-TW";
var language_local = formdata.language_local;
var language_sel = "";

var app = angular.module('myApp', ['ui.bootstrap', 'geolocation']);
app.filter('startFrom', function () {
    return function (input, start) {
        if (input) {
            start = +start; //parse to int
            return input.slice(start);
        }
        return [];
    }
});

app.controller('customersCrtl', function ($scope, $http, $timeout, geolocation) {
    $scope.language_local = formdata.language_local;
    $scope.markers = init_markers;
    $scope.map = init_map; 
    $scope.formdata = new Object();
    $scope.formdata.lat_local = 38.537205;
    $scope.formdata.long_local = -121.752466;
    $scope.formdata.asr_results = "All";
    $scope.formdata.language_local = "cmn-Hant-TW";
    $scope.formdata.reco_language = $scope.formdata.language_local;
    $scope.formdata.gps_bool = false; 

    console.log($scope.formdata);
    
    //console.log($scope.map);
    $scope.setPage = function (pageNo) {
        $scope.currentPage = pageNo;
    };
    $scope.filter = function () {
        $timeout(function () {
            $scope.filteredItems = $scope.filtered.length;
        }, 10);
    };
    $scope.sort_by = function (predicate) {
        $scope.predicate = predicate;
        $scope.reverse = !$scope.reverse;
    };

    $scope.loadData = function () {
        $http.post('ajax/getCustomers1.php', JSON.stringify($scope.formdata)).success(function (data) {
            //var yelp_results = {};
            //console.log($scope.formdata);
            $scope.list = data;
            //console.log($scope.list[0]); 

            /*
            for (var i=0; i<$scope.list.length; i++) {
                //console.log($scope.list[i].bizID);
                setTimeout(function(x) { return function() { yelp($scope.list[x]); }; }(i), 300*i);
              
            }*/
                

            $scope.markers = init_markers;
            $scope.map = init_map; 
            $scope.currentPage = 1; //current page
            $scope.entryLimit = 50; //max no of items to display in a page
            $scope.filteredItems = $scope.list.length; //Initially for no filter  
            $scope.totalItems = $scope.list.length;
            //console.log(formdata);
            //$scope.language_local = 'en-US';
            //console.log($scope.language_local);
            $scope.lat = formdata.lat_local;
            $scope.lon = formdata.long_local;
            $scope.gps_bool = formdata.gps_bool; 
            //$scope.gps_bool = formdata.gps_first; 
            //console.log($scope.list);
 
            //reload the result map
            $scope.initLoad = 0;
            resultMap($scope.list, $scope.gps_bool, $scope.lat, $scope.lon, $scope.language_local, $scope.markers, $scope.map);
        });  
    };

    $scope.langchange = function(language) {
        if (language == 'en-US') {
            $('#jumbo-greeting').text('Find the best Chinese food in the San Gabriel Valley!');
            $('#jumbo-instructions').text('Click one of the categories below to begin.');
            $('#schezwan_title').text(cusine_types_en[0]);
            $('#taiwan_title').text(cusine_types_en[1]);
            $('#beijing_title').text(cusine_types_en[2]);
            $('#canto_title').text(cusine_types_en[3]);
        } else {
            $('#jumbo-greeting').text('尋找在 San Gabriel Valley 最好吃的中國菜!');
            $('#jumbo-instructions').text('請點選下列仼一菜式.');
            $('#schezwan_title').text(cusine_types_ch[0]);
            $('#taiwan_title').text(cusine_types_ch[1]);
            $('#beijing_title').text(cusine_types_ch[2]);
            $('#canto_title').text(cusine_types_ch[3]);
        }
    };

    $scope.mouseenter = function(divid, language) {
        $scope.markers = init_markers; 

        //console.log(map);
        //console.log(markers[0].id);
        //var infowindow = new google.maps.InfoWindow();
        //console.log(infowindow);
        for (var i=0; i<$scope.markers.length; i++) {
            if ($scope.markers[i].id == divid) {
                if (language == 'cmn-Hant-TW') {
                    google.maps.event.trigger($scope.markers[i],'mouseover')
                }    
                else { 
                    //console.log(markers[i].id);
                    //console.log(list[i].Name);
                    //infowindow.setContent("Hello");
                    //console.log("Success ID:" + i);
                    //console.log(markers.length);
                    //console.log(markers);
                    //console.log($scope.markers[i]);
                    google.maps.event.trigger($scope.markers[i], 'mouseover');
                   // infowindow.setContent("<h5>"+list[i].Name+"</h5>");
                    //console.log("OPEN");
                }
            }
        };
    };    

    $scope.mouseexit = function() {
        $scope.markers = init_markers;
        google.maps.event.trigger($scope.markers[0],'mouseout');
    };

    $scope.loadData();
    geolocation.getLocation().then(function(geo){
        $scope.coords = {lat:geo.coords.latitude, long:geo.coords.longitude};
        //$scope.coords = {lat:geo.coords.latitude, long:geo.coords.longitude};
        //$scope.lat = $scope.coords.lat;
        //$scope.lon = $scope.coords.long;
        formdata.lat_local = $scope.coords.lat;
        formdata.long_local = $scope.coords.long;
        formdata.gps_bool = true; 

        $scope.formdata.lat_local = $scope.coords.lat;
        $scope.formdata.long_local = $scope.coords.long;
        $scope.formdata.gps_bool = true;
        //console.log($scope.lat);
        //console.log($scope.lon);
        //initMap($scope.lat, $scope.lon); 
        $scope.loadData();
    });
});

app.directive('storeen', function () {
    return {
        restrict: 'E',
        transclude: true,
        templateUrl: "app/table_en1.html" 
    }
});

app.directive('storech', function () {
    return {
        restrict: 'E',
        transclude: true,
        templateUrl: "app/table_ch1.html" 
    }
});
/********************************************
Allows for selection of languages via click

********************************************/

$('#searchType li a').click(function () {
    var asr_index = $('#searchType li a').index(this) + 1;
    var asr_text = $(this).text();
    console.log(asr_index, asr_text);
    //formdata.lat_local = 33.831529;
    //formdata.long_local = -118.283680;
    //formdata.asr_results = "Taiwanese";
    //language_local = "en-US";
    formdata.asr_results = asr_text;
    switch ($('#selLanguage').text()) {
    case "English":
        formdata.language_local = "en-US";
        break;
    case "Chinese":
        formdata.language_local = "cmn-Hant-TW";
        break;
    default:
        formdata.language_local = "cmn-Hant-TW";

    };
    //formdata.language_local = "en-US";//language_sel;
    var language_local = formdata.language_local;
    console.log('searchType Clicked ' + $(this).text());
    console.log('language_sel=', language_local);
});

/********************************************
Allows for selection of languages via click

********************************************/

$('#ulLanguage li a').click(function () {
    $('#selLanguage').text($(this).text());
    //    $('#liSchezwan').text($(this).text());
    switch ($(this).text()) {
    case "English":
        console.log('eng');
        formdata.reco_language = 'en-US';
        /*$.each(crusine_types_en, function(index,value){
        $('#searchType li[index] a').text(value);
          console.log(index,value);
            console.log($('#searchType li[index] a').text(value));
        });*/
        $('#All_link').text("All");
        $('#Schezwan_link').text(crusine_types_en[0]);
        $('#Taiwanese_link').text(crusine_types_en[1]);
        $('#Beijing_link').text(crusine_types_en[2]);
        $('#Cantonese_link').text(crusine_types_en[3]);

        $('#jomb_greeting').text('Find the best Chinese food in the San Gabriel Valley!');
        $('#jomb_instructions').text('Click one of the categories below to begin.');
        $('#language_top').text('Language:')
        //$('#home_top').text('Home');
        //$('#contact_top').text("Contact Us");
        break;
    case "中文":
        //console.log('chi');
        formdata.reco_language  = "cmn-Hant-TW";
        /*$.each(crusine_types_ch, function(index,value){
        $('#searchType li[index] a').html(value);
          console.log(index,value);
            console.log($('#searchType li[index] a').text(value));
        });*/
        $('#All_link').text("全部");
        $('#Schezwan_link').text(crusine_types_ch[0]);
        $('#Taiwanese_link').text(crusine_types_ch[1]);
        $('#Beijing_link').text(crusine_types_ch[2]);
        $('#Cantonese_link').text(crusine_types_ch[3]);

        $('#jomb_greeting').text('尋找在 San Gabriel Valley 最好吃的中國菜!');
        $('#jomb_instructions').text('請點選下列仼一菜式.');
        $('#language_top').text('語言:')
        //$('#home_top').text('主頁');
        //$('#contact_top').text('聯繫我們');
        break;
    default:
        $("crusine_types_en").each(function (index) {
            $('#searchType li a').text(value);
            console.log($(this).text());
        });
    };
    console.log('ulLanguage clicked....', $("#selLanguage").text());
});

//Google map stuff
// Note: This example requires that you consent to location sharing when
// prompted by your browser. If you see a blank space instead of the map, this
// is probably because you have denied permission for location sharing.

//var map;

function handleNoGeolocation(errorFlag) {
        if (errorFlag) {
            var content = 'Error: The Geolocation service failed.';
        } else {
            var content = 'Error: Your browser doesn\'t support geolocation.';
        }
        map.setCenter(options.position);
        console.log(options);
    }
// resultMap
function resultMap(list, gps_bool, lat_gps, lon_gps, language, inits_markers, inits_map) {

    var map = new google.maps.Map(document.getElementById('map_result'), {
        zoom: 10,
        center: new google.maps.LatLng(list[0].Latitude, list[0].Longitude),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    //google.maps.event.trigger(map, 'resize');
    var infowindow = new google.maps.InfoWindow();
    var markers = [];
    var bounds = new google.maps.LatLngBounds();

    for (var i = 0; i < list.length; i++) {
        markers[i] = new google.maps.Marker({
            position: new google.maps.LatLng(list[i].Latitude, list[i].Longitude),
            icon: "http://maps.gstatic.com/mapfiles/markers2/marker.png",
            map: map,
            id: list[i].SID,
            Name: list[i].Name,
            animation: google.maps.Animation.DROP

        });

        
        google.maps.event.addListener(markers[i], 'mouseover',  (function (marker, j) {
            return function () {
                if (language == 'cmn-Hant-TW') {
                    infowindow.setContent(list[j].Ch_Name);  
                }
                else{
                    infowindow.setContent("<h5>"+list[j].Name+"</h5>");
                }
                
                infowindow.open(map, marker);
            }
        })(markers[i], i));     

        google.maps.event.addListener(markers[i], 'mouseout',  (function () {
            return function () {
                infowindow.close();
            }
        })(markers[i], i));
        
        bounds.extend(markers[i].getPosition());

        var id_table = "$('#"+list[i].SID+"')";
        //console.log(id_table);

          

    }
    //console.log(markers);
    init_markers = markers;
    inits_markers = markers;
    //console.log(inits_markers);
    //console.log(init_markers);
    init_map = map;

    //console.log(markers);
    map.setCenter(new google.maps.LatLng(list[0].Latitude, list[0].Longitude));
    map.fitBounds(bounds);
     if(map.getZoom()> 15){
        map.setZoom(15);
    };

    if (gps_bool == true) {
        marker = new google.maps.Marker({
            icon: 'http://maps.gstatic.com/mapfiles/markers2/icon_green.png',
            position: new google.maps.LatLng(lat_gps, lon_gps),
            map: map
        });

        markers.push(marker);
        bounds.extend(marker.getPosition());


        //map.setCenter(new google.maps.LatLng(lat_gps, lon_gps));
        map.fitBounds(bounds);
        if(map.getZoom()> 15){
            map.setZoom(15);
        };
    };
        
};

function stickyCalc() {
    var stickyTop = $('#search_results').offset().top;
    var navbar = $('.navbar-header').height();
    var stickyTop1 = $('#map_result').offset().top; // returns number 
    var stickyTotal = stickyTop - navbar-2;
    var stickyWidth = $('#map_contain').width();
    console.log('StickyTop: '+ stickyTop);
    console.log('StickyTotal: '+ stickyTotal);
    $('#map_result').css({ width: stickyWidth});

    $("#map_test").affix({
        offset: { 
            top: stickyTotal
            //top: function(){$('#search_results').offset().top - $('.navbar-header').height() - 2;}
        }
    });
}

$(function(){ // document ready
   stickyCalc(); 
});


$( window ).resize(function() {
    $("#map_test").affix('checkPosition');
    stickyCalc();
});

 $(window).scroll(function(){
var windowTop = $(window).scrollTop(); 
console.log('Scroll: '+windowTop);
});


// sticky map function
/*
$(function(){ // document ready
 
  if (!!$('#map_contain').offset()) { // make sure ".sticky" element exists
 
    var stickyTop = $('#search_results').offset().top;
    var navbar = $('.navbar-header').height();
    var stickyTop1 = $('#map_result').offset().top; // returns number 
    var stickyTotal = stickyTop - navbar-2;
    console.log(stickyTop);
    console.log(stickyTop1);
    console.log(navbar);
    console.log(stickyTotal);
    var stickyLeft = $('#map_contain').offset().left;
    var stickyWidth = $('#map_result').width();

 
    $(window).scroll(function(){ // scroll event
 
      var windowTop = $(window).scrollTop(); // returns number 
      //console.log(windowTop);
 
      if (stickyTotal < windowTop){
        $('#map_contain').css({ position: 'fixed', top: navbar, left: stickyLeft, width: stickyWidth});
        $('#map_result').css({marginTop: 10});
      }
      else {
        $('#map_contain').css('position','static');
      }
 
    });
 
  }
 
});
*/
