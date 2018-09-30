function getJSON(url, cb) {
    var request = new XMLHttpRequest();
    request.open("GET", url, true);

    request.onload = function() {
        if (request.status >= 200 && request.status < 400) {
            // Success!
            cb(JSON.parse(request.responseText));
        }
    };

    request.send();
}

function popUp(feature, layer) {
    var out = [];
    if (feature.properties) {
        for (key in feature.properties) {
            out.push(key + ": " + feature.properties[key]);
        }

        layer.bindPopup(out.join("<br />"));
    }
}

function loadGpx(gpx, _map) {
    new L.GPX(
        gpx,
        {
            async: true,
            marker_options: {
                startIconUrl: null,
                startIcon: null,
                endIconUrl: null,
                endIcon: null
            }
        }).addTo(_map);
}
