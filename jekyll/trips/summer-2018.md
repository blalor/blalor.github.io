---
layout: map
title: Summer 2018 🏍
---

ohai.

<style>
.fa-icon {color: blue;}
</style>


<script type="text/javascript">
    (function(_map) {
        getJSON("/assets/fuel_report.json", function(data) {
            var fuelData = L.geoJSON(data, {
                onEachFeature: popUp,
                pointToLayer: function(pt, latlng) {
                    return L.marker(latlng, {
                        icon: L.divIcon({
                            className: "fa-icon",
                            // fa-gas-pump is in 5.0.13, we're using 5.0.12 :-(
                            html: '<i class="fas fa-battery-quarter"></i>',
                            // iconSize: [40, 40]
                        })
                    });
                }
            });

            _map.fitBounds(fuelData.getBounds());
            fuelData.addTo(_map);
        });

        var photoGroup = L.featureGroup([]);

        {% for post in site.tags["summer2018"] %}
            {% for img in post.images %}
                {% if img[1].exif.location %}
        photoGroup.addLayer(
            L.marker(
                [
                    parseFloat("{{ img[1].exif.location.latitude }}"),
                    parseFloat("{{ img[1].exif.location.longitude }}")
                ],
                {
                    title: "{{ post.title }} – {{ img[1].exif.location.name }}",
                    icon: L.icon({
                        iconUrl: "{{ site.static_images_base_url }}/fit-in/40x40/{{ img[1].path }}",
                    })
                }
            ).bindPopup(
                '<img src="{{ site.static_images_base_url }}/fit-in/400x/{{ img[1].path }}" alt="image" /><br /><a href="{{ post.url | relative_url }}">{{ post.title }}</a>',
                {
                    maxWidth: 400,
                    minWidth: 400
                }
            )
        );
                {% endif %}
            {% endfor %}
            
            {% for gpx in post.gpx %}
            loadGpx("{{ gpx }}", _map);
            {% endfor %}
        {% endfor %}

        photoGroup.addTo(_map);
        _map.fitBounds(photoGroup.getBounds());
    })({{ layout.map_var }});
</script>
