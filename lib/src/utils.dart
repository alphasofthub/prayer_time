// ignore: library_prefixes
import 'dart:math' as Math;

double dtr(var d) {
  return (d * Math.pi) / 180.0;
}

double dsin(var d) {
  return Math.sin(dtr(d));
}

double dcos(var d) {
  return Math.cos(dtr(d));
}

double dtan(var d) {
  return Math.tan(dtr(d));
}

double rtd(double r) {
  return (r * 180.0) / Math.pi;
}

double darcsin(double x) {
  return rtd(Math.asin(x));
}

double darccos(var x) {
  return rtd(Math.acos(x));
}

double darctan(double x) {
  return rtd(Math.atan(x));
}

double darctan2(double y, double x) {
  return rtd(Math.atan2(y, x));
}

double darccot(double x) {
  return rtd(Math.atan(1 / x));
}

double fixangle(double a) {
  a = a - 360.0 * (a / 360.0).floor();
  return a < 0 ? a + 360.0 : a;
}

double fixhour(double a) {
  a = a - 24.0 * (a / 24.0).floor();
  return a < 0 ? a + 24.0 : a;
}

double julianDate(int year, int month, int day) {
  if (month <= 2) {
    year -= 1;
    month += 12;
  }
  final A = (year / 100).floor();
  final B = 2 - A + (A / 4).floor();
  final JD = (365.25 * (year + 4716)).floor() +
      (30.6001 * (month + 1)).floor() +
      day +
      B -
      1524.5;
  return JD;
}
