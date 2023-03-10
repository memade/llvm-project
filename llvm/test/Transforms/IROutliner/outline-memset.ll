; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This test checks that we successfully outline identical memset instructions.

declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i32, i1)

define i64 @function1(i64 %x, i64 %z, i64 %n) {
entry:
  %pool = alloca [59 x i64], align 4
  call void @llvm.memset.p0.i64(ptr nonnull %pool, i8 0, i64 236, i32 4, i1 false)
  %cmp3 = icmp eq i64 %n, 0
  %a = add i64 %x, %z
  %c = add i64 %x, %z
  ret i64 0
}

define i64 @function2(i64 %x, i64 %z, i64 %n) {
entry:
  %pool = alloca [59 x i64], align 4
  call void @llvm.memset.p0.i64(ptr nonnull %pool, i8 0, i64 236, i32 4, i1 false)
  %cmp3 = icmp eq i64 %n, 0
  %a = add i64 %x, %z
  %c = add i64 %x, %z
  ret i64 0
}
; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[POOL:%.*]] = alloca [59 x i64], align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[POOL]], i64 [[N:%.*]], i64 [[X:%.*]], i64 [[Z:%.*]])
; CHECK-NEXT:    ret i64 0
;
;
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[POOL:%.*]] = alloca [59 x i64], align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[POOL]], i64 [[N:%.*]], i64 [[X:%.*]], i64 [[Z:%.*]])
; CHECK-NEXT:    ret i64 0
;
;
; CHECK: define internal void @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[ENTRY_TO_OUTLINE:%.*]]
; CHECK:       entry_to_outline:
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr nonnull align 4 [[TMP0:%.*]], i8 0, i64 236, i1 false)
; CHECK-NEXT:    [[CMP3:%.*]] = icmp eq i64 [[TMP1:%.*]], 0
; CHECK-NEXT:    [[A:%.*]] = add i64 [[TMP2:%.*]], [[TMP3:%.*]]
; CHECK-NEXT:    [[C:%.*]] = add i64 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    br label [[ENTRY_AFTER_OUTLINE_EXITSTUB:%.*]]
; CHECK:       entry_after_outline.exitStub:
; CHECK-NEXT:    ret void
;
