import 'dart:convert';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:http/http.dart' as http;

Partner? partnerFromJson(String str) => Partner.fromJson(json.decode(str));

List<Partner>? partnerListFromJson(String str) => json.decode(str) == null ? [] : List<Partner>.from(json.decode(str)!.map((x) => Partner.fromJson(x)));

String partnerToJson(Partner? data) => json.encode(data!.toJson());

class Partner {
    Partner({
        this.id,
        this.name,
        this.link,
        this.image,
        this.resourceMedia,
        this.category,
        this.categoryId,
    });

    int? id;
    String? name;
    String? link;
    int? image;
    String? resourceMedia;
    String? category;
    int? categoryId;


    static Map<int, Map> categories = {
      193: {
        'name': 'Oficiales',
        'isExpanded': true
      },
      194: {
        'name': 'Deportivos',
        'isExpanded': true
      },
      195: {
        'name': 'Empresas',
        'isExpanded': false
      },
      196: {
        'name': 'Administraciones',
        'isExpanded': false
      },
    };

    factory Partner.fromJson(Map<String, dynamic> json) => Partner(
        id: json['id'],
        name: json['title']["rendered"],
        link: json['acf']['enlace'],
        image: json['acf']['imagen'],
        category: json['categoria_patrocinadores'][0] is int
          ? categories[json['categoria_patrocinadores'][0]]!['name']
          : null,
        categoryId: json['categoria_patrocinadores'][0]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "resourceMedia": resourceMedia,
        "category": category,
    };

    getMedia() async {
      if (image != null) {
        final String url = '${MainTheme.apiBaseUrl}/media/$image';
        final resp = await http.get(Uri.parse(url));
        final mediaResponse = json.decode(resp.body);
        if (resp.statusCode == 200) {
          resourceMedia = mediaResponse['media_details']['sizes']['medium']['source_url'].toString();
        } else {
          resourceMedia = MainTheme.noPhoto;
        }
      } else {
        resourceMedia = null;
      }
    }

}