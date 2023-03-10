; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=rewrite-statepoints-for-gc < %s | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"
target datalayout = "e-ni:1:6"

declare void @foo()

define ptr addrspace(1) @test(i64 %i) gc "statepoint-example" {
; CHECK-LABEL: @test(
; CHECK-NEXT:    [[P:%.*]] = inttoptr i64 [[I:%.*]] to ptr addrspace(1)
; CHECK-NEXT:    [[STATEPOINT_TOKEN:%.*]] = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 2882400000, i32 0, ptr elementtype(void ()) @foo, i32 0, i32 0, i32 0, i32 0) [ "gc-live"(ptr addrspace(1) [[P]]) ]
; CHECK-NEXT:    [[P_RELOCATED:%.*]] = call coldcc ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token [[STATEPOINT_TOKEN]], i32 0, i32 0)
; CHECK-NEXT:    ret ptr addrspace(1) [[P_RELOCATED]]
;
  %p = inttoptr i64 %i to ptr addrspace(1)
  call void @foo()
  ret ptr addrspace(1) %p
}
