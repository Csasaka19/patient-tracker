import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/controllers/recommendations_controller.dart';
import 'package:patient_tracker/models/recommendations-model.dart';


RecommendationController recommendationController = Get.put(RecommendationController());

class RecommendationPage extends StatefulWidget {
  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  bool _isLoading = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          "http://acs314flutter.xyz/Patient-tracker/get_recommendation.php?user_id=1"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        var recommendationsData = serverResponse['recommendations'];
        var recommendationList = recommendationsData
            .map<Recommendation>(
                (recommendation) => Recommendation.fromJson(recommendation))
            .toList();
        recommendationController.updateRecommendations(recommendationList);
      } else {
        throw Exception('Failed to load recommendations from API');
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
      _showErrorSnackBar();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackBar() {
    Get.snackbar(
      'Error',
      'Failed to fetch recommendations. Please try again later.',
      backgroundColor: pinkColor,
      colorText: appbartextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: const Text('Your Recommendations',
            style: TextStyle(color: appbartextColor)),
        backgroundColor: blackColor,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search for your recommendations...",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: appbartextColor,
                      ),
                      suffixIcon: const Icon(
                        Icons.filter_list,
                        color: appbartextColor,
                      ),
                      filled: true,
                      fillColor: appbartextColor.withOpacity(0.3),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildRecommendationListView()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchRecommendations,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
        backgroundColor: appbartextColor,
      ),
    );
  }

  Widget _buildRecommendationListView() {
    return Obx(() {
      if (recommendationController.recommendations.isEmpty) {
        return const Center(
          child: Text(
            'No recommendations available',
            style: TextStyle(color: appbartextColor),
          ),
        );
      } else {
        var displayedRecommendations = recommendationController.recommendations
            .where((recommendation) =>
                recommendation.description.contains(_searchText))
            .toList();

        return ListView.builder(
          itemCount: displayedRecommendations.length,
          itemBuilder: (context, index) {
            return _buildRecommendationCard(
                index, displayedRecommendations as List<Recommendation>);
          },
        );
      }
    });
  }

  Widget _buildRecommendationCard(
      int index, List<Recommendation> recommendations) {
    final recommendation = recommendations[index];
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'Recommendation ID: ${recommendation.id}',
              style: const TextStyle(color: appbartextColor),
            ),
            Text(
              'Recommendation Date: ${recommendation.recommendation_date}',
              style: const TextStyle(color: appbartextColor),
            ),
            Text(
              'Recommendation Description: ${recommendation.description}',
              style: const TextStyle(color: appbartextColor),
            ),
          ],
        ),
      ),
    );
  }
}
