import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<String> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.length >= 3) {
      setState(() {
        _isSearching = true;
        _searchResults =
            List.generate(5, (index) => 'نتيجة البحث ${index + 1}');
      });
    } else {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.search),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن المطاعم أو الأطباق',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppTheme.grey100,
              ),
              onChanged: _performSearch,
            ),
          ),

          // Search results or suggestions
          Expanded(
            child: _isSearching ? _buildSearchResults() : _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: RestaurantCard(
            name: 'مطعم ${_searchResults[index]}',
            location: 'الرياض، المملكة العربية السعودية',
            rating: 4.0 + (index * 0.1),
            deliveryTime: 20 + (index * 5),
            isHorizontal: true,
            onTap: () {
              // TODO: Navigate to restaurant details
            },
          ),
        );
      },
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اقتراحات شائعة',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'دجاج مقلي',
              'برجر',
              'بيتزا',
              'سوشي',
              'مشروبات',
              'حلويات',
            ]
                .map((suggestion) => Chip(
                      label: Text(suggestion),
                      onDeleted: () {
                        _searchController.text = suggestion;
                        _performSearch(suggestion);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
