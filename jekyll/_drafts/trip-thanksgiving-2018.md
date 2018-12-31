---
title: Thanksgiving 2018 🦃⛺️
date: 2018-10-21

layout: map
map_height: 800px
tag: thanksgiving2018
show_excerpts: false
---

Thanksgiving with friends in Death Valley National Park.
<!--more-->

_Map locations approximate!_

<div class="entries-{{ page.entries_layout | default: 'list' }}">
    {% for entry in site.tags[page.tag] -%}
        {% include entry.html %}
    {% endfor %}
</div>

<script type="text/javascript">
    (function(_map) {
        // iconSize: [40, 40]
        var icons = {
            "gas-pump":    L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-gas-pump"></i>'  }),
            "wrench":      L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-wrench"></i>'    }),
            "plane":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-plane"></i>'    }),
            "campground":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-campground"></i>'    }),
            "binoculars":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-binoculars"></i>'    }),
            "hiking":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-hiking"></i>'    }),
            "flag-checkered":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-flag-checkered"></i>'    }),
            "car":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-car"></i>'    }),
            "road":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-road"></i>'    }),
            "map-marked-alt":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-map-marked-alt"></i>'    }),
            "ghost":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-ghost"></i>'    }),
            "hotel":       L.divIcon({ className: "fa-divicon", html: '<i class="fas fa-hotel"></i>'    }),
        };

        // var markerGroup = L.featureGroup();
        var markerGroup = L.markerClusterGroup();

        markerGroup.addLayer(L.marker([ 36.0839998, -115.1559276 ], {
            title: "LAS",
            icon: icons["plane"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.3395825, -117.4708349 ], {
            title: "Panamint",
            icon: icons["campground"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.460413,-116.8680538 ], {
            title: "Farabee",
            icon: icons["car"]
        }));

        markerGroup.addLayer(L.marker([ 36.7165821, -117.5510419 ], {
            title: "Lost Burrow Mine",
            icon: icons["binoculars"]
        }));
        


        // starah's itinerary
        markerGroup.addLayer(L.marker([ 36.3207409, -117.5332155 ], {
            title: "Darwin Falls",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.3518636, -117.5529223 ], {
            title: "Father Crowley Overlook",
            icon: icons["binoculars"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.3823139,-116.8315443 ], {
            title: "Artists Drive",
            icon: icons["road"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.3644695,-116.8027736 ], {
            title: "Artist's Palette",
            icon: icons["binoculars"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.3282824,-116.8688072 ], {
            title: "Devil’s Golf Course",
            icon: icons["binoculars"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.2854263,-116.7719247 ], {
            title: "Natural Bridge Trail",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.2340512,-116.8863297 ], {
            title: "Badwater Basin",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.2180439,-116.7312759 ], {
            title: "Dante’s View",
            icon: icons["binoculars"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.4617546,-116.8688005 ], {
            title: "Furnace Creek Visitor Center",
            icon: icons["map-marked-alt"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.4206399, -116.813917 ],  {
            title: "Zabriskie Point",
            icon: icons["binoculars"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.4209298,-116.8119464 ],  {
            title: "Badlands Loop",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.4207027,-116.8489625 ],  {
            title: "Golden Canyon to Red Cathedral",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.416874,-116.8371207 ],  {
            title: "Gower Gulch Loop",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.421341,-116.8305977 ],  {
            title: "Complete Circuit",
            icon: icons["hiking"]
        }));
        
        // central / stovepipe wells village
        markerGroup.addLayer(L.marker([ 36.558862,-117.1433229 ],  {
            title: "Mosaic Canyon",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.6151215,-117.1153331 ],  {
            title: "Mesquite Flat Sand Dunes",
            icon: icons["hiking"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.6816138,-116.9088125 ],  {
            title: "Keane Wonder Mine",
            icon: icons["binoculars"]
        }));
        
        // northeast / Scotty's Castle

        markerGroup.addLayer(L.marker([ 37.0107777,-117.4569421 ],  {
            title: "Ubehebe Crater",
            icon: icons["hiking"]
        }));

        markerGroup.addLayer(L.marker([ 37.0323068,-117.3435799 ],  {
            title: "Scotty’s Castle",
            icon: icons["binoculars"]
        }));

        // middle of nowhere / on their own

        markerGroup.addLayer(L.marker([ 36.6812992,-117.5714548 ], {
            title: "Racetrack Playa",
            icon: icons["flag-checkered"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.2465791,-117.0784825 ], {
            title: "Charcoal Kilns",
            icon: icons["binoculars"]
        }));
        
        markerGroup.addLayer(L.marker([ 36.2450012,-117.0807746 ], {
            title: "Wildrose Peak",
            icon: icons["hiking"]
        }));
        
        // other
        markerGroup.addLayer(L.marker([ 36.0475779,-117.22635 ], {
            title: "Ballarat",
            icon: icons["ghost"]
        }));

        markerGroup.addLayer(L.marker([ 36.1152191,-115.1679277 ], {
            title: "Westin",
            icon: icons["hotel"]
        }));

        markerGroup.bindPopup(function(m) {
            return "<p>" + m.options.title + "</p>";
        });
        
        markerGroup.addTo(_map);
        _map.fitBounds(markerGroup.getBounds());
        
        loadGpx("/assets/gpx/LAS-to-Panamint.gpx", _map);
    })({{ layout.map_var }});
</script>
