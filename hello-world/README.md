# Hello world
Load Leaflet library at the beginning of your script and after that Windy API library from URL `https://api4.windy.com/assets/libBoot.js`. 

Leaflet CSS is loaded automatically.

Your application must contain `<div id="windy"></div>` in a place, where  you want to position Windy map. Use CSS to resize or position Windy `div` as you wish.

## Activate index.html with your api key

Assuming you have an API key stored as JSON like:

```
[{
  "api_key": ""
  ...
}]
```

Run [activate_api.sh](./activate_api.sh) with your API key file:

```
./activate_api.sh -ai ~/path/to/credfile.json
```

## Sanitize your api key from index.html

Assuming the above mentioned API key JSON file:

```
./activate_api.sh -si ~/path/to/credfile.json
```

In your JS code call function `windyInit( options, callback )`, where options object must contain mandatory API key. Other start-up values are optional, but it is highly recommended to put a much as start-up parameters as possible. 

Your `callback` is called whenever Windy API is ready and as a parameter it receives object with Windy API.

You can use well documented [Leaflet API](https://leafletjs.com/reference-0.7.7.html) to do **anything with Windy map**, or use rich ecosystem of [Leaflet plugins](http://leafletjs.com/plugins.html). 


