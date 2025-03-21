class QuestionModel {
  String question;
  List<String> options = [];
  int? answerIndex;

  QuestionModel({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}
