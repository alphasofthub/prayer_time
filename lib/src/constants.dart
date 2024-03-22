// Calculation Methods
const int Jafari = 0;
const int Karachi = 1;
const int ISNA = 2;
const int MWL = 3;
const int Makkah = 4;
const int Egypt = 5;
const int Custom = 6;
const int Tehran = 7;

// Juristic Methods
const int Shafii = 0;
const int Hanafi = 1;

// Adjusting Methods for Higher Latitudes
const int None = 0;
const int MidNight = 1;
const int OneSeventh = 2;
const int AngleBased = 3;

// Time Formats
const int Time24 = 0;
const int Time12 = 1;
const int Time12NS = 2;
const int Float = 3;

// Time Names
const List<String> timeNames = [
  'Fajr',
  'Sunrise',
  'Dhuhr',
  'Asr',
  'Sunset',
  'Maghrib',
  'Isha'
];

const String InvalidTime = '-----';
