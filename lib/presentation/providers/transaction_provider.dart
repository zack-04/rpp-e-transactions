import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/transaction_stats_model.dart';
import '../../data/repositories/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository repository;

  TransactionProvider(this.repository);

  TransactionStatsModel? collection;
  TransactionStatsModel? disbursement;

  bool collectionLoading = false;
  bool disbursementLoading = false;

  String? collectionError;
  String? disbursementError;

  DateTime? lastUpdated;

  Timer? _refreshTimer;

  Future<void> loadAll() async {
    // debugPrint('Loading all in 60secs');
    await Future.wait([loadCollection(), loadDisbursement()]);
    if (collection != null || disbursement != null) {
      lastUpdated = DateTime.now();
      notifyListeners();
    }
  }

  Future<void> loadCollection() async {
    collectionLoading = true;
    collectionError = null;
    notifyListeners();

    try {
      collection = await repository.getCollectionStats();
    } catch (_) {
      collectionError = 'Unable to load collection data.';
    } finally {
      collectionLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDisbursement() async {
    disbursementLoading = true;
    disbursementError = null;
    notifyListeners();

    try {
      disbursement = await repository.getDisbursementStats();
    } catch (_) {
      disbursementError = 'Unable to load disbursement data.';
    } finally {
      disbursementLoading = false;
      notifyListeners();
    }
  }

  void startAutoRefresh() {
    _refreshTimer?.cancel();

    _refreshTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      loadAll();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
