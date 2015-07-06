function yelp(db_results) {
    var auth = {
        //
        // Update with your auth tokens.
        //
        consumerKey : "NULL",
        consumerSecret : "NULL",
        accessToken : "NULL",
        // This example is a proof of concept, for how to use the Yelp v2 API with javascript.
        // You wouldn't actually want to expose your access token secret like this in a real application.
        accessTokenSecret : "NULL",
        serviceProvider : {
            signatureMethod : "HMAC-SHA1"
        }
    };

    var business = db_results.bizID;
    //var near = 'San+Francisco';

    var accessor = {
        consumerSecret : auth.consumerSecret,
        tokenSecret : auth.accessTokenSecret
    };
    parameters = [];
    //parameters.push(['business', business]);
    //parameters.push(['location', near]);
    parameters.push(['callback', 'cb']);
    parameters.push(['oauth_consumer_key', auth.consumerKey]);
    parameters.push(['oauth_consumer_secret', auth.consumerSecret]);
    parameters.push(['oauth_token', auth.accessToken]);
    parameters.push(['oauth_signature_method', 'HMAC-SHA1']);

    var message = {
        'action' : 'http://api.yelp.com/v2/business/' + business,
        'method' : 'GET',
        'parameters' : parameters
    };

    OAuth.setTimestampAndNonce(message);
    OAuth.SignatureMethod.sign(message, accessor);

    var parameterMap = OAuth.getParameterMap(message.parameters);
    //console.log(parameterMap);

    $.ajax({
        'url' : message.action,
        'data' : parameterMap,
        'cache' : true, 
        'dataType' : 'jsonp',
        'jsonpCallback' : 'cb',
        'success' : function(data, textStats, XMLHttpRequest) {
            console.log(data);
            db_results.Search_Icon = data.image_url;
            db_results.Rating = data.rating_img_url_large;
            console.log(db_results.Rating);
            //$("body").append(output);
        }
    });
}