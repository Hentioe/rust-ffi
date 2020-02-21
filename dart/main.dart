import 'libcore.dart' as libcore;
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

void main() {
  // Hello, World
  libcore.hello();
  // 接收字符串
  var str = Utf8.fromUtf8(libcore.str());
  print(str);
  // 输入字符串
  libcore.echo(Utf8.toUtf8("Call from Dart!"));
  // 接收 Struct
  var coordinatePointer = libcore.createCoordinate(1.0, 1.1);
  var coordinate = coordinatePointer.ref;
  print('lat: ${coordinate.latitude}');
  print('lon: ${coordinate.longitude}');
  // 释放 Struct 内存
  libcore.freeCoordinate(coordinatePointer);
  // 接收数组
  var numsPointer = libcore.nums();
  var nums = numsPointer.ref;
  var len = nums.len;
  var data = nums.data;
  var list = data.asTypedList(len);
  print('len: $len');
  print('list: $list');
  libcore.freeNums(numsPointer);
}
