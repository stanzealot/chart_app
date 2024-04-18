import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

// since we want to specify the cate
enum Category { steps, waterIntake, calorieConsumption }

const categoryIcons = {
  Category.steps: Icons.timeline_outlined,
  Category.waterIntake: Icons.water_drop_outlined,
  Category.calorieConsumption: Icons.lunch_dining,
};

class Metric {
  // the id get initial once the class get
  Metric({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class MetricBucket {
  const MetricBucket({
    required this.category,
    required this.Metrics,
  });

  MetricBucket.forCategory(
    List<Metric> allMetrics,
    this.category,
  ) : Metrics =
            allMetrics.where((Matric) => Matric.category == category).toList();

  final Category category;
  final List<Metric> Metrics;

  //
  double get totalMetrics {
    double sum = 0;
    for (final Metric in Metrics) {
      sum += Metric.amount;
    }

    return sum;
  }
}
