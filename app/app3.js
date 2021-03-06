var crusine_types_en = ["Schezwan", "Taiwanese", "Beijing", "Cantonese"];
var crusine_types_ch = ["川菜", "台灣小吃", "京菜", "廣東菜"];
/*$.each(crusine_types_en, function(index,value){
console.log(index,value);
});*/
var formdata = new Object();
formdata.lat_local = 38.537205;
formdata.long_local = -121.752466;
formdata.asr_results = "Home";
formdata.language_local = "en-US";
//formdata.asr_results = "台灣小吃";
//formdata.language_local = "cmn-Hant-TW";
var language_local = formdata.language_local;
var language_sel = "";

var app = angular.module('myApp', ['ui.bootstrap']);
app.filter('startFrom', function () {
    return function (input, start) {
        if (input) {
            start = +start; //parse to int
            return input.slice(start);
        }
        return [];
    }
});

app.controller('customersCrtl', function ($scope, $http, $timeout) {
    $http.post('ajax/getCustomers1.php', JSON.stringify(formdata)).success(function (data) {
        $scope.list = data;
        $scope.currentPage = 1; //current page
        $scope.entryLimit = 5; //max no of items to display in a page
        $scope.filteredItems = $scope.list.length; //Initially for no filter  
        $scope.totalItems = $scope.list.length;
        $scope.language_local = formdata.language_local;
        console.log($scope.list)
        $scope.initLoad = 0;
        initMap();
        resultMap($scope.list);
    });
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
        $http.post('ajax/getCustomers1.php', JSON.stringify(formdata)).success(function (data) {
            $scope.list = data;
            $scope.currentPage = 1; //current page
            $scope.entryLimit = 5; //max no of items to display in a page
            $scope.filteredItems = $scope.list.length; //Initially for no filter  
            $scope.totalItems = $scope.list.length;
            $scope.language_local = formdata.language_local;
            //console.log($scope.list);
        });
        //reload the result map
        $scope.initLoad = 0;
        resultMap($scope.list);
    }
});

app.directive('store', function () {
    return {
        restrict: 'E',
        transclude: true,
        templateUrl: "app/table.html" 
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
        formdata.language_local = "en-US";

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
        /*$.each(crusine_types_en, function(index,value){
        $('#searchType li[index] a').text(value);
          console.log(index,value);
            console.log($('#searchType li[index] a').text(value));
        });*/
        $('#liSchezwan a').text(crusine_types_en[0]);
        $('#liTaiwanese a').text(crusine_types_en[1]);
        $('#liBeijing a').text(crusine_types_en[2]);
        $('#liCantonese a').text(crusine_types_en[3]);
        break;
    case "Chinese":
        console.log('chi');
        /*$.each(crusine_types_ch, function(index,value){
        $('#searchType li[index] a').html(value);
          console.log(index,value);
            console.log($('#searchType li[index] a').text(value));
        });*/
        $('#liSchezwan a').text(crusine_types_ch[0]);
        $('#liTaiwanese a').text(crusine_types_ch[1]);
        $('#liBeijing a').text(crusine_types_ch[2]);
        $('#liCantonese a').text(crusine_types_ch[3]);
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

function initMap() {
    var mapOptions = {
        zoom: 14,
        center: new google.maps.LatLng(formdata.lat_local, formdata.long_local)
    };

    var map = new google.maps.Map(document.getElementById('map_default'),
        mapOptions);


    // Try HTML5 geolocation
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = new google.maps.LatLng(position.coords.latitude,
                position.coords.longitude);
            formdata.lat_local = position.coords.latitude;
            formdata.long_local = position.coords.longitude;
            /*var infowindow = new google.maps.InfoWindow({
                map: map,
                position: pos,
                content: 'Your Location'
            });
            console.log(pos);
            var marker = new google.maps.Marker({
                position: pos,
                url: '/',
                animation: google.maps.Animation.DROP
            });
            marker.setMap(map);
            map.setCenter(pos);
            infowindow.open(map, marker); */
            var position_latlng = [position.coords.latitude, position.coords.longitude];
            //console.log(position_latlng);
            return position_latlng;
        }, function () {
            handleNoGeolocation(true);
        });
    } else {
        // Browser doesn't support Geolocation
        handleNoGeolocation(false);
    }
    //return position_latlng;
    //console.log(position_latlng);
}

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
function resultMap(list) {

    var map = new google.maps.Map(document.getElementById('map_result'), {
        zoom: 10,
        center: new google.maps.LatLng(list[0].Latitude, list[0].Longitude),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    google.maps.event.trigger(map, 'resize');

    var infowindow = new google.maps.InfoWindow();
    var marker, i;

    for (i = 0; i < list.length; i++) {
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(list[i].Latitude, list[i].Longitude),
            map: map
        });
        google.maps.event.addListener(marker, 'mouseover', (function (marker, i) {
            return function () {
                infowindow.setContent(list[i].Name);
                infowindow.open(map, marker);
            }
        })(marker, i));
    }
    map.setCenter(new google.maps.LatLng(list[0].Latitude, list[0].Longitude));
    //map.setZoom(map.getZoon());
    /*google.maps.event.addListener(map, 'center_changed', function () {
        // Whatever.
        console.log('centerchanged');
    });*/
};

/*************** Speech script executes start here... ***********


****************************************************************/
    $('#status_img').click(function() {
        reco.lang = formdata.language_local; 
        reco.toggleStartStop();
     });


    //setup and starts speech recognizer 
        var reco = new WebSpeechRecognition(); // starts the speech recognition
        reco.statusText('status'); 
        reco.statusImage('status_img');
        reco.finalResults('final_span');
        //reco.interimResults('interim_span');  
        reco.continuous = false; //gets rid of silence detection if set to true
    // Handler for when speech reco concludes. 
        reco.onEnd = function() 
        {

            //Send results into form
            document.getElementById('form_asr').value = reco.final_transcript;
            document.getElementById("form_asr").focus();
            //Auto submit form

            $('#talk_res').submit();


            //return false; 
        }; // end of function for when silence is detected

        $('#talk_res').submit(function(e) {
            e.preventDefault(); 

            document.getElementById('form_asr').value = reco.final_transcript;
            console.log(reco.final_transcript);
            var result = false; 
            for (var i =0; i<crusine_types_en.length; i++) {
                if (reco.final_transcript == crusine_types_en[i]) { 
                    result = true;
                    var selector = "#"+crusine_types_en[i];
                    console.log(selector);
                    $(selector).click();   
                };
            } ;

        });
//var latlng;
//google.maps.event.addDomListener(window, 'load',  latlng = initMap());
//console.log(latlng);
