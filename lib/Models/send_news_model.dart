// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types

class News_Registration {
  final String news_Id;
  final String news_image;
  final String news_title;
  final String news_desc;
  final DateTime sentTime;

  News_Registration(
      {required this.news_Id,
      required this.news_image,
        required this.news_title,
        required this.news_desc,
      DateTime? sentTime})
      : sentTime = sentTime ?? DateTime.now();

  Map<String, dynamic> toJsonNews() {
    return {
      'news_id': news_Id,
      'news_image': news_image,
      'news_title': news_title,
      'news_description': news_desc,
      'sentTime': sentTime.toString(),
    };
  }
}
