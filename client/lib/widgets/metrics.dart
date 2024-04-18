import 'package:chart_app/models/metric.dart';
import 'package:chart_app/widgets/chart/chart.dart';
import 'package:chart_app/widgets/metrics_list/metrics_list.dart';
import 'package:chart_app/widgets/new_metric.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Metrics extends StatefulWidget {
  const Metrics({super.key});
  @override
  State<Metrics> createState() {
    return _MetricsState();
  }
}

class _MetricsState extends State<Metrics> {
  final List<Metric> _registeredMetrics = [
    Metric(
      title: 'Health Metric',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.steps,
    ),
    Metric(
      title: 'Flutter course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.calorieConsumption,
    ),
  ];

  void _openAddMetricOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewMetric(
        onAddMetric: _addMetric,
      ),
    );
  }

  void _addMetric(Metric metric) {
    setState(() {
      _registeredMetrics.add(metric);
    });
  }

  void _removeMetric(Metric metric) {
    final metricIndex = _registeredMetrics.indexOf(metric);

    setState(() {
      _registeredMetrics.remove(metric);
    });

    // clear info message first before adding another
    ScaffoldMessenger.of(context).clearSnackBars();
    // adding an info messages
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredMetrics.insert(metricIndex, metric);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses Found. Start adding some!'),
    );

    if (_registeredMetrics.isNotEmpty) {
      mainContent = MetricsList(
        metrics: _registeredMetrics,
        onRemoveMetric: _removeMetric,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddMetricOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(metrics: _registeredMetrics),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
