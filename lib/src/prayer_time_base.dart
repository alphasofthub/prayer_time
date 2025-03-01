import 'constants.dart';
import 'utils.dart';

class PrayTime {
  static final Map<int, List<int>> _methodParams = {
    Jafari: [16, 0, 4, 0, 14],
    Karachi: [18, 1, 0, 0, 18],
    ISNA: [15, 1, 0, 0, 15],
    MWL: [18, 1, 0, 0, 17],
    Makkah: [18, 1, 0, 1, 90],
    Egypt: [19, 1, 0, 0, 17],
    Custom: [17, 0, 4, 0, 14],
    Tehran: [18, 1, 0, 0, 17],
  };

  int _calcMethod = Karachi;
  int _asrJuristic = Shafii;
  int _dhuhrMinutes = 0;
  int _adjustHighLats = MidNight;
  int _timeFormat = Time12;

  double _lat = 0.0;
  double _lng = 0.0;
  double _timeZone = 0.0;
  double _JDate = 0.0;
  int _numIterations = 1;

  PrayTime({int method = Karachi, in juristic = Shafii}) {
    _calcMethod = method;
    _asrJuristic = juristic;
  }

  List<String> getPrayerTimes(Map<String, int> date, double latitude,
      double longitude, double timeZone) {
    return getDatePrayerTimes(
        date['year']!, date['mon']!, date['mday']!, latitude, longitude, timeZone);
  }

  List<String> getDatePrayerTimes(int year, int month, int day, double latitude,
      double longitude, double timeZone) {
    _lat = latitude;
    _lng = longitude;
    _timeZone = timeZone;
    _JDate = julianDate(year, month, day) - longitude / (15 * 24);
    return _computeDayTimes();
  }

  List<String> _computeDayTimes() {
    List<double> times = [5.0, 6.0, 12.0, 13.0, 18.0, 18.0, 18.0];
    for (int i = 1; i <= _numIterations; i++) {
      times = _computeTimes(times);
    }
    times = _adjustTimes(times);
    return _adjustTimesFormat(times);
  }

  List<double> _computeTimes(List<double> times) {
    final List<double> t = _dayPortion(times);
    final double Fajr =
        computeTime((180 - _methodParams[_calcMethod]![0]), t[0]);
    final double Sunrise = computeTime(180 - 0.833, t[1]);
    final double Dhuhr = _computeMidDay(t[2]);
    final double Asr = _computeAsr(1 + _asrJuristic, t[3]);
    final double Sunset = computeTime(0.833, t[4]);
    final double Maghrib =
        computeTime(_methodParams[_calcMethod]![2], t[5]);
    final double Isha = computeTime(_methodParams[_calcMethod]![4], t[6]);
    return [Fajr, Sunrise, Dhuhr, Asr, Sunset, Maghrib, Isha];
  }

  double _computeMidDay(double t) {
    final double equation = sunPosition(_JDate + t)['equation']!;
    return fixhour(12 - equation);
  }

  double computeTime(var G, double t) {
    final D = sunPosition(_JDate + t)['declination']!;
    final Z = _computeMidDay(t);
    final V = 1 / 15 *
        darccos((-dsin(G) - dsin(D) * dsin(_lat)) / (dcos(D) * dcos(_lat)));
    return Z + (G > 90 ? -V : V);
  }

  double _computeAsr(int step, double t) {
    final double D = sunPosition(_JDate + t)['declination']!;
    final double G = -darccot(step + dtan((_lat - D).abs()));
    return computeTime(G, t);
  }

  List<double> _adjustTimes(List<double> times) {
    for (int i = 0; i < 7; i++) {
      times[i] += _timeZone - _lng / 15;
    }
    times[2] += _dhuhrMinutes / 60; // Dhuhr
    if (_methodParams[_calcMethod]![1] == 1) {
      // Maghrib
      times[5] = times[4] + _methodParams[_calcMethod]![2] / 60;
    }
    if (_methodParams[_calcMethod]![3] == 1) {
      // Isha
      times[6] = times[5] + _methodParams[_calcMethod]![4] / 60;
    }
    if (_adjustHighLats != None) {
      times = _adjustHighLatTimes(times);
    }
    return times;
  }

