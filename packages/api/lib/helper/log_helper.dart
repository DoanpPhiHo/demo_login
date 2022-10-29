import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'pretty_printer/custom_output_logger.dart';
import 'pretty_printer/custom_pretty_printer.dart';

enum LogType { debug, terminal }

extension ColorTerminal on ColorTerminalEnum {
  String value(String text) {
    switch (this) {
      case ColorTerminalEnum.black:
        return '\x1B[30m$text\x1B[0m';
      case ColorTerminalEnum.red:
        return '\x1B[31m$text\x1B[0m';
      case ColorTerminalEnum.green:
        return '\x1B[32m$text\x1B[0m';
      case ColorTerminalEnum.yellow:
        return '\x1B[33m$text\x1B[0m';
      case ColorTerminalEnum.blue:
        return '\x1B[34m$text\x1B[0m';
      case ColorTerminalEnum.magenta:
        return '\x1B[35m$text\x1B[0m';
      case ColorTerminalEnum.cyan:
        return '\x1B[36m$text\x1B[0m';
      case ColorTerminalEnum.white:
        return '\x1B[37m$text\x1B[0m';
    }
  }
}

extension DebugPrintExtension on String {
  String? showPrint() {
    if (length <= 0) return null;
    const int n = 800;
    int startIndex = 0;
    int endIndex = n;
    while (startIndex < length) {
      if (endIndex > length) endIndex = length;
      if (kDebugMode) {
        print(substring(startIndex, endIndex));
      }
      startIndex += n;
      endIndex = startIndex + n;
    }
    return this;
  }
}

enum ColorTerminalEnum { black, red, green, yellow, blue, magenta, cyan, white }

class LogHelper {
  LogHelper._();
  static final LogHelper instance = LogHelper._();
  static bool logEnable = false;
  static LogType logType = LogType.debug;
  static Logger logger = Logger(
      output: CustomConsoleOutput(),
      printer: CustomPrettyPrinter(
        methodCount: 1,
        errorMethodCount: 10,
        stackTraceBeginIndex: 4,
      ));

  static void debug(String title, dynamic logDev) {
    if (logEnable) {
      if (logType == LogType.debug) {
        logger.d(
            '[${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}] - $title \n${logDev.toString()}');
      } else {
        '========= [${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}] - $title =========='
            .showPrint();
        ' ${logDev.toString().showPrint()}';
        '============================================================'
            .showPrint();
      }
    }
  }

  static void print(String title, dynamic logPrint) {
    if (logEnable) {
      if (logType == LogType.debug) {
        logger.d(
            '[${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}]  \n - $title ==> ${logPrint.toString()}');
      } else {
        '[${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}] - $title ==> ${logPrint.toString()}'
            .showPrint();
      }
    }
  }

  static void error(String title, dynamic error) {
    if (logEnable) {
      if (logType == LogType.debug) {
        logger.e(
            '[${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}] - $title  \n$error');
      } else {
        '[${DateFormat('dd-MM-yyyy hh:mm:ss').format(DateTime.now())}] - $title '
            .showPrint();
        'error: $error'.showPrint();
      }
    }
  }
}
