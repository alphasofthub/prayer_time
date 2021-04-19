library PrayerTime;

import 'dart:math' as Math;

class PrayTime
{
    // Calculation Methods
    var Jafari     = 0;
    var _Karachi    = 1;    // University of Islamic Sciences, Karachi
    var _ISNA       = 2;    // Islamic Society of North America (ISNA)
    var _MWL        = 3;    // Muslim World League (MWL)
    var _Makkah     = 4;    // Umm al-Qura, Makkah
    var _Egypt      = 5;    // Egyptian General Authority of Survey
    var _Custom     = 6;    // Custom Setting
    var _Tehran     = 7;    // Institute of Geophysics, University of Tehran

    // params
    var _methodParams = {
      0: [16, 0, 4, 0, 14],
      1: [18, 1, 0, 0, 18],
      2: [15, 1, 0, 0, 15],
      3: [18, 1, 0, 0, 17],
      4: [18.5, 1, 0, 1, 90],
      5: [19.5, 1, 0, 0, 17.5],
      6: [17.7, 0, 4.5, 0, 14],
      7: [18, 1, 0, 0, 17],
    };

    // Juristic Methods
    var _Shafii     = 0;    // Shafii (standard)
    var _Hanafi     = 1;    // Hanafi

    // Adjusting Methods for Higher Latitudes
    var _None       = 0;    // No adjustment
    var _MidNight   = 1;    // middle of night
    var _OneSeventh = 2;    // 1/7th of night
    var _AngleBased = 3;    // angle/60th of night

    // Time Formats
    var _Time24     = 0;    // 24-hour format
    var _Time12     = 1;    // 12-hour format
    var _Time12NS   = 2;    // 12-hour format with no suffix
    var _Float      = 3;    // floating point number

    // Time Names
    var _timeNames = [
        'Fajr',
        'Sunrise',
        'Dhuhr',
        'Asr',
        'Sunset',
        'Maghrib',
        'Isha'
    ];

    var _InvalidTime = '-----';     // The string used for invalid times
    var _calcMethod   = 1;        // caculation method
    var _asrJuristic  = 1;        // Juristic method for Asr
    var _dhuhrMinutes = 0;        // minutes after mid-day for Dhuhr
    var _adjustHighLats = 1;    // adjusting method for higher latitudes

    var _timeFormat   = 1;        // time format

    var _lat;        // latitude
    var _lng;        // longitude
    var _timeZone;   // time-zone
    var _JDate;      // Julian date

    var _numIterations = 1;

    get ISNA => _ISNA;

    get MWL => _MWL;

    get Makkah => _Makkah;

    get Egypt => _Egypt;

    get Custom => _Custom;

    get Tehran => _Tehran;

    get methodParams =>
        _methodParams;

    get Shafii => _Shafii;

    get Hanafi => _Hanafi;

    get None => _None;

    get MidNight => _MidNight;

    get OneSeventh =>
        _OneSeventh;

    get AngleBased =>
        _AngleBased;

    get Time24 => _Time24;

    get Time12 => _Time12;

    get Time12NS => _Time12NS;

    get Float => _Float;

    get timeNames => _timeNames;

    get InvalidTime =>
        _InvalidTime;

    get calcMethod =>
        _calcMethod;

    get asrJuristic =>
        _asrJuristic;

    get dhuhrMinutes =>
        _dhuhrMinutes;

    get adjustHighLats =>
        _adjustHighLats;

    get timeFormat =>
        _timeFormat;

    get lat => _lat;

    get lng => _lng;

    get timeZone => _timeZone;

    get JDate => _JDate;

    get numIterations =>
        _numIterations;

    set numIterations(value) {
        _numIterations = value;
    }

    set JDate(value) {
        _JDate = value;
    }

    set timeZone(value) {
        _timeZone = value;
    }

    set lng(value) {
        _lng = value;
    }

    set lat(value) {
        _lat = value;
    }

    set timeFormat(value) {
        _timeFormat = value;
    }

    set adjustHighLats(value) {
        _adjustHighLats = value;
    }

    set dhuhrMinutes(value) {
        _dhuhrMinutes = value;
    }

    set asrJuristic(value) {
        _asrJuristic = value;
    }

    set calcMethod(value) {
        _calcMethod = value;
    }

    set InvalidTime(value) {
        _InvalidTime = value;
    }

    set timeNames(value) {
        _timeNames = value;
    }

    set Float(value) {
        _Float = value;
    }

    set Time12NS(value) {
        _Time12NS = value;
    }

    set Time12(value) {
        _Time12 = value;
    }

    set Time24(value) {
        _Time24 = value;
    }

    set AngleBased(value) {
        _AngleBased = value;
    }

    set OneSeventh(value) {
        _OneSeventh = value;
    }

    set MidNight(value) {
        _MidNight = value;
    }

    set None(value) {
        _None = value;
    }

