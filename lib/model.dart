import 'dart:convert';

import 'package:dataclass/dataclass.dart';

@dataClass
class Unsplash {
  final int total;
  final int total_pages;
  final List<Photo> results;

  Unsplash({this.total, this.total_pages, this.results});

  factory Unsplash.fromJson(final json) {
    return Unsplash(
        total: json["total"],
        total_pages: json["total_pages"],
        results: json["results"]
    );
  }
}

@dataClass
class Photo {
  final String id;
  final String description;
  final int likes;
  final PhotoUrl photourl;
  final User user;

  Photo({this.id, this.description, this.likes, this.photourl, this.user});

  factory Photo.fromJson(final json) {
    return Photo(
        id: json["id"],
        description: json["description"],
        likes: json["likes"],
        photourl: json["urls"],
        user: json["user"]
    );
  }
}

@dataClass
class PhotoUrl{
  final String raw;
  final String full;
  final String regular;

  PhotoUrl({this.raw, this.full, this.regular});

  factory PhotoUrl.fromJson(final json) {
    return PhotoUrl(
      raw: json["raw"],
      full: json["full"],
      regular: json["regular"]
    );
  }
}

@dataClass
class User{
  final String id;
  final String username;
  final String name;
  final String bio;
  final String location;

  User({this.id, this.username, this.name, this.bio, this.location});

  factory User.fromJson(final json) {
    return User(
      id: json["id"],
      username: json["username"],
      name: json["name"],
      bio: json["bio"],
      location: json["location"]
    );
  }
}
