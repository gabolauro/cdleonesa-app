import 'dart:convert';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:http/http.dart' as http;

Game? gameFromJson(String str) => Game.fromJson(json.decode(str));

List<Game>? gameListFromJson(String str) => json.decode(str) == null ? [] : List<Game>.from(json.decode(str)!.map((x) => Game.fromJson(x)));

String gameToJson(Game? data) => json.encode(data!.toJson());

class Game {
    Game({
        this.id,
        this.fecha,
        this.equipoContrario,
        this.escudoEquipoContrario,
        this.resourceMedia,
        this.resultado,
        this.status,
        this.lugarDelParido,
        this.local,
    });

    int? id;
    DateTime? fecha;
    String? equipoContrario;
    int? escudoEquipoContrario;
    String? resourceMedia;
    List<String>? resultado;
    String? status;
    String? lugarDelParido;
    bool? local;

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json['id'],
        fecha: DateTime.parse(json['acf']["fecha"]),
        equipoContrario: json['acf']["equipo_contrario"],
        escudoEquipoContrario: json['acf']["escudo_equipo_contrario"] is int
          ? json['acf']["escudo_equipo_contrario"]
          : null,
        resultado: json['acf']["resultado"] != '' ? json['acf']["resultado"].split('-') : [],
        status: json['acf']["resultado"] == '' ? 'scheduled' : 'finished',
        lugarDelParido: json['acf']["lugar_del_parido"],
        local: json['acf']["se_juega"] == 'en casa: casa' ? true : false,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha?.toIso8601String(),
        "equipo_contrario": equipoContrario,
        "escudo_equipo_contrario": escudoEquipoContrario,
        "resultado": resultado,
        "resourceMedia": resourceMedia,
        "status": status,
        "lugar_del_parido": lugarDelParido,
        "local": local,
    };

    getMedia() async {
      if (escudoEquipoContrario != null) {
        final String url = '${MainTheme.apiBaseUrl}/media/$escudoEquipoContrario';
        final resp = await http.get(Uri.parse(url));
        final mediaResponse = json.decode(resp.body);
        resourceMedia = mediaResponse['media_details']['sizes']['full']['source_url'].toString();
      } else {
        resourceMedia = null;
      }
    }
}