    set Hanafi(value) {
        _Hanafi = value;
    }

    set Shafii(value) {
        _Shafii = value;
    }

    set methodParams(value) {
        _methodParams = value;
    }

    set Tehran(value) {
        _Tehran = value;
    }

    set Custom(value) {
        _Custom = value;
    }

    set Egypt(value) {
        _Egypt = value;
    }

    set Makkah(value) {
        _Makkah = value;
    }

    set MWL(value) {
        _MWL = value;
    }

    set ISNA(value) {
        _ISNA = value;
    }

    set Karachi(value) {
        _Karachi = value;
    } // number of iterations needed to compute times


    //------------------- Calc Method Parameters --------------------

    PrayTime({var method = 1})
    {
        _calcMethod = method;
        _asrJuristic = method;
    }

    getPrayerTimes(var date, var latitude, var longitude, var timeZone)
    {
        return this.getDatePrayerTimes(date['year'], date['mon'], date['mday'],
    latitude, longitude, timeZone);
    }

    getDatePrayerTimes(var year, var month, var day, var latitude, var longitude, var timeZone) {
        _lat = (latitude);
        _lng = (longitude);
        _timeZone = (timeZone);
        _JDate = (this.julianDate(year, month, day) - longitude / (15 * 24));
        return this.computeDayTimes();
    }

    floatToTime24(var time)
    {
        if (time.isNaN)
            return this.InvalidTime;
        time = this.fixhour(time + 0.5/ 60);  // add 0.5 minutes to round
        var minutes = ((time - time.floor()) * 60).floor();
        return this.twoDigitsFormat(time.floor()).toString() + ':' + this.twoDigitsFormat(minutes).toString();
    }

    floatToTime12(time, {suffix: true})
    {
        if (time.isNaN)
            return this.InvalidTime;
        time = this.fixhour(time + 0.5/ 60);  // add 0.5 minutes to round
        var hours = time.floor();
        var minutes = ((time - hours) * 60).floor();
        var suffix = hours >= 12 ? ' pm' : ' am';
        hours = ((hours + 12 - 1) % 12 + 1);
        return (hours.toString()) + ':'+ this.twoDigitsFormat(minutes).toString() + suffix;
    }

    // convert float hours to 12h format with no suffix
    floatToTime12NS(time)
    {
        return this.floatToTime12(time);
    }
    Map sunPosition(var jd)
    {
        var D = jd - 2451545.0;
        var g = this.fixangle(357.529 + 0.98560028 * D);
        var q = this.fixangle(280.459 + 0.98564736 * D);
        var L = this.fixangle(q + 1.915 * this.dsin(g) + 0.020 * this.dsin(2 * g));

        var R = 1.00014 - 0.01671 * this.dcos(g) - 0.00014 * this.dcos(2 * g);
        var e = 23.439 - 0.00000036 * D;

        var d = this.darcsin(this.dsin(e) * this.dsin(L));
        var RA = this.darctan2(this.dcos(e) * this.dsin(L), this.dcos(L)) / 15;
        RA = this.fixhour(RA);
        var EqT = q/15 - RA;

        return {"declination": d, "equation": EqT};
    }

    computeMidDay(var t)
    {
        t = this.sunPosition(JDate + t)['equation'];
        return this.fixhour(12 - t);
    }
    computeTime(var G, var t)
    {
        var D = this.sunPosition(JDate + t)['declination'];
        var Z = this.computeMidDay(t);
        var V = 1/15 * this.darccos((- this.dsin(G) - this.dsin(D) * this.dsin(lat))/
        (this.dcos(D)* this.dcos(lat)));
        return Z+ (G > 90 ? -V : V);
    }
    // compute the time of Asr
    computeAsr(var step, var t)  // Shafii: step=1, Hanafi: step=2
    {
        var D = this.sunPosition(JDate + t)['declination'];
        var G = -this.darccot(step + this.dtan((lat - D).abs()));
        return this.computeTime(G, t);
    }
    // compute prayer times at given julian date
    List<double> computeTimes(List<double> times)
    {
        var t = this.dayPortion(times);
        var Fajr    = this.computeTime(180- this.methodParams[this.calcMethod][0], t[0]);
        var Sunrise = this.computeTime(180- 0.833, t[1]);
        var Dhuhr   = this.computeMidDay(t[2]);
        var Asr     = this.computeAsr(1 + this.asrJuristic, t[3]);
        var Sunset  = this.computeTime(0.833, t[4]);;
        var Maghrib = this.computeTime(this.methodParams[this.calcMethod][2], t[5]);
        var Isha    = this.computeTime(this.methodParams[this.calcMethod][4], t[6]);

        return [Fajr, Sunrise, Dhuhr, Asr, Sunset, Maghrib, Isha];
    }

