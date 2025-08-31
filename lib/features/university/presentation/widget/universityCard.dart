import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/app_router.dart';

class UniversityCard extends StatelessWidget {
  final String id; // Add ID
  final String name;
  final String location;
  final String type;
  final bool featured;
  final String? imageUrl;
  final int programsCount;
  final double startingPrice;

  const UniversityCard({
    super.key,
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.featured,
    this.imageUrl,
    required this.programsCount,
    required this.startingPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImage(), _buildInfoSection()],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    // Build the path manually with the university ID
    context.go('/universities/$id');
  }

  Widget _buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Image.network(
            imageUrl ??
                'https://images.unsplash.com/photo-1565372919713-90d3c3e2e40e?auto=format&fit=crop&w=800&q=80',
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildFallbackImage(),
          ),
        ),
        if (featured)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.4),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                '⭐ FEATURED',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.red),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [_buildTypeBadge(), const Spacer(), _buildProgramsInfo()],
          ),
          const SizedBox(height: 10),
          _buildPriceContainer(),
        ],
      ),
    );
  }

  Widget _buildTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getTypeColor(type).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: _getTypeColor(type),
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildProgramsInfo() {
    return Row(
      children: [
        const Icon(Icons.menu_book, size: 14, color: Colors.blue),
        const SizedBox(width: 4),
        Text(
          '$programsCount+ Programs',
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPriceContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'ETB ${startingPrice.toStringAsFixed(0)} 💰',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      height: 140,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.account_balance, size: 40, color: Colors.grey),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'public':
        return const Color(0xFF10B981);
      case 'private':
        return const Color(0xFFEF4444);
      case 'featured':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6366F1);
    }
  }
}
