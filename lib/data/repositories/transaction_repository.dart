import '../models/transaction_stats_model.dart';
import '../services/transaction_api_service.dart';

class TransactionRepository {
  final TransactionApiService apiService;

  TransactionRepository(this.apiService);

  Future<TransactionStatsModel> getCollectionStats() {
    return apiService.getCollectionStats();
  }

  Future<TransactionStatsModel> getDisbursementStats() {
    return apiService.getDisbursementStats();
  }
}
