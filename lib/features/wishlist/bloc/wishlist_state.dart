part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {
  final Set<String> productIds = {};

  WishlistInitial();
}

final class WishlistSelection extends WishlistState {
  final Set<String> productIds;

  WishlistSelection({required this.productIds});
}
