import 'package:puntos_colombia_prueba/app/constants.dart';
import 'package:puntos_colombia_prueba/domain/enum/screen_size_enum.dart';

/// App method utilities.
class AppUtils {
  /// Receives the screen width and returns the corresponding screen size type.
  static AppScreenSize getScreenSize(double screenWidth) {
    var currentScreenSize = AppScreenSize.mobile;

    if (screenWidth > AppConstants.screenBreakpointTablet) {
      currentScreenSize = AppScreenSize.tablet;
    }

    if (screenWidth > AppConstants.screenBreakpointWeb) {
      currentScreenSize = AppScreenSize.web;
    }

    return currentScreenSize;
  }
}
