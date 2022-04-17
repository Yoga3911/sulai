class StatusModel {
    StatusModel({
        required this.id,
        required this.status,
    });

    final String id;
    final String status;

    factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        id: json["id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
    };
}
