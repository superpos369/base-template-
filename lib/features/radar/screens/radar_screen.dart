import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/location_service.dart';

final locationProvider = ChangeNotifierProvider<LocationService>((ref) => LocationService());

class RadarScreen extends ConsumerWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Berlin Radar',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Live Position Anzeige
            Expanded(
              child: Center(
                child: location.currentPosition == null
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Aktuelle Position',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Lat: ${location.currentPosition!.latitude.toStringAsFixed(6)}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Lon: ${location.currentPosition!.longitude.toStringAsFixed(6)}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () {
                              // Echte Aktion: z. B. 3 Orte in Nähe suchen (später Firestore oder API)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Suche nach 3 echten Orten in der Nähe...')),
                              );
                            },
                            child: const Text('3 Orte finden'),
                          ),
                        ],
                      ),
              ),
            ),

            // Bottom Button Bar (Beispiel)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: () => ref.read(locationProvider).checkAndRequestPermission(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Echte Navigation zu Settings (später implementieren)
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}