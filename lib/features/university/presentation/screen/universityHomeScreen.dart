import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/university/presentation/bloc/university_bloc.dart';
import 'package:mobile/features/university/presentation/bloc/university_event.dart';
import 'package:mobile/features/university/presentation/bloc/university_state.dart';
import 'package:mobile/features/university/presentation/widget/universityCard.dart';

class UniversityHomeScreen extends StatefulWidget {
  const UniversityHomeScreen({super.key});

  @override
  State<UniversityHomeScreen> createState() => _UniversityHomeScreenState();
}

class _UniversityHomeScreenState extends State<UniversityHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    context.read<UniversityBloc>().add(LoadFeaturedUniversities());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 140.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Exam Bank',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    letterSpacing: 0.5,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.filter_list_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Filter functionality
                  },
                ),
              ],
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search universities...',
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 16.0,
                    ),
                  ),
                  onChanged: (value) {
                    // Implement search functionality
                  },
                ),
              ),
              const SizedBox(height: 16.0),

              // Categories
              SizedBox(
                height: 42.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('All', Icons.all_inclusive),
                    _buildCategoryChip('Public', Icons.account_balance),
                    _buildCategoryChip('Private', Icons.business),
                    _buildCategoryChip('Featured', Icons.star),
                    _buildCategoryChip('Affordable', Icons.attach_money),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // University List
              Expanded(
                child: BlocBuilder<UniversityBloc, UniversityState>(
                  builder: (context, state) {
                    if (state is UniversityLoading) {
                      return _buildLoadingState();
                    }

                    if (state is UniversityError) {
                      return _buildErrorState(context, state.message);
                    }

                    if (state is UniversityLoaded) {
                      final universities = state.universities;

                      if (universities.isEmpty) {
                        return _buildEmptyState();
                      }

                      return GridView.builder(
                        itemCount: universities.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 0.72,
                            ),
                        itemBuilder: (context, index) {
                          final uni = universities[index];
                          return UniversityCard(
                            name: uni.name,
                            location: uni.location,
                            type: uni.type,
                            featured: uni.featured,
                            imageUrl: uni.imageUrl,
                            programsCount: uni.programsCount ?? 50,
                            startingPrice: uni.startingPrice ?? 15000,
                            id: uni.id,
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String title, IconData icon) {
    final isSelected = _selectedCategory == title;
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(title),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? title : 'All';
          });
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF6366F1),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: FontWeight.w500,
          fontSize: 13.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        side: BorderSide(
          color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
          width: 1.0,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
            strokeWidth: 3.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Loading Universities...',
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64.0,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                context.read<UniversityBloc>().add(LoadFeaturedUniversities());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 64.0, color: Colors.grey[400]),
          const SizedBox(height: 16.0),
          Text(
            'No universities found',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Try adjusting your search or filter',
            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
