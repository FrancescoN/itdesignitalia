{if and( $attribute.content.latitude, $attribute.content.longitude )}
    {ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'Leaflet.MakiMarkers.js', 'leaflet.markercluster.js', 'plugins/leaflet/TileLayer.Grayscale.js') )}
    {ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

    <div id="map-{$attribute.id}" style="width: 100%; height: 500px;"></div>
    

    {literal}
        <script type="text/javascript">
          var latlng={/literal}[{$attribute.content.latitude},{$attribute.content.longitude}]{literal};
          var map = new L.Map('map-{/literal}{$attribute.id}{literal}');
          map.scrollWheelZoom.disable();
          var customIcon = L.MakiMarkers.icon({icon: "circle-stroked", color: "#83b81a", size: "l"});
          var postMarker = new L.marker(latlng,{icon:customIcon});
          postMarker.addTo(map);
          map.setView(latlng, 18);
          L.tileLayer.grayscale('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
              attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          }).addTo(map);
        </script>
    {/literal}
{/if}
