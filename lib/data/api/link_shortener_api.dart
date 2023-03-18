import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:puntos_colombia_prueba/data/dto/link_dto.dart';

class AppLinkShortenerApi {
  final String shortenerApiAuthority = 'cleanuri.com';
  final String shortenerApiPath = '/api/v1/shorten';
  Map<String, dynamic> linkShortenerUrlBody = {
    'url': '',
  };

  Future<AppLinkDto?> shortLink(AppLinkDto linkDto) async {
    http.Response response;
    AppLinkDto? dto;
    final encodedUrl = Uri.encodeFull(linkDto.url);
    final uri = Uri.https(shortenerApiAuthority, shortenerApiPath);
    linkShortenerUrlBody['url'] = encodedUrl;

    try {
      response = await http.post(
        uri,
        body: linkShortenerUrlBody,
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 400) {
        throw Exception(response.body);
      }

      dto = AppLinkDto.fromJson(data);
    } on SocketException catch (_) {
      throw Exception('No internet');
    } on TimeoutException catch (_) {
      throw Exception('Service down');
    }

    return dto;
  }
}
