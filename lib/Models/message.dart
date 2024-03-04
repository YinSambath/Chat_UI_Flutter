class ChatDataModel {
  List<ChatModel>? data;

  ChatDataModel({this.data});

  factory ChatDataModel.fromJson(Map<String, dynamic> json) {
    return ChatDataModel(
      data: json['data'] == null || json['data'] == null
          ? []
          : (json['data'] as List).map((e) => ChatModel.fromJson(e)).toList(),
    );
  }
}

class ChatModel {
  String id;
  List<MessageModel>? message;
  String person1Name;
  String person2Name;
  String person1Id;
  String person2Id;
  dynamic v;

  ChatModel({
    required this.id,
    this.message,
    required this.person1Name,
    required this.person2Name,
    required this.person1Id,
    required this.person2Id,
    this.v,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json['_id'],
        message: (json['message'] as List?)
                ?.map((e) => MessageModel.fromJson(e))
                .toList() ??
            [],
        person1Name: json['person1Name'],
        person2Name: json['person2Name'],
        person1Id: json['person1Id'],
        person2Id: json['person2Id'],
        v: json.containsKey('__v') ? json['__v'] : null // Parse __v as int
        );
  }
}

class MessageModel {
  String senderId;
  String? message;
  String? image;
  String? sentAt;

  MessageModel({
    required this.senderId,
    this.message,
    this.image,
    this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> message) {
    return MessageModel(
      senderId: message['senderId'],
      message: message['message'],
      image: message['image'],
      sentAt: message['sentAt'],
    );
  }
}
