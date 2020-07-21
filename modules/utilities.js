exports.verifyEmail = function verifyEmail(email) {
  const emailRegexp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

  return emailRegexp.test(email);
};

exports.verifyToken = function verifyToken(req, res, next) {
  const bearerHeader = req.headers['authorization'];
  if(bearerHeader) {
    req.token = bearerHeader.split(' ')[1];
    next();
  } else {
    res.status(403).send('Forbidden');
  }
}