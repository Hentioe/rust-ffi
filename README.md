# rust-ffi

各种语言将 Rust 作为后端的 FFI 编程例子。

## 基本说明

本项目记录了一些 FFI 实现与调用代码，（预备）包含各种编程语言。

## 测试案例

### 举例说明

core 目录是 Rust 实现、以 C ABI 导出的一组接口，包含了各种类型的输入/输出场景。dart 目录是 Dart 语言实现的 FFI 调用。

#### 进入目录 
```bash
cd dart
```

#### 编译 native 库
```bash
make buildlib
```

#### 运行
```bash
make run
```

本项目日后会加入作者可能用到的围绕 core 项目的进行调用的各种编程语言代码。本页面的举例也是一种 Rust 参与 Flutter 技术栈的证明和参考。
