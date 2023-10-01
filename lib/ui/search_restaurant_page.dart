import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widgets/card_search.dart';

class SearchRestaurantPage extends StatefulWidget {
  static const routeName = "/SearchRestaurantPage";

  const SearchRestaurantPage({super.key});

  @override
  State<SearchRestaurantPage> createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              TextField(
                controller: _editingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFc80064),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Search',
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 140,
                child: _editingController.text.isNotEmpty
                    ? ChangeNotifierProvider<SearchProvider>(
                        create: (context) => SearchProvider(
                              apiService: ApiService(),
                              key: _editingController.text,
                            ),
                        child: Consumer<SearchProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.loading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state.state == ResultState.hasData) {
                              if (state.result.founded != 0) {
                                return ListView.builder(
                                    itemCount: state.result.founded,
                                    itemBuilder: (BuildContext context, index) {
                                      var restaurant =
                                          state.result.restaurants[index];
                                      return CardSearch(restaurant: restaurant);
                                    });
                              } else {
                                return const Material(
                                  child: Text('No Data'),
                                );
                              }
                            } else if (state.state == ResultState.noData) {
                              return Center(
                                child: Material(
                                  child: Text(state.message),
                                ),
                              );
                            } else if (state.state == ResultState.error) {
                              return Center(
                                child: Material(
                                  child: Text('Check your connection'),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Material(
                                  child: SizedBox(),
                                ),
                              );
                            }
                          },
                        ))
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _editingController.dispose();
    super.dispose();
  }
}
