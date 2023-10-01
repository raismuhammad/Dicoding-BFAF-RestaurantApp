import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService, required key}) {
    _fetchAllSearch(key);
  }
  
  late SearchResult _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchResult get result => _searchResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearch(key) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final search = await apiService.fetchSearch('/search?q=$key');
      if (search.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = search;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}