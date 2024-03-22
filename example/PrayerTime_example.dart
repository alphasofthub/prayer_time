import 'package:prayer_time/PrayerTime.dart';
import 'package:prayer_time/src/constants.dart';

void main() {
  /*
    // method
    Jafari;    // Jafari
    Karachi;    // University of Islamic Sciences, Karachi
    ISNA;    // Islamic Society of North America (ISNA)
    MWL;    // Muslim World League (MWL)
    Makkah;    // Umm al-Qura, Makkah
    Egypt;    // Egyptian General Authority of Survey
    Custom;    // Custom Setting
    Tehran;    // Institute of Geophysics, University of Tehran
  */
  PrayTime prayerTime = PrayTime(method:Karachi);

  // date {year, mday, mon}, latitude, longitude, timezone
  var times = prayerTime.getPrayerTimes({
    "year": 2021,
    "mday": 19,
    "mon": 4,
  }, 31.170406299999996, 72.7097161, 5);

  // [Fajr, Sunrise, Dhuhr, Asr, Sunset, Maghrib, Isha]
  print(times);

}
