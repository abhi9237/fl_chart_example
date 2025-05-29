class AppLocalStorageConstants {
  static AppLocalStorageConstants? _instance;
  // Avoid self instance
  AppLocalStorageConstants._();
  static AppLocalStorageConstants get instance {
    _instance ??= AppLocalStorageConstants._();
    return _instance!;
  }

  static const String tokenString = 'tokenString';
  static const String currencyListString = 'currencyListString';
  static const String addressListString = 'addressListString';
  static const String firstNameString = 'firstNameString';
  static const String lastNameString = 'lastNameString';
  static const String emailString = 'emailString';
  static const String appType = 'appType';
  static const String themeModeType = 'themeModeType';
  static const String drawerIndex = 'drawerIndex';
  static const String userId = 'userId';
  static const String userImage = 'userImage';
  static const String rememberMe = 'rememberMe';
  static const String created = 'created';
  static const String userName = 'userName';
  static const String reorderResponse = 'reorderResponse';
  static const String isShowCase = 'isShowCase';
}
