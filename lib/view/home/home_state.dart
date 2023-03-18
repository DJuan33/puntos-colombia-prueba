import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:puntos_colombia_prueba/domain/model/link.dart';

part 'home_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    required bool isError,
    required bool isLoading,
    required AppLink? shortenedLink,
    required bool validUrl,
  }) = _HomeScreenState;

  static HomeScreenState initial = const HomeScreenState(
    isError: false,
    isLoading: false,
    shortenedLink: null,
    validUrl: true,
  );
}
