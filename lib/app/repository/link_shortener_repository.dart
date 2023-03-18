import 'package:puntos_colombia_prueba/data/adapter/link_adapter.dart';
import 'package:puntos_colombia_prueba/data/api/link_shortener_api.dart';
import 'package:puntos_colombia_prueba/domain/model/link.dart';
import 'package:puntos_colombia_prueba/domain/repository/link_shortener_repository.dart';

class AppLinkShorternerRepositoryImpl implements AppLinkShortenerRepository {
  final AppLinkAdapter _linkAdapter = AppLinkAdapter();
  final AppLinkShortenerApi _linkShortenerApi = AppLinkShortenerApi();

  @override
  Future<AppLink?> getShortLink(AppLink link) async {
    final dto = _linkAdapter.toDto(link);
    AppLink? shortenedLink;

    try {
      final shortenedLinkDto = await _linkShortenerApi.shortLink(dto);
      if (shortenedLinkDto == null) {
        throw Exception('Failed task: Fetch shortened URL');
      } else {
        shortenedLink = _linkAdapter.toModel(shortenedLinkDto);
      }
    } catch (e) {
      throw Exception('Failed task: Fetch shortened URL\n$e');
    }

    return shortenedLink;
  }
}
