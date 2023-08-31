import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_shopping/backend/product_repo.dart';
import 'package:wow_shopping/models/product_item.dart';

//declaring the type List<ProductItem> helped the data check referencing length of List in home_page build.
//I had forgotten to add return before await
final futureFetchTopSellingProvider =
    FutureProvider<List<ProductItem>>((ref) async {
  return await ref.read(productsRepoProvider).fetchTopSelling();
});
