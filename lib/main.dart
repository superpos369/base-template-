import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'services/location_service.dart';
import 'features/radar/screens/radar_screen.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final locationService = LocationService();
  await locationService.checkAndRequestPermission();

  runApp(
    const ProviderScope(
      child: BaseTemplateApp(),
    ),
  );
}

class BaseTemplateApp extends ConsumerWidget {
  const BaseTemplateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Base Template',
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const RadarScreen(),
      ),
    ],
  );
});
