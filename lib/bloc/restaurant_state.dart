import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState{}

class RestaurantLoadingProgress extends RestaurantState{}

class RestaurantLoadingSuccess extends RestaurantState{
  final List<Restaurant> listRestaurant;

  RestaurantLoadingSuccess(this.listRestaurant);
}

class RestaurantLoadingFailure extends RestaurantState{}

class REstaurantEmptyData extends RestaurantState{}