import 'package:kiwi/kiwi.dart';
import 'package:puntos_colombia_prueba/app/repository/link_shortener_repository.dart';
import 'package:puntos_colombia_prueba/domain/repository/link_shortener_repository.dart';
import 'package:puntos_colombia_prueba/view/home/home_controller.dart';

part 'dependency_injector.g.dart';

abstract class AppInjector {
  static late KiwiContainer dependencyInjector;

  @Register.factory(
    AppLinkShortenerRepository,
    from: AppLinkShorternerRepositoryImpl,
  )
  @Register.factory(HomeScreenController)
  void configure();

  static void setup() {
    _$AppInjector().configure();
    dependencyInjector = KiwiContainer();
  }
}
