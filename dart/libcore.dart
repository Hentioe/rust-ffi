import 'dart:ffi' as ffi;

typedef hello_rust_func = ffi.Void Function();
typedef HelloRust = void Function();
final dylib = ffi.DynamicLibrary.open('lib/libcore.so');

final HelloRust hello_rust = dylib
   .lookup<ffi.NativeFunction<hello_rust_func>>('hello_rust')
   .asFunction();
