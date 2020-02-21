import 'libcore.dart' as libcore;
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';

void main() {
  // Hello, World
  libcore.callHello();
  // 接收字符串
  var str = Utf8.fromUtf8(libcore.callStr());
  print(str);
  // 输入字符串
  libcore.callEcho(Utf8.toUtf8("Call from Dart!"));
  // 接收 Struct
  var coordinatePointer = libcore.callCreateCoordinate(1.0, 1.1);
  var coordinate = coordinatePointer.ref;
  print('lat: ${coordinate.latitude}');
  print('lon: ${coordinate.longitude}');
  // 释放 Struct 内存
  libcore.callDropCoordinate(coordinatePointer);
}
