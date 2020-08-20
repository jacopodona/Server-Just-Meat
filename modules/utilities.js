exports.verifyEmail = function verifyEmail(email) {
  const emailRegexp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

  return emailRegexp.test(email);
};

exports.verifyToken = function verifyToken(req, res, next) {
  const bearerHeader = req.headers['authorization'];
  if (bearerHeader) {
    req.token = bearerHeader.split(' ')[1];
    next();
  } else {
    res.status(403).send('Forbidden');
  }
}

exports.haversine_distance = function haversine_distance(lat1, lat2, long1, long2) {
  var R = 6371.0710; // Radius of the Earth in miles
  var rlat1 = lat1 * (Math.PI / 180); // Convert degrees to radians
  var rlat2 = lat2 * (Math.PI / 180); // Convert degrees to radians
  var difflat = rlat2 - rlat1; // Radian difference (latitudes)
  var difflon = (long2 - long1) * (Math.PI / 180); // Radian difference (longitudes)

  var d = 2 * R * Math.asin(Math.sqrt(Math.sin(difflat / 2) * Math.sin(difflat / 2) + Math.cos(rlat1) * Math.cos(rlat2) * Math.sin(difflon / 2) * Math.sin(difflon / 2)));
  return d * 1000; // Turn to meters
}