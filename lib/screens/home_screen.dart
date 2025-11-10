import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';
import '../models/transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      TransactionModel('Coffee Shop', '-Rp35.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp25.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp60.000', 'Event'),
      TransactionModel('Salary', '+Rp5.000.000', 'Income'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5F3), // hijau muda lembut
      appBar: AppBar(
        title: const Text('Finance Mate'),
        centerTitle: true,
        backgroundColor: const Color(0xFF009688), // teal utama
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== My Cards ======
            const Text(
              'My Cards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  AtmCard(
                    bankName: 'Bank A',
                    cardNumber: '**** 2345',
                    balance: 'Rp12.500.000',
                    color1: Color(0xFF26A69A),
                    color2: Color(0xFF80CBC4),
                  ),
                  AtmCard(
                    bankName: 'Bank B',
                    cardNumber: '**** 8765',
                    balance: 'Rp5.350.000',
                    color1: Color(0xFF4DB6AC),
                    color2: Color(0xFFB2DFDB),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ====== Quick Access ======
            const Text(
              'Quick Access',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ====== 4 Card dengan animasi ======
            Column(
              children: [
                Row(
                  children: [
                    _animatedQuickAccess(Icons.health_and_safety, 'Health', 0),
                    const SizedBox(width: 16),
                    _animatedQuickAccess(Icons.travel_explore, 'Travel', 1),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _animatedQuickAccess(Icons.fastfood, 'Food', 2),
                    const SizedBox(width: 16),
                    _animatedQuickAccess(Icons.event, 'Event', 3),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ====== Recent Transactions ======
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: transactions[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi pembuat card dengan animasi fade + zoom + slide up
  Widget _animatedQuickAccess(IconData icon, String label, int index) {
    final delay = Duration(milliseconds: 200 * index);
    return Expanded(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 50 * (1 - value)), // geser dari bawah
              child: Transform.scale(
                scale: 0.8 + 0.2 * value, // zoom in
                child: child,
              ),
            ),
          );
        },
        child: QuickAccessCard(icon: icon, label: label),
      ),
    );
  }
}

// ===== Widget Quick Access Card =====
class QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const QuickAccessCard({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFD0F0E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF00695C), size: 36),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF004D40),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
