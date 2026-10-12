import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/number_formatter.dart';
import '../../data/models/transaction_stats_model.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final TransactionStatsModel? stats;
  final bool isLoading;
  final String? error;
  final VoidCallback onRefresh;

  const TransactionCard({
    super.key,
    required this.title,
    required this.stats,
    required this.isLoading,
    required this.error,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: .circular(8)),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildContent(),
          const SizedBox(height: 0),
          _buildNote(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const .symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: .vertical(top: .circular(8)),
        border: Border(
          bottom: BorderSide(color: AppColors.accentBlue, width: 2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: AppColors.accentBlue,
                fontSize: 14,
                fontWeight: .w700,
              ),
            ),
          ),
          Container(
            width: 35,
            height: 35,
            decoration: const BoxDecoration(
              color: Color(0xFFC8E5F8),
              shape: .circle,
            ),
            child: IconButton(
              onPressed: isLoading ? null : onRefresh,
              icon: isLoading && stats != null
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.accentBlue,
                      ),
                    )
                  : const Icon(
                      Icons.refresh,
                      color: AppColors.accentBlue,
                      size: 18,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading && stats == null) {
      return _buildLoading();
    }

    if (error != null && stats == null) {
      return _buildError();
    }

    if (stats == null) {
      return _buildEmpty();
    }

    return _buildTable(stats!);
  }

  Widget _buildLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const SizedBox(height: 8),

          _buildShimmerRow(),
          _buildShimmerRow(),
          _buildShimmerRow(),
          _buildShimmerRow(),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildShimmerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Container(height: 18, color: Colors.white)),
          const SizedBox(width: 20),
          Expanded(flex: 3, child: Container(height: 18, color: Colors.white)),
          const SizedBox(width: 20),
          Expanded(flex: 3, child: Container(height: 18, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Padding(
      padding: const .symmetric(vertical: 10),
      child: Column(
        children: [
          Text(error!),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentBlue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const Padding(padding: .all(20), child: Text('No data available.'));
  }

  Widget _buildTable(TransactionStatsModel model) {
    return Column(
      children: [
        _buildTableHeader(),
        const Divider(),
        _buildRow(
          label: 'Total',
          count: model.data.total,
          amount: model.data.totalAmount,
          showBottomLine: true,
        ),
        _buildRow(
          label: 'This Year',
          count: model.data.totalThisYear,
          amount: model.data.totalThisYearAmount,
          showBottomLine: true,
        ),
        _buildRow(
          label: 'This Month',
          count: model.data.totalThisMonth,
          amount: model.data.totalThisMonthAmount,
          showBottomLine: true,
        ),
        _buildRow(
          label: 'Today',
          count: model.data.totalToday,
          amount: model.data.totalTodayAmount,
          showBottomLine: false,
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const .symmetric(horizontal: 10),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('', style: TextStyle(fontWeight: .bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '#',
              textAlign: .right,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 12,
                fontWeight: .w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Amount',
              textAlign: .right,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 12,
                fontWeight: .w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    required int count,
    required String amount,
    required bool showBottomLine,
  }) {
    return Container(
      padding: const .symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        border: showBottomLine
            ? Border(bottom: BorderSide(color: AppColors.divider, width: 1))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 12,
                fontWeight: .bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: .scaleDown,
              alignment: .centerRight,
              child: Text(
                formatCount(count),
                textAlign: .right,
                style: const TextStyle(color: AppColors.text, fontSize: 12),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              formatAmount(amount),
              textAlign: .right,
              style: const TextStyle(color: AppColors.text, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNote() {
    return Container(
      width: .infinity,
      padding: const .symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: .vertical(bottom: .circular(8)),
      ),
      child: const Text(
        'NOTE: C: Crore, L: Lacs',
        textAlign: .center,
        style: TextStyle(
          color: AppColors.text,
          fontSize: 10,
          fontWeight: .w700,
        ),
      ),
    );
  }
}
