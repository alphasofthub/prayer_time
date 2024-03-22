import 'package:test/test.dart';
import 'package:prayer_time/prayer_time.dart';

void main() {
  test('getPrayerTimes returns expected values for Karachi method', () {
    final calculator = PrayTime(method: Karachi);
    final date = {'year': 2023, 'mday': 23, 'mon': 10};
    final latitude = 31.170406299999996;
    final longitude = 72.7097161;
    final timeZone = 5.0;

    final times = calculator.getPrayerTimes(date, latitude, longitude, timeZone);
    expect(times[0], '4:56 AM'); // Fajr
    expect(times[1], '6:17 AM'); // Sunrise
  });
}
