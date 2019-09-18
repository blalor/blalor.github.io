---
title: Summer 2019 🏍
date: 2019-09-08

layout: map
map_height: 400px
tag: summer2019
show_excerpts: false
---

On September 7th I left Virginia on my 2007 BMW R1200RT, headed toward Cape Breton in Nova Scotia.
<!--more-->
The posts below (and the map above) are a log of the trip as I went.

<div class="entries-{{ page.entries_layout | default: 'list' }}">
    {% for entry in site.tags[page.tag] -%}
        {% include entry.html %}
    {% endfor %}
</div>

<script type="text/javascript">
    (function(_map) {
        $.getJSON("/assets/geojson/summer-2019.json", function(data) {
            var icons = {
                "fuel": L.divIcon({
                    className: "fa-divicon",
                    html: '<i class="fas fa-gas-pump"></i>',
                    // iconSize: [40, 40]
                }),
                "maintenance": L.divIcon({
                    className: "fa-divicon",
                    html: '<i class="fas fa-wrench"></i>',
                }),
            };

            var roadTripGroup = L.markerClusterGroup();
            
            // map of roadtrip key to displayed label and value
            var roadTripMappings = [
                [
                    "Date",
                    function(p) {
                        var dateObj;
                        var s = p["Date"].split(" ");
                        var date = s[0];
                        var dateComp = date.split("-");
                        if (s.length == 2) {
                            var time = s[1];
                            var timeComp = time.split(":");
                            dateObj = new Date(
                                parseInt(dateComp[0]), // year
                                parseInt(dateComp[1]) - 1, // month
                                parseInt(dateComp[2]), // day
                                parseInt(timeComp[0]), // hour
                                parseInt(timeComp[1])  // minute
                            );
                        } else {
                            dateObj = new Date(
                                parseInt(dateComp[0]), // year
                                parseInt(dateComp[1]) - 1, // month
                                parseInt(dateComp[2]) // day
                            );
                        }
                        
                        return [
                            "time",
                            dateObj.toLocaleString()];
                        }
                ],
                ["Odometer (mi)",   function(p) { return ["odometer",             p["Odometer (mi)"]]; }],
                ["Trip Distance",   function(p) { return ["distance",             p["Trip Distance"]]; }],
                ["MPG",             function(p) { return ["economy",              parseFloat(p["MPG"]).toFixed(1)]; }],
                ["Fill Amount",     function(p) { return ["amount",               p["Fill Amount"] + " " + p["Fill Units"]]; }],
                ["Price per Unit",  function(p) { return ["$/" + p["Fill Units"], p["Price per Unit"]]; }],
                ["Total Price",     function(p) { return ["total",                p["Total Price"]]; }],
                ["Note",            function(p) { return ["Note",                 p["Note"]]; }],
            ];

            data.features.forEach(function(feature) {
                var popUpContent = [];
                if (feature.properties) {
                    roadTripMappings.forEach(function(m) {
                        if (feature.properties[m[0]]) {
                            var x = m[1](feature.properties);
                            popUpContent.push(x[0] + ": " + x[1]);
                        }
                    });
                    
                    roadTripGroup.addLayer(
                        L.marker(
                            [
                                feature.geometry.coordinates[1],
                                feature.geometry.coordinates[0],
                            ],
                            {
                                icon: icons[feature.properties.icon]
                            }
                        ).bindPopup(popUpContent.join("<br />"))
                    );
                }
            });
            
            roadTripGroup.addTo(_map);
        });

        var photoGroup = L.markerClusterGroup({
            // default functionality with a custom icon
            iconCreateFunction: function(cluster) {
                var childCount = cluster.getChildCount();

                var c = ' marker-cluster-';
                if (childCount < 10) {
                    c += 'small';
                } else if (childCount < 100) {
                    c += 'medium';
                } else {
                    c += 'large';
                }

                return new L.DivIcon({
                    html: '<div><span><i class="fas fa-camera"></i> ' + childCount + '</span></div>',
                    className: 'marker-cluster' + c,
                    iconSize: new L.Point(40, 40)
                });
            }
        });
        
        {% for post in site.tags[page.tag] -%}
            {%- for img in post.images -%}
                {%- if img[1].exif.location %}
        addPhotoToGroup(photoGroup, {{ img[1] | jsonify }}, "{{ post.url | relative_url }}", "{{ post.title }}");
                {%- endif -%}
            {%- endfor -%}
            
            {%- for gpx in post.gpx %}
        loadGpx("{{ gpx }}", _map);
            {%- endfor =%}
        {%- endfor %}

        photoGroup.addTo(_map);
        _map.fitBounds(photoGroup.getBounds());

        // increase the marker's image size when zooming in
        _map.on("zoomend", function() {
            var zoom = _map.getZoom();
            
            photoGroup.eachLayer(function(marker) {
                var icon = marker.options.icon;

                if (zoom >= 10) {
                    icon.options.iconUrl = icon.options._iconUrls[1];
                } else {
                    icon.options.iconUrl = icon.options._iconUrls[0];
                }
                
                marker.setIcon(icon);
            })
        });
    })({{ layout.map_var }});
</script>
