class Post {
  final String recipient;
  final String message;

  Post(this.recipient, this.message);

  Map<String, String> toJson() => {
        'recipient': this.recipient,
        'message': this.message,
      };
}
