class Storage {
  final String id;
  final String url;
  final String filename;

  Storage({
    required this.id,
    required this.url,
    required this.filename,
  });

  // Factory constructor to create a Storage instance from a JSON map
  factory Storage.fromJson(Map<String, dynamic> json){
    return Storage(
      id: json['_id'],
      url:json['url'],
      filename: json ['filename']
    );
  }

  // Method to convert a Storage instance to a JSON map
  Map<String, dynamic> toJson(){
    return {
      'url':url,
      'filename':filename
    };
  }
}