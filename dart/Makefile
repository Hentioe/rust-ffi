CARGO_BIN ?= `which cargo`
LIB_PATH ?= "../core"
.PHONY: buildlib run
buildlib:
	@( cd $(LIB_PATH) && $(CARGO_BIN) build --release )
	@mkdir lib -p
	@cp $(LIB_PATH)/target/release/libcore.so lib/

run:
	@dart main.dart
