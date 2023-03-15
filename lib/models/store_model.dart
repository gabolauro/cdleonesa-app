import 'dart:convert';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:http/http.dart' as http;

import 'package:html_unescape/html_unescape.dart';

Store? newsFromJson(String str) => Store.fromJson(json.decode(str));

List<Store>? newsListFromJson(String str) => json.decode(str) == null ? [] : List<Store>.from(json.decode(str)!.map((x) => Store.fromJson(x)));


String newsToJson(Store? data) => json.encode(data!.toJson());


class Store {
    Store({
        required this.id,
        this.title,
        this.price,
        this.featuredMedia,
        this.resourceMedia,
    });

    int id;
    String? title;
    String? price;
    int? featuredMedia;
    String? resourceMedia;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        title: getTitle(json["title"]["rendered"]),
        price: getPrice(json["title"]["rendered"]),
        featuredMedia: json["featured_media"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "featured_media": featuredMedia,
    };

    static String getTitle(String content) {
      content = HtmlUnescape().convert(content);
      List<String> contentSplited = content.split(' – ');
      return contentSplited[0];
    }
    static String getPrice(String content) {
      content = HtmlUnescape().convert(content);
      List<String> contentSplited = content.split(' – ');
      return contentSplited[1];
    }

    getMedia() async {
      final String url = '${MainTheme.apiBaseUrl}/media/$featuredMedia';
      final resp = await http.get(Uri.parse(url));
      final mediaResponse = json.decode(resp.body);
      if (resp.statusCode == 200) {
        resourceMedia = mediaResponse['media_details']['sizes']['full']['source_url'].toString();
      } else {
        resourceMedia = MainTheme.noPhoto;
      }
    }

}