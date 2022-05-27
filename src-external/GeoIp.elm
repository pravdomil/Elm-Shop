module GeoIp exposing (..)

import JavaScript
import Json.Decode
import Json.Encode
import Task


countryCodeByIp : String -> Task.Task JavaScript.Error String
countryCodeByIp a =
    JavaScript.run "(() => { if (!global.geoIp) { global.geoIp = require('maxmind'); geoIp.init('/usr/share/GeoIP/GeoIP.dat'); } return geoIp.getCountry(a).code })()"
        (Json.Encode.string a)
        Json.Decode.string
