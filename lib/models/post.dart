class Post {
  final String recipient;
  final String sender;
  final String message;
  final String imageUrl;

  Post(this.sender, this.recipient, this.message, this.imageUrl);

  Map<String, String> toJson() => {
        'sender': sender,
        'recipient': recipient,
        'message': message,
        'imageUrl': imageUrl,
      };
}
