class RemoteRoutes {


  // Banners Api
  static const String getTopBanner = 'banners/slider';
  static const String getMiddleBanner = 'banners/middle';

  // Packages Api
  static const String getToturials = 'tutorials';
  static String getTutorialDetails(String slug) => 'tutorials/$slug';
  static String getTutorialComments(String slug) => 'tutorials/$slug/comments';
  static String likeTutorial(String slug) => 'tutorials/$slug/like';
  static String bookmarkTutorial(String slug) => 'tutorials/$slug/bookmark';

  // Categories Api
  static const String getCategories = 'categories';
  static String getCategoryDetails(String slug) => 'categories/$slug';

  // Courses Api
  static const String getCourses = 'courses';
  static String getCourseDetails(String slug) => 'courses/$slug';
  static String getCourseComment(String slug) => 'courses/$slug/comments';

  // static const String getBannerSlider = 'slider.php';
  // static const String getPackages = 'packages.php';
  // static const String getCourses = 'courses.php';
  // static const String getBottomBanner = 'banner.php';
  // static const String getPopularStations = 'workshopsgit.php';
}