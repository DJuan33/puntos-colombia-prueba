import 'package:puntos_colombia_prueba/data/adapter/model_dto_adapter.dart';
import 'package:puntos_colombia_prueba/data/dto/link_dto.dart';
import 'package:puntos_colombia_prueba/domain/model/link.dart';

class AppLinkAdapter implements ModelDtoAdapter<AppLink, AppLinkDto> {
  @override
  AppLinkDto toDto(AppLink model) => AppLinkDto(url: model.url);

  @override
  AppLink toModel(AppLinkDto dto) => AppLink(url: dto.url);
}
