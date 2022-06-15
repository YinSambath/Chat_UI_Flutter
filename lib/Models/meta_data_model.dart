// class LinkModel {
//   LinkModel({
//     this.first,
//     this.last,
//     this.prev,
//     this.next,
//   });

//   final String? first;
//   final String? last;
//   final String? prev;
//   final String? next;

//   factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
//         first: json["first"],
//         last: json["last"],
//         prev: json["prev"],
//         next: json["next"],
//       );
// }

class MetaModel {
  MetaModel({
    this.page,
    this.prevPage,
    this.nextPage,
    this.limit,
  });

  final int? page;
  final int? prevPage;
  final int? nextPage;
  final int? limit;

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        page: json["page"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
        limit: json["limit"],
      );
}
