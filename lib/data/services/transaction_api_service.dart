import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/transaction_stats_model.dart';

class TransactionApiService {
  final Dio dio;

  TransactionApiService(this.dio);

  Future<TransactionStatsModel> getCollectionStats() async {
    final response = await dio.post(ApiConstants.collectionEndpoint);

    final responseModel = TransactionStatsModel.fromJson(
      response.data as Map<String, dynamic>,
    );
    // debugPrint('Response of coll - ${responseModel.data.total}');

    return responseModel;
  }

  Future<TransactionStatsModel> getDisbursementStats() async {
    final response = await dio.post(ApiConstants.disbursementEndpoint);

    final responseModel = TransactionStatsModel.fromJson(
      response.data as Map<String, dynamic>,
    );
    // debugPrint('Response of disb - ${responseModel.data}');

    return responseModel;
  }
}