  List<String> _adjustTimesFormat(List<double> times) {
    if (_timeFormat == Float) return times.map((t) => t.toString()).toList();

    final List<String> newTimes = [];
    for (int i = 0; i < 7; i++) {
      if (_timeFormat == Time12) {
        newTimes.add(floatToTime12(times[i]));
      } else if (_timeFormat == Time12NS) {
        newTimes.add(floatToTime12(times[i], suffix: false));
      } else {
        newTimes.add(floatToTime24(times[i]));
      }
    }
    return newTimes;
  }

  List<double> _adjustHighLatTimes(List<double> times) {
    final double nightTime = timeDiff(times[4], times[1]); // sunset to sunrise

    // Adjust Fajr
    final double FajrDiff = _nightPortion(_methodParams[_calcMethod]![0]) * nightTime;
    if (times[0].isNaN || timeDiff(times[0], times[1]) > FajrDiff) {
      times[0] = times[1] - FajrDiff;
    }

    // Adjust Isha
    final int IshaAngle =
        (_methodParams[_calcMethod]![3] == 0) ? _methodParams[_calcMethod]![4] : 18;
    final double IshaDiff = _nightPortion(IshaAngle) * nightTime;
    if (times[6].isNaN || timeDiff(times[4], times[6]) > IshaDiff) {
      times[6] = times[4] + IshaDiff;
    }

    // Adjust Maghrib
    final int MaghribAngle =
        (_methodParams[_calcMethod]![1] == 0) ? _methodParams[_calcMethod]![2] : 4;
    final double MaghribDiff = _nightPortion(MaghribAngle) * nightTime;
    if (times[5].isNaN || timeDiff(times[4], times[5]) > MaghribDiff) {
      times[5] = times[4] + MaghribDiff;
    }

    return times;
  }

  double _nightPortion(int angle) {
    if (_adjustHighLats == AngleBased) return 1 / 60 * angle;
    if (_adjustHighLats == MidNight) return 1 / 2;
    if (_adjustHighLats == OneSeventh) return 1 / 7;
    return 0; // Should not reach here
  }

  List<double> _dayPortion(List<double> times) {
    return times.map((time) => time / 24).toList();
  }

  double timeDiff(double time1, double time2) {
    return fixhour(time2 - time1);
  }

  String floatToTime24(double time) {
    if (time.isNaN) return InvalidTime;
    time = fixhour(time + 0.5 / 60); // add 0.5 minutes to round
    final int minutes = ((time - time.floor()) * 60).floor();
    return '${twoDigitsFormat(time.floor())}:${twoDigitsFormat(minutes)}';
  }

  String floatToTime12(double time, {bool suffix = true}) {
    if (time.isNaN) return InvalidTime;
    time = fixhour(time + 0.5 / 60); // add 0.5 minutes to round
    int hours = time.floor();
    final int minutes = ((time - hours) * 60).floor();
    final String suffixStr = suffix ? (hours >= 12 ? ' PM' : ' AM') : '';
    hours = ((hours + 12 - 1) % 12 + 1);
    return '$hours:${twoDigitsFormat(minutes)}$suffixStr';
  }

  String twoDigitsFormat(int num) {
    return (num < 10) ? '0$num' : '$num';
  }

  Map<String, double> sunPosition(double jd) {
    final double D = jd - 2451545.0;
    final double g = fixangle(357.529 + 0.98560028 * D);
    final double q = fixangle(280.459 + 0.98564736 * D);
    final double L = fixangle(q + 1.915 * dsin(g) + 0.020 * dsin(2 * g));
    // final double R = 1.00014 - 0.01671 * dcos(g) - 0.00014 * dcos(2 * g);
    final double e = 23.439 - 0.00000036 * D;
    final double d = darcsin(dsin(e) * dsin(L));
    double RA = darctan2(dcos(e) * dsin(L), dcos(L)) / 15;
    RA = fixhour(RA);
    final double EqT = q / 15 - RA;
    return {"declination": d, "equation": EqT};
  }

  // Getters and Setters
  // ... (Add getters and setters for all private variables)
}
