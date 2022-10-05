import 'package:financial_ratios/Helpers/profile_controller.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/asset_turnover_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/average_days_inventory_in_stock_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/average_days_payables_oustanding_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/average_ppe_age_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/average_ppe_useful_life_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/average_receivables_collection_day_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/fixed_asset_turnover_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/inventory_turnover_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/net_trade_cycle_or_cash_cycle_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/opetating_cycle_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/payables_turnover_widger.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/receivible_turnover_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/activity/working_capital_turnover_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/liquidity/cach_ratio_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/liquidity/cfo_ratio_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/liquidity/defensive_interval_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/liquidity/quickRatiosWidget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/liquidity/woking_capital_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/cash_return_on_assets_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/dividend_payout_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/dividend_yield_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/earnings_per_share_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/market_to_book_ratio_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/operating_margin_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/gross_profit_margin_on_sales_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/net_profite_margin_on_sales.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/price_earnings_ratio_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/return_on_asset_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/return_on_equity.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/profitability/return_on_invested_widgert.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/book_value_per_share_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/cash_flow_adequacy_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/cfo_to_debt_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/cfo_to_interest_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/cfo_to_operating_earnings_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/debt_to_equity_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/debt_to_total_asset_widget.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/financial_leverage.dart';
import 'package:financial_ratios/views/Categories%20and%20Operations/widget/solvency/times_intrest_earned_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';
import '../widget/liquidity/currentRatioWidget.dart';
import 'package:intl/intl.dart';

class OperationsView extends StatefulWidget {
  const OperationsView({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<OperationsView> createState() => _OperationsViewState();
}

class _OperationsViewState extends State<OperationsView> {
  final ProfileDateController controller =
      Get.put<ProfileDateController>(ProfileDateController(), permanent: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FittedBox(
                  child: Text(
                    widget.name,
                    style: GoogleFonts.tajawal(
                      height: 2,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: kPrimaryColor,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                'From ${DateFormat.yMMMd().format(controller.profileStartDate.value)} To ${DateFormat.yMMMEd().format(controller.profileEndDate.value)}',
                style: GoogleFonts.tajawal(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          ///////////////////Liquidity ratios///////////////////

          if (widget.name == "Current ratio")
            CurrentRatioWidget(name: widget.name),
          if (widget.name == "Quick ratio")
            QuickRatioWidget(
              name: widget.name,
            ),
          if (widget.name == "Cash ratio")
            CachRatioWidget(
              name: widget.name,
            ),
          if (widget.name == "CFO ratio") CfoRatioWidget(name: widget.name),
          if (widget.name == "Working Capital")
            WorkingCapitalWidget(name: widget.name),
          if (widget.name == "Defensive interval")
            DefensiveInterval(name: widget.name),

          //////////////////Solvency Ratios//////////////////////
          if (widget.name == "Debt to total assets")
            const DebtToTotalAssetWidget(),
          if (widget.name == "Debt to equity") const DebtToEquityWidget(),
          if (widget.name == "Financial leverage") const FinancialLeverage(),
          if (widget.name == "Times interest earned")
            const TimesIntrestEarnedWidget(),
          if (widget.name == "CFO to interest") const CfoToInterest(),
          if (widget.name == "CFO to debt") const CfoToDebt(),
          if (widget.name == "Cash flow adequacy") const CashFlowAdequacy(),
          if (widget.name == "Book value per share")
            const BookValuePerShareWidget(),
          if (widget.name == "CFO to Operating earnings")
            const CfoToOperatingEarnings(),

          ///////////////Activity Ratios///////////////////////

          if (widget.name == "Receivable turnover")
            const ReceivableTurnoversWidget(),
          if (widget.name == "Average receivables collection day")
            const AverageReceivableCollectionDay(),
          if (widget.name == "Inventory turnover")
            const InventoryTurnoverWidget(),
          if (widget.name == "Average days inventory in stock")
            const AverageDaysInventoryInStockWidget(),
          if (widget.name == "Payables turnover")
            const PayablesTurnoversWidget(),
          if (widget.name == "Average days payables outstanding")
            const AverageDaysPayablesOutstanding(),
          if (widget.name == "Operating cycle") const OperatingCycleWidget(),
          if (widget.name == "Net trade cycle or cash cycle")
            const NettradeCycleOrCashCycle(),
          if (widget.name == "Working capital turnover")
            const WorkingCapitalTurnoverWidget(),
          if (widget.name == "Fixed asset turnover")
            const FixedAssetTurnoverWidget(),
          if (widget.name == "Asset turnover") const AssetTurnoverWidget(),
          if (widget.name == "Average PPE age") const AveragePpeAgeWidget(),
          if (widget.name == "Average PPE useful life")
            const AveragePpeUsefulLife(),

          ///////////////Profitability Ratios///////////////////////

          if (widget.name == "Return on equity") const ReturnOnEquity(),
          if (widget.name == "Return on assets") const ReturnOnAsset(),
          if (widget.name == "Return on invested capital")
            const ReturnOnInvestedCapitalWidget(),
          if (widget.name == "Gross profit margin on sales")
            const GrossProfitMarginOnSales(),
          if (widget.name == "Operating Margin") const OperatingMarginWidget(),
          if (widget.name == "Net profit margin on sales")
            const NetProfitMarginOnSalesWidget(),
          if (widget.name == "Cash return on assets")
            const CashReturnOnAssetsWidget(),
          if (widget.name == "Earnings per share") const EarningsPerShare(),
          if (widget.name == "Price earnings ratio") const PriceEarningsRatio(),
          if (widget.name == "Market to book ratio")
            const MarketToBookRatioWidget(),
          if (widget.name == "Dividend Payout") const DividendPayoutWidget(),
          if (widget.name == "Dividend Yield") const DividendYieldWidget(),
        ],
      ),
    );
  }
}
