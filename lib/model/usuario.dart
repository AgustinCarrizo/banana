import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  
    final int id;
    final String username;
    final String email;
    final String firstName;
    final String lastName;
    final String gender;
    final String image;
    final String token;

  
  Usuario(this.id, this.username, this.email, this.firstName, this.lastName, this.gender, this.image, this.token);

  
  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);


  
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}