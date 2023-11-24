class RemoteRoutes {
  // App Api
  static const String getAppConfig = 'configs';

  // Auth ans User Api
  static const String getUserSubscription = 'subscription';
  static const String getMyProducts = 'my-products';
  static const String getProfile = 'profile';
  static const String getTransactions = 'transactions';
  static const uploadImage = 'profile/upload';
  static const String sendCode = 'login';
  static const String verifyCode = 'login/verify';
  static const String getProfileConfig = 'profile/configs';
  static String getCities(int provinceId) =>
      'profile/province/$provinceId/cities';
  static const String getNotifications = 'notifications';

  // Banners Api
  static const String getTopBanner = 'banners/slider';
  static const String getMiddleBanner = 'banners/middle';

  // Search Api
  static const String getSuggestion = 'search/suggestions';
  static const String searchFase = 'search/fast';
  static const String advancedSearch = 'search/advanced';

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
  static String orderPackage(String slug) => 'packages/$slug/order';

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

  // Video Features Api
  static String getVideoChapter(int id) => 'videos/$id/chapters';
  static String getVideoQuiz(int id) => 'videos/$id/quiz';
  static String answerQuestion(int id) => 'videos/questions/$id/answer';
}
