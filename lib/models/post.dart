class Post {
  final String recipient;
  final String message;
  final String imageUrl;

  Post(this.recipient, this.message, this.imageUrl);

  Map<String, String> toJson() => {
        'recipient': this.recipient,
        'message': this.message,
        'imageUrl': this.imageUrl,
      };
}
