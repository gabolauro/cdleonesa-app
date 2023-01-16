import 'dart:convert';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:http/http.dart' as http;

import 'package:html_unescape/html_unescape.dart';

News? newsFromJson(String str) => News.fromJson(json.decode(str));

List<News>? newsListFromJson(String str) => json.decode(str) == null ? [] : List<News>.from(json.decode(str)!.map((x) => News.fromJson(x)));


String newsToJson(News? data) => json.encode(data!.toJson());


class News {
    News({
        required this.id,
        this.date,
        this.status,
        this.link,
        this.title,
        this.content,
        this.author,
        this.featuredMedia,
        this.resourceMedia,
        this.format,
        this.categories,
    });

    int id;
    DateTime? date;
    String? status;
    String? link;
    String? title;
    String? content;
    int? author;
    int? featuredMedia;
    String? resourceMedia;
    String? format;
    List<int?>? categories;

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        link: json["link"],
        title: HtmlUnescape().convert(json["title"]["rendered"]),
        content: formatParagraphs(json["content"]["rendered"]),
        author: json["author"],
        featuredMedia: json["featured_media"],
        format: json["format"],
        categories: json["categories"] == null ? [] : List<int?>.from(json["categories"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date?.toIso8601String(),
        "status": status,
        "link": link,
        "title": title,
        "content": content,
        "author": author,
        "featured_media": featuredMedia,
        "format": format,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    };

    static String formatParagraphs(String content) {
      content = content.replaceAll('<p>', '');
      content = content.replaceAll('</p>', '');
      content = HtmlUnescape().convert(content);
      return content;
    }

    getMedia() async {
      final String url = '${MainTheme.apiBaseUrl}/media/$featuredMedia';
      final resp = await http.get(Uri.parse(url));
      final mediaResponse = json.decode(resp.body);
      resourceMedia = mediaResponse['media_details']['sizes']['medium']['source_url'].toString();
    }

}
