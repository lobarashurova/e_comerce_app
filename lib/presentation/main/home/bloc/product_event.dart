import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  final bool refresh;

  const FetchProductsEvent({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class FetchMoreProductsEvent extends ProductEvent {}

