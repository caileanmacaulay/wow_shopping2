import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:wow_shopping/features/wishlist/widgets/wishlist_item.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'wishlist_item_state.dart';

class WishlistItemCubit extends Cubit<WishlistItemState> {
  final WishlistBloc wishListBloc;
  final WishlistItem item;

  WishlistItemCubit(
      {required WishlistBloc wishlistBloc,
      required WishlistItem item,
      required BuildContext context})
      : wishListBloc = wishlistBloc,
        item = item,
        super(WishlistItemState(
            isSelected: context.wishlistRepo.isInWishlist(item.item)));

  void isSelected(ProductItem item) {
    var isSelected = wishListBloc.selectedItems.contains(item.id);
    emit(WishlistItemState(isSelected: isSelected));
  }

  void setSelected(bool selected) {
    ProductItem productItem = item.item;
    if (selected) {
      wishListBloc.selectedItems.add(productItem.id);
    } else {
      wishListBloc.selectedItems.remove(productItem.id);
    }
    emit(WishlistItemState(isSelected: !selected));
  }

  void toggleSelected() {
    bool isSelected = wishListBloc.selectedItems.contains(item.item.id);
    bool toggleSelected = !isSelected;
    setSelected(toggleSelected);
  }
}
