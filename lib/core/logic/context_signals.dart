import 'dart:math';

class ContextSignals {
  static String getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 6) return 'night';
    if (hour < 12) return 'morning';
    if (hour < 18) return 'afternoon';
    return 'evening';
  }

  static String getLocation() {
    final locations = ['home', 'work', 'outside', 'cafe'];
    return locations[Random().nextInt(locations.length)];
  }

  static String getWeather() {
    final weathers = ['sunny', 'cloudy', 'rainy', 'windy'];
    return weathers[Random().nextInt(weathers.length)];
  }
}
