function isValidLatitude(latitude) {
  return latitude >= -90 && latitude <= 90;
}

function isValidLongitude(longitude) {
  return longitude >= -180 && longitude <= 180;
}

module.exports = {
  isValidLatitude,
  isValidLongitude,
};