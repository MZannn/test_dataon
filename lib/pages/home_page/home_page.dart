import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.fetchUniversities(reset: true);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          homeViewModel.fetchUniversities();
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final universities = homeViewModel.universities;
    final searchResults = homeViewModel.searchResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: homeViewModel.searchUniversities,
                      decoration: const InputDecoration(
                        hintText: "Search University",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.search),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: searchResults.isNotEmpty
                  ? searchResults.length
                  : universities.length,
              itemBuilder: (context, index) {
                final university = searchResults.isNotEmpty
                    ? searchResults[index]
                    : universities[index];

                // Check if we are near the end of the list and fetch more data
                if (index == universities.length - 1) {
                  if (!homeViewModel.isLoading) {
                    homeViewModel.fetchUniversities();
                  }
                }

                return ListTile(
                  title: Text(university.name),
                  subtitle: Text(university.country),
                );
              },
            ),
            if (homeViewModel.isLoading)
              Center(child: CircularProgressIndicator())
            else if (universities.isEmpty && searchResults.isEmpty)
              const Center(child: Text("No data available")),
          ],
        ),
      ),
    );
  }
}
