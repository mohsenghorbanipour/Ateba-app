class RemoteRoutes {

  // Packages Api
  static const String getToturials = 'tutorials';
  static String getTutorialDetails(String slug) => 'tutorials/$slug';

  // Categories Api
  static const String getCategories = 'categories';
  static String getCategoryDetails(String slug) => 'categories/$slug';

  // Courses Api
  static const String getCourses = 'courses';
  static String getCourseDetails(String slug) => 'courses/$slug';

  // static const String getBannerSlider = 'slider.php';
  // static const String getPackages = 'packages.php';
  // static const String getCourses = 'courses.php';
  // static const String getBottomBanner = 'banner.php';
  // static const String getPopularStations = 'workshopsgit.php';
}