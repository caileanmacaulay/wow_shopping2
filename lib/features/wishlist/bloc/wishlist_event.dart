part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

final class ToggleWishlist extends WishlistEvent {
  final bool isSelected;
  final ProductItem item;

  ToggleWishlist(this.item, this.isSelected);
}

final class ClearWishlist extends WishlistEvent {}

final class RemoveSelectedWishlist extends WishlistEvent {}

final class ToggleSelectAllWishlist extends WishlistEvent {}

// final class IsProductInWishlist extends WishlistEvent {
//   final ProductItem item;

//   IsProductInWishlist({required this.item});
// }
