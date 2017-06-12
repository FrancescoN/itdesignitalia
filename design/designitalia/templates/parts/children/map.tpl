{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js', 'plugins/leaflet/TileLayer.Grayscale.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}
    
{set_defaults(hash(
  'height', 600,
  'map_type', 'osm',
  'class_identifiers', array()
))}

{set $height = $height|fix_dimension()}

<div id="map-{$node.node_id}" style="height: {$height}px; width: 100%"></div>

{literal}
<script>
    //var tiles = L.tileLayer('//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
    var tiles = L.tileLayer.grayscale('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {maxZoom: 18, attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a> contributors'});
    var map = L.map('{/literal}map-{$node.node_id}{literal}').addLayer(tiles);
    map.scrollWheelZoom.disable();
    var markers = L.markerClusterGroup();
    var markerMap = {};
    
    $.getJSON("{/literal}{concat('/openpa/data/map_markers'|ezurl(no), '?parentNode=',$node.node_id, '&classIdentifiers=', $class_identifiers|implode(',') )}{literal}&contentType=geojson", function(data) {      		
          $.each(data.features, function(i,v){		  
            var markerListItem = $("<li data-id='"+v.id+"'><a href='"+v.properties.url+"'><small>"+v.properties.type+"</small> "+v.properties.name+"</a></li>");
            markerListItem.bind('click',markerListClick);
            $('#{/literal}map-{$node.node_id}{literal}').parents('.row').find('.list-markers-text').append(markerListItem);
          });
          var geoJsonLayer = L.geoJson(data, { pointToLayer: function (feature, latlng) {
            var customIcon = L.MakiMarkers.icon({icon: "circle-stroked", color: "#83b81a", size: "l"});
            var marker = L.marker(latlng, {icon: customIcon});		  
            markerMap[feature.id] = marker;
            return marker;
          } });
          markers.addLayer(geoJsonLayer);
          map.addLayer(markers);
          map.fitBounds(markers.getBounds());
    });
    
    markers.on('click', function (a) {
          $.getJSON("{/literal}{'/openpa/data/map_markers'|ezurl(no)}{literal}?contentType=marker&view=panel&id="+a.layer.feature.id, function(data) {
            var popup = new L.Popup({maxHeight:360});
            popup.setLatLng(a.layer.getLatLng());
            popup.setContent(data.content);
            map.openPopup(popup); 
          });        
    });
    
    markerListClick = function(e){
          var id = $(e.currentTarget).data('id');
          var m = markerMap[id];		
          markers.zoomToShowLayer(m, function() { m.fire('click');});        
          e.preventDefault();		
    };
</script>
{/literal}
