import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/parts_view_model.dart';
import 'clients_screen.dart';
import 'orders_screen.dart';
import 'parts_screen.dart';
import 'summary_screen.dart';

/// Main screen: the four tabs and the bottom navigation bar.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int selectedIndex = 0;

  final List<Widget> tabs = const [
    OrdersScreen(),
    ClientsScreen(),
    PartsScreen(),
    SummaryScreen(),
  ];

  /// Builds the selected tab and the navigation bar.
  @override
  Widget build(BuildContext context) {
    final partsViewModel = context.read<PartsViewModel>();

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (newIndex) => setState(() => selectedIndex = newIndex),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Órdenes',
          ),
          const NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Clientes',
          ),
          NavigationDestination(
            icon: StreamBuilder<int>(
              stream: partsViewModel.lowStockCount,
              builder: (context, snapshot) {
                final lowStockCount = snapshot.data ?? 0;
                return Badge(
                  isLabelVisible: lowStockCount > 0,
                  label: Text('$lowStockCount'),
                  child: const Icon(Icons.inventory_2_outlined),
                );
              },
            ),
            selectedIcon: const Icon(Icons.inventory_2),
            label: 'Repuestos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Resumen',
          ),
        ],
      ),
    );
  }
}
