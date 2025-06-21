import 'package:flutter/material.dart';

class FinancialTipsScreen extends StatelessWidget {
  const FinancialTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.attach_money, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text('Money Bestie', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bestie's Top Tips",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Your Go-To Guide for Smart, Savy Financial Moves",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: [
                  _buildTipCard(
                    "How can I ensure long-term financial security?",
                    Colors.orange.shade200,
                    Icons.security,
                  ),
                  _buildTipCard(
                    "How can I negotiate a higher salary?",
                    Colors.red.shade200,
                    Icons.trending_up,
                  ),
                  _buildTipCard(
                    "What are the best investment options for beginners?",
                    Colors.blue.shade200,
                    Icons.show_chart,
                  ),
                  _buildTipCard(
                    "Best strategies for building wealth?",
                    Colors.purple.shade200,
                    Icons.account_balance_wallet,
                  ),
                  _buildTipCard(
                    "How can I achieve financial independence?",
                    Colors.yellow.shade200,
                    Icons.emoji_events,
                  ),
                  _buildTipCard(
                    "How much should I save each month?",
                    Colors.green.shade200,
                    Icons.savings,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'Track'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Play'),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, Color color, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          // color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                height: 1.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 