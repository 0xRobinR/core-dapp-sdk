import 'package:dapp_browser_app/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const aOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    sharedPreferencesName: "dapp_browser_sdk");
const iOptions =
    IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);

FlutterSecureStorage getPreferences() {
  const storage = FlutterSecureStorage(aOptions: aOptions, iOptions: iOptions);
  return storage;
}

Future<String> getStored(String key, {defaultValue = "[]"}) async {
  final preferences = getPreferences();
  final value = await preferences.read(key: key);
  return value ?? defaultValue;
}

Future<bool> setStored({required String key, required String value}) async {
  try {
    final preferences = getPreferences();
    await preferences.write(key: key, value: value);
    return true;
  } catch (e) {
    logD(e);
    return false;
  }
}
