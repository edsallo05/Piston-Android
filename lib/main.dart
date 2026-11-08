import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/database.dart';
import 'data/workshop_repository.dart';
import 'viewmodels/clients_view_model.dart';
import 'viewmodels/orders_view_model.dart';
import 'viewmodels/parts_view_model.dart';
import 'viewmodels/summary_view_model.dart';
import 'views/home_shell.dart';
import 'views/widgets/common.dart';

/// Starts the app: opens the database and builds the repository.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = WorkshopRepository(AppDatabase());
  runApp(ElPistonApp(repository: repository));
}

class ElPistonApp extends StatelessWidget {
  const ElPistonApp({super.key, required this.repository});

  final WorkshopRepository repository;

  /// Provides the repository and the ViewModels to the whole app.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WorkshopRepository>.value(value: repository),
        ChangeNotifierProvider(create: (_) => OrdersViewModel(repository)),
        ChangeNotifierProvider(create: (_) => ClientsViewModel(repository)),
        Provider(create: (_) => PartsViewModel(repository)),
        ChangeNotifierProvider(create: (_) => SummaryViewModel(repository)),
      ],
      child: MaterialApp(
        title: 'El Pistón',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: accentColor,
            surface: pageBackgroundColor,
          ),
          scaffoldBackgroundColor: pageBackgroundColor,
        ),
        home: const HomeShell(),
      ),
    );
  }
}
