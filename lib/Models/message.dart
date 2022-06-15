class Message {
  String message;
  String senderUsername;
  String senderId;
  String sentAt;
  String targetId;

Message({
  required this.senderId,
  required this.message,
  required this.senderUsername,
  required this.sentAt,
  required this.targetId
});

factory Message.fromJson(Map<String, dynamic> message) {
  return Message(
    message: message['message'], 
    senderUsername: message['senderUsername'], 
    senderId: message['senderId'],
    sentAt: message['sentAt'], 
    targetId: message['targetId'],
  );
}

}