import 'dart:ffi';
import 'package:ffi/ffi.dart';

final dylib = DynamicLibrary.open('lib/libcore.so');

typedef hello_func = Void Function();
typedef str_func = Pointer<Utf8> Function();
typedef echo_func = Pointer<Utf8> Function(Pointer<Utf8> str);

typedef Hello = void Function();
typedef Echo = Pointer<Utf8> Function(Pointer<Utf8> str);

final Hello call_hello = dylib
   .lookup<NativeFunction<hello_func>>('hello')
   .asFunction();

final strPointer = dylib.lookup<NativeFunction<str_func>>('str');
final call_str = strPointer.asFunction<str_func>();

final echoPointer = dylib.lookup<NativeFunction<echo_func>>('echo');
final call_echo = echoPointer.asFunction<echo_func>();
