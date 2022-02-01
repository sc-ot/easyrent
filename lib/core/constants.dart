class Constants {
  // "http://192.168.2.27:9001/api/v1"; local example
  // "https://erbackend.works4dev.de/api/v1" prod example
  // "https://easyrentm1backend.works4dev.de/api/v1" test example

  static String BASE_URL = "http://192.168.2.27:9001/api/v1";

  static const int MOVEMENT_TYPE_ENTRY = 1;
  static const int MOVEMENT_TYPE_EXIT = 2;
  static const String THEME_1 = "theme-1";
  static const String THEME_2 = "theme-2";
  static const String THEME_MARGARITIS = "theme-margaritis";
  static const String ROUTE_HOME = "/";
  static const String ROUTE_LOGIN = "/login";
  static const String ROUTE_CLIENTS = "/clients";
  static const String ROUTE_MENU = "/menu";
  static const String ROUTE_CAMERA = "/camera";
  static const String ROUTE_VEHICLE_INFO = "/vehicle_info";
  static const String ROUTE_VEHICLE_INFO_MOVEMENTS = "/vehicle_info_movements";
  static const String ROUTE_VEHICLE_INFO_EQUIPMENTS =
      "/vehicle_info_equipments";
  static const String ROUTE_VEHICLE_INFO_LOCATION = "/vehicle_info_location";
  static const String ROUTE_CAMERA_VEHICLE_SEARCH_LIST =
      "/image_vehicle_search_list";
  static const String ROUTE_IMAGES_NEW_VEHICLE = "/images_new_vehicle";
  static const String ROUTE_IMAGES_HISTORY = "/images_history";
  static const String ROUTE_IMAGES_HISTORY_GALERY = "/images_history_galery";
  static const String ROUTE_IMAGES_CACHE_LOG = "/images_cache_log";

  static const String ROUTE_MOVEMENT_PLANNED_MOVEMENT_SEARCH_LIST =
      "/movement_planned_movement_search_list";
  static const String ROUTE_MOVEMENT_SEARCH_LIST = "/movement_search_list";
  static const String ROUTE_MOVEMENT_OVERVIEW = "/movement_overview";
  static const String ROUTE_MOVEMENT_LICENSEPLATE_AND_MILES =
      "/movement_miles_and_license_plate";
  static const String ROUTE_MOVEMENT_DRIVING_LICENSE =
      "/movement_driving_license";
  static const String ROUTE_MOVEMENT_PROTOCOL = "/movement_protocol";
  static const String ROUTE_IMAGES_LOG_PAGE = "/images_log_page";
  static const String KEY_FIRST_BOOT = "KEY_FIRST_BOOT";
  static const String KEY_IMAGES = "KEY_IMAGES";
  static const String KEY_AUTHORIZATION = "KEY_AUTHORIZATION";
  static const String KEY_USERNAME = "KEY_USERNAME";
  static const String KEY_USER_ID = "KEY_USER_ID";
  static const String KEY_THEME = "KEY_THEME";
  static const String KEY_SHOW_CAMERA_OVERLAY = "KEY_SHOW_CAMERA_OVERLAY";
  static const String KEY_SAVE_IMAGES_ON_DEVICE = "KEY_SAVE_IMAGES_ON_DEVICE";
  static const String KEY_SHOW_IMAGES_IN_MENU = "KEY_SHOW_IMAGES_IN_MENU";
  static const String KEY_CLIENTS = "KEY_CLIENTS";

  static const int VIN_MAX_LENGTH = 17;
  static const FILE_NAME_DELIMITER = "__";
}
