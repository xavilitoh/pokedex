

import 'convert.dart';

class Common {
  int? count;
  String? next;
  String? previous;
  List<NamedAPIResource>? results;

  Common({count, next, previous, results});

  Common.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results =  <NamedAPIResource>[];
      json['results'].forEach((v) {
        results!.add( NamedAPIResource.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'CommonDAO{count: $count, next: $next, previous: $previous, results: $results}';
  }
}

class NamedAPIResource {
  String? name;
  String? url;
  String? id;
  String? category;

  NamedAPIResource({name, url});

  NamedAPIResource.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    id = Converter.urlToId(url!);
    category = Converter.urlToCat(url!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  @override
  String toString() {
    return 'NamedAPIResource{name: $name, url: $url, id: $id, category: $category}';
  }
}


class Version {
  String? name;
  String? url;

  Version({name, url});

  Version.fromJson(Map<String, dynamic> json) {   
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }

  @override
  String toString() {
    return '$name';
  }
}
