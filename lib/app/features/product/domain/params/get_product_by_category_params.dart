class GetProductByCategoryParams {
  final String category;
  final int? limit;
  final String? search;
  final int page;
  final int perPage;

  GetProductByCategoryParams({
    required this.category,
    this.limit,
    this.search,
    this.page = 1,
    this.perPage = 10,
  });
}
