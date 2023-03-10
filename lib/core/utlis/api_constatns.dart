class ApiConstants {

static const googleKey = "AIzaSyCHcAKXFZuQ8WhkAvW1zv3MTVibHU9EuF0";
  
  // static const baseUrl ="";
  static const baseUrl = "https://b7f6-197-38-23-103.eu.ngrok.io";
  static const baseUrlImages = "$baseUrl/images/";
  static const checkUserPath = "$baseUrl/check-username";
  static const loginPath = "$baseUrl/user-login";
  static const signUpPath =
      "$baseUrl/signup";
  static const uploadImagesPath =
      "$baseUrl/image/upload/image";

static const getCarTypesPath =
    "$baseUrl/carTypes/get_car_types";

    static const addTripPath =
    "$baseUrl/trips/add-trip";

    static const homeTripsPath =
    "$baseUrl/trips/home_user";
  static const getTripsPath =
    "$baseUrl/trips/add-trip";
  static const getCityDetailsPath = "$baseUrl/cities/get-city-details?";
  static const getPlaceDetailsPath = "$baseUrl/places/get-placeDetails?";

  static const searchCitiesPath = "$baseUrl/cities/search_city?";

  static const getFavoritesPath = "$baseUrl/Favorite/get-favorites?";
  static String imageUrl(path) => baseUrlImages+path;

  // local Storage constants
  static const langKey = "lang";
  static const tokenKey = "token";
  static const phoneKey = "phone";
  static const userIdKey = "id";
  static const emailKey = "email";
  static const roleKey = "role";
  static const imageKey = "image";
  static const nameKey = "name";
}
