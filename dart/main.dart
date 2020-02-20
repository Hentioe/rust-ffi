import 'libcore.dart' as libcore;
import 'package:ffi/ffi.dart';

void main() {
  // Hello, World
  libcore.call_hello();
  // 返回字符串
  var str = Utf8.fromUtf8(libcore.call_str());
  print(str);
  // 输入字符串
  libcore.call_echo(Utf8.toUtf8("Call from Dart!"));
}
