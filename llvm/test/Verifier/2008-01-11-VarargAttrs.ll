; RUN: not llvm-as < %s > /dev/null 2>&1

%struct = type {  }

declare void @foo(...)

define void @bar() {
	call void (...) @foo(ptr sret(%struct) null )
	ret void
}
