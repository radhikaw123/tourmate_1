import 'package:flutter/material.dart';
import 'package:tourmate_app/routes/app_routes.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  List<Map<String, dynamic>> savedDestinations = [];

  String location = '';
  String date = '';
  int people = 0;

  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();

  @override
  void dispose() {
    locationController.dispose();
    dateController.dispose();
    peopleController.dispose();
    super.dispose();
  }

  void _saveDestination() {
    if (location.isNotEmpty && date.isNotEmpty && people > 0) {
      setState(() {
        savedDestinations.add({
          'location': location,
          'date': date,
          'people': people,
        });
        // Clear fields after saving
        location = '';
        date = '';
        people = 0;
        locationController.clear();
        dateController.clear();
        peopleController.clear();
      });
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        date = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        dateController.text = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F3),
      appBar: AppBar(
        title: const Text('Destinations'),
        backgroundColor: const Color(0x000598a8),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.display,
                arguments: savedDestinations,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Display', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _destinationCard('Tokyo', 'assets/images/tokyo_land.jpg'),
                _destinationCard('Paris', 'assets/images/paris_page.jpg'),
                _destinationCard('New York', 'assets/images/newyork.png'),
              ],
            ),
            const SizedBox(height: 30),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_ios, size: 16),
                SizedBox(width: 8),
                Text(
                  '1/50',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.orange),
              ],
            ),

            const SizedBox(height: 30),

            // Input Fields
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'Location',
                          hintText: 'Where are you going',
                          controller: locationController,
                          onChanged: (value) => location = value,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildInputField(
                          label: 'Date',
                          hintText: 'When you will go',
                          controller: dateController,
                          readOnly: true,
                          onTap: _pickDate,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildInputField(
                          label: 'People',
                          hintText: 'Select people',
                          controller: peopleController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            people = int.tryParse(value) ?? 0;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _saveDestination,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _destinationCard(String city, String imagePath) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          city,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black12,
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function()? onTap,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF2F2F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
