import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpp_assignment/core/utils/date_formatter.dart';

import '../../core/theme/app_colors.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TransactionProvider>();

      provider.loadAll();
      provider.startAutoRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ColoredBox(
          color: AppColors.navy,
          child: Padding(
            padding: const .symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const SizedBox(height: 24),

                Text(
                  'RAJASTHAN PAYMENT PORTAL',
                  style: TextStyle(
                    color: AppColors.accentBlue,
                    fontSize: 11,
                    fontWeight: .w700,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'A Comprehensive Suite of Payment Solution',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: .w700,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return context.read<TransactionProvider>().loadAll();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Consumer<TransactionProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            children: [
                              if (provider.lastUpdated != null)
                                Padding(
                                  padding: const .symmetric(horizontal: 24),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      formatLastUpdated(provider.lastUpdated),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),

                              TransactionCard(
                                title: 'Collection E-Transactions',
                                stats: provider.collection,
                                isLoading: provider.collectionLoading,
                                error: provider.collectionError,
                                onRefresh: provider.loadCollection,
                              ),
                              const SizedBox(height: 10),
                              TransactionCard(
                                title: 'Disbursement E-Transactions',
                                stats: provider.disbursement,
                                isLoading: provider.disbursementLoading,
                                error: provider.disbursementError,
                                onRefresh: provider.loadDisbursement,
                              ),

                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
