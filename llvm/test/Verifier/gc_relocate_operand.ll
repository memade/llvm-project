; RUN: not llvm-as -disable-output <%s 2>&1 | FileCheck %s
; This is to verify that the relocated value by gc_relocate must be a pointer type.

; CHECK: gc.relocate: relocated value must be a gc pointer

declare void @foo()

declare token @llvm.experimental.gc.statepoint.p0(i64, i32, ptr, i32, i32, ...)

define void @test1(i64 %obj) gc "statepoint-example" {
entry:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr @foo, i32 0, i32 0, i32 0, i32 0, i64 %obj)
  %obj.relocated = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token %safepoint_token, i32 7, i32 7) ; (%obj, %obj)
  ret void
}

; Function Attrs: nounwind
declare ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token, i32, i32) #0

attributes #0 = { nounwind }

