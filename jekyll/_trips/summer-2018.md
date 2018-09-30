---
title: Summer 2018 🏍
date: 2018-09-08

layout: map
map_height: 400px
tag: summer2018
show_excerpts: false
---

From September 8th through the 21st I rode from Virginia to the Bonneville Salt
Flats in Utah for the 32nd annual World of Speed on my 2017 Honda Africa Twin.
<!--more-->
The posts below (and the map above) are a log of the trip as I went.

<div class="entries-{{ page.entries_layout | default: 'list' }}">
    {% for entry in site.tags[page.tag] -%}
        {% include entry.html %}
    {% endfor %}
</div>

<script type="text/javascript">
    (function(_map) {
        $.getJSON("/assets/geojson/fuel_report.json", function(data) {
            var fuelData = L.geoJSON(data, {
                onEachFeature: function(feature, layer){
                    var out = [];
                    if (feature.properties) {
                        for (key in feature.properties) {
                            // icon is special for pointToLayer
                            if (key != "icon") {
                                out.push(key + ": " + feature.properties[key]);
                            }
                        }

                        layer.bindPopup(out.join("<br />"));
                    }
                },
                pointToLayer: function(pt, latlng) {
                    var icons = {
                        "fuel": L.divIcon({
                            className: "fa-divicon",
                            // fa-gas-pump is in 5.0.13, we're using 5.0.12 :-(
                            html: '<i class="fas fa-battery-quarter"></i>',
                            // iconSize: [40, 40]
                        }),
                        "maintenance": L.divIcon({
                            className: "fa-divicon",
                            // fa-wrench is in 5.0.13, we're using 5.0.12 :-(
                            html: '<i class="fas fa-cogs"></i>',
                        }),
                    };

                    return L.marker(latlng, {
                        icon: icons[pt.properties.icon]
                    });
                }
            });

            fuelData.addTo(_map);
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
        
        function addPhoto(img, postUrl, postTitle) {
            var iconUrls = [
                "{{ site.static_images_base_url }}/fit-in/50x50/" + img.path,
                "{{ site.static_images_base_url }}/fit-in/75x75/" + img.path
            ];
            
            var popupImgUrl = "{{ site.static_images_base_url }}/fit-in/400x/" + img.path;
            
            photoGroup.addLayer(
                L.marker(
                    [ img.exif.location.latitude, img.exif.location.longitude ],
                    {
                        title: postTitle + " - " + img.exif.location.name,
                        icon: L.icon({
                            _iconUrls: iconUrls,
                            iconUrl: iconUrls[0],
                            className: "photo-marker-icon",
                        })
                    }
                ).bindPopup(
                    '<img src="' + popupImgUrl + '" alt="image" /><br />' +
                    '<a href="' + postUrl + '">' + postTitle + '</a>',
                    {
                        maxWidth: 400,
                        minWidth: 400
                    }
                )
            );
        }
        
        {% for post in site.tags[page.tag] -%}
            {%- for img in post.images -%}
                {%- if img[1].exif.location %}
        addPhoto({{ img[1] | jsonify }}, "{{ post.url | relative_url }}", "{{ post.title }}");
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
