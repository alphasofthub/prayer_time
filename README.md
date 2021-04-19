A library for Dart developers.

A Dart Package to find prayers/ramazan timings for your exact location.

  ## Features
1. Standalone
2. Astronomical calculations
3. can find for your exact location
  
## LICENSE
GPL-3

## Usage

A simple usage example:

  

```dart

import  'package:PrayerTime/PrayerTime.dart';

  

void  main() {

/*

// method

0; // Jafari

1; // University of Islamic Sciences, Karachi

2; // Islamic Society of North America (ISNA)

3; // Muslim World League (MWL)

4; // Umm al-Qura, Makkah

5; // Egyptian General Authority of Survey

6; // Custom Setting

7; // Institute of Geophysics, University of Tehran

*/

PrayTime prayerTime =  PrayTime(method:  1);

  

// date {year, mday, mon}, latitude, longitude, timezone

var times = prayerTime.getPrayerTimes({

"year":  2021,

"mday":  19,

"mon":  4,

}, 31.170406299999996, 72.7097161, 5);

  

// [Fajr, Sunrise, Dhuhr, Asr, Sunset, Maghrib, Isha]

print(times);

  

}

```

 
### Issue

https://github.com/lablnet/prayer_time/issues