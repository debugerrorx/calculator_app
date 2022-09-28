import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:function_tree/function_tree.dart';

final calculationProvider =
    ChangeNotifierProvider<CalculationNotifier>((_) => CalculationNotifier());

class CalculationNotifier extends ChangeNotifier {
  List<String> dataList = ['0'];
  String prevData = ' ';

  bool isSign = false;
  bool isResult = false;

  String get data => dataList.join(' ');

  String get equation => data
      .replaceAll('\u00F7', '/')
      .replaceAll('\u00D7', '*')
      .replaceAll('\u2212', '-');

  void addNumber(String number) {
    if (isResult || (dataList.length == 1 && dataList.last == '0')) {
      dataList = [number];
      isResult = false;
    } else if (isSign) {
      dataList.add(number);
      isSign = false;
    } else if (dataList.last.startsWith('(')) {
      final temp = dataList.last.substring(0, dataList.last.length - 1);
      dataList.last = '$temp$number)';
    } else {
      dataList.last += number;
    }

    notifyListeners();
  }

  void _negation() {
    if (isSign) {
      return;
    }

    if (dataList.last.startsWith('(')) {
      dataList.last = dataList.last.substring(2, dataList.last.length - 1);
    } else if (dataList.last.startsWith('-')) {
      dataList.last = '(${dataList.last})';
    } else {
      dataList.last = '(-${dataList.last})';
    }
  }

  void _percentage() {
    if (isSign) {
      return;
    }

    final result = dataList.last.interpret() * 0.01;
    dataList.last = result < 0 ? '($result)' : result.toString();
  }

  void _decimalPoint() {
    if (dataList.last.contains('.')) {
      return;
    }

    if (isSign) {
      dataList.add('0');
      isSign = false;
    }

    if (dataList.last.startsWith('(')) {
      final temp = dataList.last.substring(0, dataList.last.length - 1);
      dataList.last = '$temp.)';
    } else {
      dataList.last += '.';
    }
  }

  void _clear() {
    dataList = ['0'];
    prevData = ' ';
    isSign = false;
  }

  void _showResult() {
    prevData = data;

    final result = equation.interpret();
    dataList = [
      result % 1 == 0 ? result.toInt().toString() : result.toString(),
    ];
    isResult = true;
  }

  void addSign(String sign) {
    isResult = false;

    switch (sign) {
      case '+/\u2212':
        _negation();
        break;

      case '%':
        _percentage();
        break;

      case '.':
        _decimalPoint();
        break;

      case 'C':
        _clear();
        break;

      case '=':
        _showResult();
        break;

      default:
        if (isSign) {
          dataList.last = sign;
        } else {
          dataList.add(sign);
          isSign = true;
        }
        break;
    }

    notifyListeners();
  }
}
