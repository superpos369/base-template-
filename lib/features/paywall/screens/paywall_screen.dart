import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:go_router/go_router.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});
  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  bool _isLoading = true;
  Offerings? _offerings;

  @override
  void initState() {
    super.initState();
    _fetchOfferings();
  }

  Future<void> _fetchOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      if (mounted) setState(() { _offerings = offerings; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _purchase(Package package) async {
    try {
      final result = await Purchases.purchasePackage(package);
      
      if ((await Purchases.getCustomerInfo()).entitlements.all['pro']?.isActive ?? false) {
        if (mounted) context.go('/home');
      }
    } on PurchasesErrorCode catch (e) {
      if (e != PurchasesErrorCode.purchaseCancelledError && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kauf fehlgeschlagen')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Premium freischalten',
                style: TextStyle(fontFamily: 'Satoshi', fontSize: 32, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center),
              const SizedBox(height: 32),
              if (_offerings?.current?.annual != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _purchase(_offerings!.current!.annual!),
                    child: const Text('Jaehrlich – 3 Tage kostenlos'),
                  ),
                ),
              const SizedBox(height: 16),
              if (_offerings?.current?.monthly != null)
                TextButton(
                  onPressed: () => _purchase(_offerings!.current!.monthly!),
                  child: const Text('Monatlich fortfahren'),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  await Purchases.restorePurchases();
                  if (mounted) context.go('/home');
                },
                child: const Text('Kauf wiederherstellen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
