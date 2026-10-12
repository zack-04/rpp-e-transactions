import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpp_assignment/presentation/screens/splash_screen.dart';

import 'core/network/dio_client.dart';
import 'data/repositories/transaction_repository.dart';
import 'data/services/transaction_api_service.dart';
import 'presentation/providers/transaction_provider.dart';

void main() {
  final dio = DioClient.create();
  final apiService = TransactionApiService(dio);
  final repository = TransactionRepository(apiService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionProvider(repository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RPP E-Transactions',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
