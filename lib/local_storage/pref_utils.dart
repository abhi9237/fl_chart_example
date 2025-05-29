// ignore_for_file: invalid_use_of_protected_member


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../common/local_storage_constants.dart';

class GetStorageController extends GetxController {
  GetStorage box = GetStorage();

  final _token = ''.obs;
  final _drawerIndex = 0.obs;
  List _currencyList = [].obs;
  final _addressList = [].obs;
  final _firstName = ''.obs;
  final _lastName = ''.obs;
  final _appType = ''.obs;
  final _email = ''.obs;
  final _userId = ''.obs;
  final _userImage = ''.obs;
  final _created = ''.obs;
  final _userName = ''.obs;
  final _rememberMe = false.obs;
  final _reorderResponse = ''.obs;
  final _isShowCase = ''.obs;
  final Rx<ThemeMode> _themeMode = (ThemeMode.system).obs;

  init() async {
    _token.value = box.read(AppLocalStorageConstants.tokenString) ?? '';
    // _addressList.value =
    //     box.read(AppLocalStorageConstants.addressListString) ?? [''];
    // _currencyList =
    //     box.read(AppLocalStorageConstants.currencyListString) ?? [''];
    _lastName.value = box.read(AppLocalStorageConstants.lastNameString) ?? '';
    _firstName.value = box.read(AppLocalStorageConstants.firstNameString) ?? '';
    _email.value = box.read(AppLocalStorageConstants.emailString) ?? '';
    _drawerIndex.value = box.read(AppLocalStorageConstants.drawerIndex) ?? 0;
    _userId.value = box.read(AppLocalStorageConstants.userId) ?? '';
    _userImage.value = box.read(AppLocalStorageConstants.userImage) ?? '';
    _rememberMe.value = box.read(AppLocalStorageConstants.rememberMe) ?? false;
    _created.value = box.read(AppLocalStorageConstants.created) ?? '';
    _userName.value = box.read(AppLocalStorageConstants.userName) ?? '';
    _isShowCase.value = box.read(AppLocalStorageConstants.isShowCase) ?? '';
    _reorderResponse.value =
        box.read(AppLocalStorageConstants.reorderResponse) ?? '';
    // _appType.value = box.read(AppLocalStorageConstants.appType) ?? '';
    String? tempThemeMode = box.read(AppLocalStorageConstants.themeModeType);
    if (tempThemeMode != null) {
      _themeMode.value = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == tempThemeMode,
        orElse: () => ThemeMode.system, // Default value in case of any issues
      );
    } else {
      _themeMode.value = ThemeMode.dark;
      // _themeMode.value = box.read(AppLocalStorageConstants.themeModeType)??ThemeMode.dark;
    }
  }

  get token => _token.value;
  get isShowCase => _isShowCase.value;
  get userId => _userId.value;
  get userImage => _userImage.value;
  get drawerIndex => _drawerIndex.value;
  get rememberMe => _rememberMe.value;

  get currencyList => _currencyList;
  get reorderResponse => _reorderResponse.value;

  get addressList => _addressList.value;

  get firstName => _firstName.value;
  get userName => _userName.value;

  get lastName => _lastName.value;

  get email => _email.value;

  get appType => _appType.value;

  get themeMode => _themeMode.value;
  get created => _created.value;

  //setDrawer index
  void setShowCase(String value) {
    _isShowCase.value = value;
    setPref(AppLocalStorageConstants.isShowCase, value);
  } //setDrawer index

//setDrawer index
  void setReOrderResponse(String value) {
    _reorderResponse.value = value;
    setPref(AppLocalStorageConstants.reorderResponse, value);
  } //setDrawer index

  void setDrawerIndex(int value) {
    _drawerIndex.value = value;
    setPref(AppLocalStorageConstants.drawerIndex, value);
  }

  // * User Token
  void setUserName(String value) {
    _userName.value = value;
    setPref(AppLocalStorageConstants.userName, value);
  } // * User Token

  // * User Token
  void setUserToken(String value) {
    _token.value = value;
    setPref(AppLocalStorageConstants.tokenString, value);
  } // * User Token

// set User Id
  void setUserId(String value) {
    _userId.value = value;
    setPref(AppLocalStorageConstants.userId, value);
  }

  // set User Image
  void setUserImage(String value) {
    _userImage.value = value;
    setPref(AppLocalStorageConstants.userImage, value);
  }

  // * Test List Variable
  setCurrencyList(List value) {
    _currencyList = value;
    setPref(AppLocalStorageConstants.currencyListString, value);
    update();
  }

  // * Firt Name
  void setFirstName(String value) {
    _firstName.value = value;
    setPref(AppLocalStorageConstants.firstNameString, value);
    update();
  }

  // * Last Name
  void setLastName(String value) {
    _lastName.value = value;
    setPref(AppLocalStorageConstants.lastNameString, value);
    update();
  }

  // * Email
  void userCreatedDateTIme(String value) {
    _created.value = value;
    setPref(AppLocalStorageConstants.created, value);
    update();
  }

  // * Email
  void setEmail(String value) {
    _email.value = value;
    setPref(AppLocalStorageConstants.emailString, value);
    update();
  }

  // * APP TYPE
  void setAppType(String value) {
    _appType.value = value;
    setPref(AppLocalStorageConstants.appType, value);
  }

  // * Set Remember me
  void setRememberMe(bool value) {
    _rememberMe.value = value;
    setPref(AppLocalStorageConstants.rememberMe, value);
  }

  // * THEME
  void setThemeType(ThemeMode value) {
    _themeMode.value = value;
    // Logger.print('setThemeType ${_themeMode.value} $value');
    setPref(AppLocalStorageConstants.themeModeType, value.toString());
  }

  // * GETTING OR SET INTO LOCAL STORAGE

  void setPref(String key, dynamic value) async {
    await box.write(key, value);
  }

  getPref(String key) async {
    await box.read(key);
  }

  Future<void> logOut() async {
    await box.erase();

    log('ERASED Local Stoarge');
  }
}
