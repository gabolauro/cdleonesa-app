import 'dart:convert';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:http/http.dart' as http;

Game? gameFromJson(String str) => Game.fromJson(json.decode(str));

List<Game>? gameListFromJson(String str) => json.decode(str) == null ? [] : List<Game>.from(json.decode(str)!.map((x) => Game.fromJson(x)));

String gameToJson(Game? data) => json.encode(data!.toJson());

class Game {
    Game({
        this.id,
        this.jornada,
        this.temporada,
        this.competicion,
        this.seccion,
        this.fecha,
        this.equipoContrario,
        this.escudoEquipoContrario,
        this.resourceMedia,
        this.resultado,
        this.status,
        this.lugarDelParido,
        required this.local,
    });

    int? id;
    int? jornada;
    String? temporada;
    String? competicion;
    String? seccion;
    DateTime? fecha;
    String? equipoContrario;
    int? escudoEquipoContrario;
    String? resourceMedia;
    List<String>? resultado;
    String? status;
    String? lugarDelParido;
    bool local;

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json['id'],
        jornada: json['acf']["jornada"],
        temporada: json['acf']["temporada"],
        competicion: json['acf']["competicion"],
        seccion: json['acf']["seccion"] == '' ? 'Futbol' : json['acf']["seccion"],
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
        "jornada": jornada,
        "temporada": temporada,
        "competicion": competicion,
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
        if (resp.statusCode == 200) {
          resourceMedia = mediaResponse['media_details']['sizes']['full']['source_url'].toString();
        } else {
          resourceMedia = MainTheme.noPhoto;
        }
      } else {
        resourceMedia = null;
      }
    }

    bool get isTicketSale {
      DateTime today = DateTime.now();
      if (local) {
          return fecha!.isAfter(today); 
      }
      return false;
    }
}