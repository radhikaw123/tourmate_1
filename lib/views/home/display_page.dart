import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  final List<Map<String, dynamic>> destinations;

  const DisplayPage({super.key, required this.destinations});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  late List<Map<String, dynamic>> _destinations;

  @override
  void initState() {
    super.initState();
    // Directly use the widget.destinations list reference (no copy)
    _destinations = widget.destinations;
  }

  void _updateDestination(int index) async {
    TextEditingController locationController = TextEditingController(
      text: _destinations[index]['location'] ?? '',
    );
    TextEditingController dateController = TextEditingController(
      text: _destinations[index]['date'] ?? '',
    );
    TextEditingController peopleController = TextEditingController(
      text: _destinations[index]['people']?.toString() ?? '0',
    );

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Update Destination'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: peopleController,
                    decoration: const InputDecoration(
                      labelText: 'Number of People',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _destinations[index]['location'] = locationController.text;
                    _destinations[index]['date'] = dateController.text;
                    _destinations[index]['people'] =
                        int.tryParse(peopleController.text) ?? 0;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
    );
  }

  void _deleteDestination(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Deletion'),
            content: const Text(
              'Are you sure you want to delete this destination?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmDelete) {
      setState(() {
        _destinations.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Destinations')),
      body:
          _destinations.isEmpty
              ? const Center(
                child: Text(
                  'No destinations available.',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: _destinations.length,
                itemBuilder: (context, index) {
                  final destination = _destinations[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(destination['location'] ?? 'Unnamed'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${destination['date'] ?? 'No date'}'),
                          Text('People: ${destination['people'] ?? 0}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _updateDestination(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteDestination(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
