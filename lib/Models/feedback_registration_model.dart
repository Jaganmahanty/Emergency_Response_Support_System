// ignore_for_file: file_names, non_constant_identifier_names

class FeedbackRegistration {
  final String fid;
  final String cid;
  final String respondId;
  final String authority_id;
  final String starValue;
  final int score;
  final String serviceFulfilled;
  final String desc;
  final DateTime feedbackTime;

  FeedbackRegistration({required this.fid,
    required this.cid,
    required this.authority_id,
    required this.respondId,
    required this.starValue,
    required this.score,
    required this.serviceFulfilled,
    required this.desc,
    DateTime? feedbackTime})
      : feedbackTime = feedbackTime ?? DateTime.now();

  Map<String, dynamic> toJsonFeedback() {
    return {
      'feedback_id': fid,
      'cid': cid,
      'authority_id': authority_id,
      'response_id': respondId,
      'selectedStar': starValue,
      'score': score,
      'serviceFulfilled': serviceFulfilled,
      'description': desc,
      'sentTime': feedbackTime.toString(),
    };
  }
}
