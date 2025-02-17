class GetProductParams {
  final int? limit;
  final String? search;
  final int page;
  final int perPage;

  GetProductParams({
    this.limit,
    this.search,
    this.page = 1,
    this.perPage = 10,
  });
}
