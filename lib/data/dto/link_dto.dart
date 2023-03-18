// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'link_dto.g.dart';

@JsonSerializable()
class AppLinkDto {
  AppLinkDto({required this.url});

  factory AppLinkDto.fromJson(Map<String, dynamic> json) =>
      _$AppLinkDtoFromJson(json);

  @JsonKey(name: 'result_url')
  final String url;

  Map<String, dynamic> toJson() => _$AppLinkDtoToJson(this);
}
