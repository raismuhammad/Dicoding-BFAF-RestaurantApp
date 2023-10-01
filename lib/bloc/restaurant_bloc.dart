import 'package:bloc/bloc.dart';
import 'package:restaurant_app/bloc/restaurant_event.dart';
import 'package:restaurant_app/bloc/restaurant_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';


class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  ApiService apiService = ApiService();

  RestaurantBloc() : super(RestaurantInitial());
}