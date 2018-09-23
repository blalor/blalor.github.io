---
layout: map
title: Summer 2018 🏍
---

ohai.

<script type="text/javascript">
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
    {% endfor %}

    photoGroup.addTo(map);
    map.fitBounds(photoGroup.getBounds());
</script>