    computeDayTimes()
    {
        List<double> times = [5.0, 6.0, 12.0, 13.0, 18.0, 18.0, 18.0];

        for (int i = 1; i <= this.numIterations; i++) {
            times = this.computeTimes(times);
        }

        times = this.adjustTimes(times);
        return this.adjustTimesFormat(times);
    }

    adjustTimes(List<double> times)
    {
        for (int i = 0; i < 7; i++)
            times[i] += this.timeZone - this.lng / 15;
        times[2] += this.dhuhrMinutes/ 60; //Dhuhr
        if (this.methodParams[this.calcMethod][1] == 1) // Maghrib
            times[5] = times[4] + this.methodParams[this.calcMethod][2]/ 60;
        if (this.methodParams[this.calcMethod][3] == 1) // Isha
            times[6] = times[5] + this.methodParams[this.calcMethod][4]/ 60;

        if (this.adjustHighLats != this.None)
            times = this.adjustHighLatTimes(times);
        return times;
    }


    adjustTimesFormat(List<double> times)
    {
        List<String> newtime = [];
        for (int i = 0; i < 7; i++) {
            newtime.add("");
        }
        if (this.timeFormat == this.Float)
            return times;
        for (int i = 0; i < 7; i++)
            if (this.timeFormat == this.Time12)
                newtime[i] = this.floatToTime12(times[i]);
            else if (this.timeFormat == this.Time12NS)
                newtime[i] = this.floatToTime12(times[i]);
            else
                newtime[i] = (this.floatToTime24(times[i]));
        return newtime;
    }


    adjustHighLatTimes(var times)
    {
        var nightTime = this.timeDiff(times[4], times[1]); // sunset to sunrise

        // Adjust Fajr
        var FajrDiff = this.nightPortion(this.methodParams[this.calcMethod][0]) * nightTime;
        if (times[0].isNaN || this.timeDiff(times[0], times[1]) > FajrDiff)
            times[0] = times[1]- FajrDiff;

        // Adjust Isha
        var IshaAngle = (this.methodParams[this.calcMethod][3] == 0) ? this.methodParams[this.calcMethod][4] : 18;
        var IshaDiff = this.nightPortion(IshaAngle) * nightTime;
        if (times[6].isNaN || this.timeDiff(times[4], times[6]) > IshaDiff)
            times[6] = times[4] + IshaDiff;

        // Adjust Maghrib
        var MaghribAngle = (this.methodParams[this.calcMethod][1] == 0) ? this.methodParams[this.calcMethod][2] : 4;
        var MaghribDiff = this.nightPortion(MaghribAngle) * nightTime;
        if (times[5].isNaN || this.timeDiff(times[4], times[5]) > MaghribDiff)
            times[5] = times[4]+ MaghribDiff;

        return times;
    }


    nightPortion(angle)
    {
        if (this.adjustHighLats == this.AngleBased)
            return 1/60 * angle;
        if (this.adjustHighLats == this.MidNight)
            return 1/2;
        if (this.adjustHighLats == this.OneSeventh)
            return 1/7;
    }


    dayPortion(List<double> times)
    {
        for (int i = 0; i < 7; i++) {
            times[i] = (times[i] / 24);
        }
        return times;
    }


    double timeDiff(var time1, var time2)
    {
        return this.fixhour(time2 - time1);
    }
    twoDigitsFormat(var num)
    {
        return (num <10) ? '0'+num.toString() : num;
    }

    double julianDate(var year, var month, var day)
    {
        if (month <= 2)
        {
            year -= 1;
            month += 12;
        }
        var A = (year/ 100).floor();
        var B = 2- A + (A/ 4).floor();

        var JD = (365.25 * (year + 4716)).floor() + (30.6001* (month+ 1)).floor() + day+ B- 1524.5;
        return JD;
    }

    /* Math functions */
    double dtr(var d)
    {
        return (d * Math.pi) / 180.0;
    }
    double dsin(var d)
    {
        return Math.sin(this.dtr(d));
    }
    double dcos(var d)
    {
        return Math.cos(this.dtr(d));
    }
    double dtan(var d)
    {
        return Math.tan(this.dtr(d));
    }
    double rtd(var r)
    {
        return (r * 180.0) / Math.pi;
    }
    double darcsin(var x)
    {
        return this.rtd(Math.asin(x));
    }
    double darccos(var x)
    {
        return this.rtd(Math.acos(x));
    }
    double darctan(var x)
    {
        return this.rtd(Math.atan(x));
    }
    double darctan2(var y, var x)
    {
        return this.rtd(Math.atan2(y, x));
    }
    double darccot(var x)
    {
        return this.rtd(Math.atan(1/x));
    }
    double fixangle(var a)
    {
        a = a - 360.0 * (a / 360.0).floor();
        return a < 0 ? a + 360.0 : a;
    }
    double fixhour(a)
    {
        a = a - 24.0 * (a / 24.0).floor();
        return a < 0 ? a + 24.0 : a;
    }

}