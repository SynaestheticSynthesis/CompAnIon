import 'package:flutter/services.dart';

/// HealthConnectService - A service to gently listen to the body's rhythms.
/// This service follows the "Path of the Companion," using data only for reflection.
class HealthConnectService {
  static const MethodChannel _channel = MethodChannel('companion.health/connect');

  /// Check if Health Connect is available on the device.
  static Future<bool> isAvailable() async {
    try {
      return await _channel.invokeMethod('isAvailable');
    } catch (e) {
      return false;
    }
  }

  /// Request permission to read sleep and heart rate data.
  /// This must be triggered by a clear user action.
  static Future<bool> requestPermissions() async {
    try {
      return await _channel.invokeMethod('requestPermissions');
    } catch (e) {
      return false;
    }
  }

  /// Fetch sleep data for the last 7 days for reflection.
  static Future<List<Map<String, dynamic>>> getSleepData() async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod('getSleepData');
      return result?.cast<Map<String, dynamic>>() ?? [];
    } catch (e) {
      return [];
    }
  }

  /// Fetch resting heart rate data for the last 7 days.
  static Future<List<Map<String, dynamic>>> getHeartRateData() async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod('getHeartRateData');
      return result?.cast<Map<String, dynamic>>() ?? [];
    } catch (e) {
      return [];
    }
  }
}
