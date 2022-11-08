class UserModal {
  final String? email;
  final String? id;
  final String? name;
  final PictureModal? pictureModal;

  UserModal({this.email, this.id, this.name, this.pictureModal});

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        email: json["email"],
        id: json["id"] as String,
        name: json["name"],
        pictureModal: PictureModal.fromJson(
          json["picture"]["data"],
        ),
      );
}

class PictureModal {
  final int? height;
  final int? width;
  final String? url;

  PictureModal({this.height, this.width, this.url});

  factory PictureModal.fromJson(Map<String, dynamic> json) => PictureModal(
        height: json["height"],
        width: json["width"],
        url: json["url"],
      );
}
