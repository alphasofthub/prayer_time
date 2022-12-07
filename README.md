A library for Dart developers.

A Dart Package to find prayers/ramadan timings for your exact location.

**This is the rewrite version of PHP code provided by [praytimes.org](http://praytimes.org/)**
## Features
1. Standalone
2. Astronomical calculations
3. Can find for your exact location
4. Several methods of calculation.
  
  #### Methods

5.  Jafari.
6.  University of Islamic Sciences, Karachi.
7.  Islamic Society of North America (ISNA).
8.  Muslim World League (MWL).
9.  Umm al-Qura, Makkah.
10.  Egyptian General Authority of Survey.
11.  Custom.
12.  Institute of Geophysics, University of Tehran
## LICENSE
GPL-3

## Specials thanks
Special thanks and credit goes to http://praytimes.org/

## Installations
```yaml
dependencies:
  prayer_time: ^1.0.0
```
Now import package.
```dart
import 'package:prayer_time/prayer_time.dart';
```
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
## Contribution
You're welcome to contribute to this project.
You should follow contribution guideline [Contribution guideline](https://github.com/lablnet/prayer_time/blob/main/CONTRIBUTING.md)

## License  
GPL-3  
  
## Support  
If you like this project; Donate coffee?    
here is the bitcoin address.  
[![Balance](https://img.balancebadge.io/btc/37x6PA4qtPu2fQnYdW5U7jztYhbchASpBV.svg)](https://img.balancebadge.io/btc/37x6PA4qtPu2fQnYdW5U7jztYhbchASpBV.svg)  
  
   ```37x6PA4qtPu2fQnYdW5U7jztYhbchASpBV```    
 Thank, you so much.  
  
## Disclaimer  
**I do not accept responsibility for any illegal usage**
 
### Issue

https://github.com/lablnet/prayer_time/issues
