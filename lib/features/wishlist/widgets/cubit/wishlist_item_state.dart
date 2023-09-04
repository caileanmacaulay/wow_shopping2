part of 'wishlist_item_cubit.dart';

@immutable
class WishlistItemState {
  final bool isSelected;

  const WishlistItemState({required this.isSelected});
}

class WishlistItemStateInitial extends WishlistItemState {
  WishlistItemStateInitial() : super(isSelected: false);
}
