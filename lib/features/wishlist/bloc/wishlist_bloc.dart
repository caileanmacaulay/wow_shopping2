import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wow_shopping/backend/backend.dart';
import 'package:wow_shopping/models/product_item.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepo wishlistRepo;

  final wishlistItems = <ProductItem>[];
  final selectedItems = <String>{};

//================= should this be a per item cubit? ===========
  bool isSelected(ProductItem item) {
    return selectedItems.contains(item.id);
  }

  void setSelected(ProductItem item, bool selected) {
    if (selected) {
      selectedItems.add(item.id);
    } else {
      selectedItems.remove(item.id);
    }
  }
  //============================

  WishlistBloc({required WishlistRepo wishlistRepo})
      : this.wishlistRepo = wishlistRepo,
        super(WishlistInitial()) {
    // on<ToggleWishlist>(_onToggleWishlist);
    on<ClearWishlist>(_onClearWishlist);
    on<ToggleSelectAllWishlist>(_onToggleSelectAllWishlist);
    on<RemoveSelectedWishlist>(_onRemoveSelectedWishlist);
    //on<IsProductInWishlist>(_onIsProductInWishlist);
  }

  // void _onIsProductInWishlist(
  //   IsProductInWishlist event,
  //   Emitter<WishlistState> emit,
  // ) async {
  //   ProductItem item = event.item;
  //   bool isProductInSelectedItems = selectedItems.contains(item.id);
  //   emit(WishlistMember(isProductInSelectedItems));
  // }

  void _onRemoveSelectedWishlist(
    RemoveSelectedWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    for (final selected in selectedItems) {
      wishlistRepo.removeToWishlist(selected);
    }
    selectedItems.clear();
    emit(WishlistSelection(productIds: selectedItems));
  }

  void _onToggleSelectAllWishlist(
    ToggleSelectAllWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    final allIds = wishlistItems.map((el) => el.id).toList();
    if (selectedItems.containsAll(allIds)) {
      selectedItems.clear();
    } else {
      selectedItems.addAll(allIds);
    }
    emit(WishlistSelection(productIds: selectedItems));
  }

  void _onClearWishlist(
    ClearWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    for (final selected in selectedItems) {
      wishlistRepo.removeToWishlist(selected);
    }
    selectedItems.clear();
    emit(WishlistSelection(productIds: selectedItems));
  }

  // void _onToggleWishlist(
  //   ToggleWishlist event,
  //   Emitter<WishlistState> emit,
  // ) async {
  //   if (event.isSelected) {
  //     selectedItems.add(event.item.id);
  //   } else {
  //     selectedItems.remove(event.item.id);
  //   }
  //   emit(WishlistSelection(productIds: selectedItems));
  //}
}
