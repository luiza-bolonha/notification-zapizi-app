
import 'package:json_annotation/json_annotation.dart';

part 'response_login_dto.g.dart';

@JsonSerializable()
class ResponseLoginDTO{
  String accessToken;
  String refreshToken;

  ResponseLoginDTO({
    required this.accessToken,
    required this.refreshToken,
  });
  factory ResponseLoginDTO.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseLoginDTOToJson(this);
}