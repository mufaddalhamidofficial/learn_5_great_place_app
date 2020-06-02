const API_KEY = 'PSDtFwaP_k8IGqNIdXKPEL6yYmzXCUN5lelVr75bnL8';

class LocationHelper {
  static String locationToImage({double latitude, double longitude}) {
    return 'https://image.maps.ls.hereapi.com/mia/1.6/mapview?apiKey=$API_KEY&c=$latitude,$longitude&z=16';
  }
}
