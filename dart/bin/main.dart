import 'package:dart/libcore.dart' as libcore;
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';

void main() {
  // Hello, world
  libcore.hello();
  // 接收字符串
  var strPointer = libcore.str();
  var str = Utf8.fromUtf8(strPointer);
  print(str);
  libcore.free_str(strPointer);
  // 输入字符串
  libcore.echo(Utf8.toUtf8("Call from Dart!"));
  // 接收 struct
  var coordinatePointer = libcore.createCoordinate(1.0, 1.1);
  var coordinate = coordinatePointer.ref;
  print('lat: ${coordinate.latitude}');
  print('lon: ${coordinate.longitude}');
  // 释放 struct 内存
  libcore.freeCoordinate(coordinatePointer);
  // 接收数组
  var numsPointer = libcore.nums();
  var nums = numsPointer.ref;
  var nums_len = nums.len;
  var data = nums.data;
  var nums_list = data.asTypedList(nums_len);
  print('nums_len: $nums_len');
  print('nums_list: $nums_list');
  libcore.freeIntArray(numsPointer);
  // 输入数组（数字）
  var int32Pointer = allocate<Int32>(count: 3);
  int32Pointer.value = 1;
  int32Pointer[1] = 2;
  int32Pointer[2] = 3;
  var sum = libcore.sum(int32Pointer, 3);
  print('sum: $sum');
  free(int32Pointer);
  // 输出数组（字符串）
  var namesPointer = libcore.names();
  var names = namesPointer.ref;
  var names_len = names.len;
  print('names_len: $names_len');
  var names_list = new List<String>();
  for (var i = 0; i < names_len; i++) {
    var namePointer = names.data[i];
    names_list.add(Utf8.fromUtf8(namePointer));
  }
  print('names_list: $names_list');
  libcore.freeNames(namesPointer);
  // 调用函数并检查错误
  var n1 = 99;
  var n2 = 0;
  var r = libcore.div(n1, n2);
  var errLen = libcore.lastErrorLength();
  if (errLen > 0) {
    // 发生错误
    var errBuf = Utf8.toUtf8("");
    libcore.lastErrorMessage(errBuf, errLen);
    print('Error calling div: ${Utf8.fromUtf8(errBuf)}');
    // 释放错误错误字符串缓存
    free(errBuf);
  } else {
    print('div($n1, $n2): $r');
  }
}

void memtesting(Function() f, {count: 9999999}) {
  for (var i = 0; i < count; i++) {
    f();
  }
  print('done.');
  sleep(new Duration(seconds: 999));
}
