import 'package:bloc/bloc.dart';
import 'package:puntos_colombia_prueba/domain/model/link.dart';
import 'package:puntos_colombia_prueba/domain/repository/link_shortener_repository.dart';
import 'package:puntos_colombia_prueba/view/home/home_state.dart';

class HomeScreenController extends Cubit<HomeScreenState> {
  HomeScreenController(
    this._linkRepository,
  ) : super(HomeScreenState.initial);
  final AppLinkShortenerRepository _linkRepository;

  void checkLink(String url) {
    var validUrl = false;
    final urlExp = RegExp(
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?',
    );

    final matchUrl = urlExp.hasMatch(url);

    if (matchUrl) {
      validUrl = true;
    }

    emit(
      state.copyWith(validUrl: validUrl),
    );
  }

  @override
  void onError(
    Object error,
    StackTrace stackTrace,
  ) {
    super.onError(
      error,
      stackTrace,
    );

    emit(
      state.copyWith(
        isError: true,
      ),
    );
  }

  void resetController() {
    emit(HomeScreenState.initial);
  }

  Future<void> sendLink(String url) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final link = AppLink(url: url);

    try {
      final shortLink = await _linkRepository.getShortLink(link);

      if (shortLink != null) {
        emit(
          state.copyWith(
            isLoading: false,
            shortenedLink: shortLink,
          ),
        );
      }
    } catch (e, s) {
      onError(e, s);
    }
  }
}
