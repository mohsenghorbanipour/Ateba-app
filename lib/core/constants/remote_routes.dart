class RemoteRoutes {

  // Auth Api
  static const String getUserSubscription = 'subscription';

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
  static orderCourse(String slug) => 'courses/$slug/order';

  // Package Api
  static const String getPackages = 'packages';
  static String getPackageDetials(String slug) => 'packages/$slug';
  static String getPackageComments(String slug) => 'packages/$slug/comments';

  // Comments Api
  static String likeComment(String id) => 'comments/$id/like';
  static String deleteComment(String id) => 'comments/$id';
  static String getCommentReplies(String id) => 'comments/$id/replies';

  // Bookmarks Api
  static String getBookmarks = 'bookmarks';

  // Cart Api
  static const String getOrders = 'cart';
  static String deleteOrder(String id) => 'order/$id';
  static const String applyDiscount = 'cart/discount';
  static const String payment = 'cart/pay';

  // Subscription Api
  static const String getSubscriptionPlans = 'subscription/plans';
  static String discountPreview(int id) => 'plans/$id/order';

}
