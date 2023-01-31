import 'dart:convert';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:http/http.dart' as http;

Player? playerFromJson(String str) => Player.fromJson(json.decode(str));

List<Player>? playerListFromJson(String str) => json.decode(str) == null ? [] : List<Player>.from(json.decode(str)!.map((x) => Player.fromJson(x)));

String playerToJson(Player? data) => json.encode(data!.toJson());

Map<int, String> demarcacionTypes = {
  101: 'Portero',
  102: 'Defensa',
  103: 'Centrocampista',
  104: 'Delantero',
};

class Player {
    Player({
        this.id,
        this.numberId,
        this.name,
        this.featuredMedia,
        this.resourceMedia,
        this.demarcacion,
        this.demarcacionId,
    });

    int? id;
    int? numberId;
    String? name;
    int? featuredMedia;
    String? resourceMedia;
    String? demarcacion;
    int? demarcacionId;

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'],
        numberId: json['acf']['numero'],
        name: json['title']["rendered"],
        featuredMedia: json['featured_media'],
        demarcacion: json['demarcacion'][0] is int
          ? demarcacionTypes[json['demarcacion'][0]]
          : null,
        demarcacionId: json['demarcacion'][0]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "featuredMedia": featuredMedia,
        "resourceMedia": resourceMedia,
        "demarcacion": demarcacion,
    };

    getMedia() async {
      if (featuredMedia != null) {
        final String url = '${MainTheme.apiBaseUrl}/media/$featuredMedia';
        final resp = await http.get(Uri.parse(url));
        final mediaResponse = json.decode(resp.body);
        resourceMedia = mediaResponse['media_details']['sizes']['full']['source_url'].toString();
      } else {
        resourceMedia = null;
      }
    }

}