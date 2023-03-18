// ignore_for_file: one_member_abstracts

import 'package:puntos_colombia_prueba/domain/model/link.dart';

abstract class AppLinkShortenerRepository {
  Future<AppLink?> getShortLink(AppLink link);
}
