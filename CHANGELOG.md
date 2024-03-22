### Version 2.0.0 (2024-05-22)

**New Features:**

* Added null safety support.

**Improvements:**

* Converted constants to static final variables for better performance.
* Made variables private and exposed them through getters and setters for better encapsulation.
* Extracted smaller, well-named methods for improved readability and maintainability.
* Added type annotations for parameters and return values for clarity.
* Divided the code into multiple files for better organization:
    * `PrayerTime.dart`
    * `constants.dart`
    * `utils.dart`
* Change the name of the package from `PrayerTime` to `prayer_time` to follow Dart's package naming conventions.

**Breaking Changes:**

* Renamed the package from `PrayerTime` to `prayer_time`.
* Instead of using `int` for the `method` parameter in the `PrayTime` constructor, use the constants like `Karachi`, `ISNA`, etc.


### 1.0.0

- Initial version, created by Muhammad Umer Farooq
