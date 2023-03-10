; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --include-generated-funcs
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This test checks that we do can outline calls, but only if they have the same
; function type and the same name.

declare void @f1(ptr, ptr);
declare void @f2(ptr, ptr);

define void @function1() {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  call void @f1(ptr %a, ptr %b)
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}

define void @function2() {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  call void @f1(ptr %a, ptr %b)
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}

define void @function3() {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  store i32 4, ptr %c, align 4
  call void @f2(ptr %a, ptr %b)
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %cl = load i32, ptr %c
  ret void
}

; CHECK-LABEL: @function1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]], ptr @f1)
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @function2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]], ptr @f1)
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: @function3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]], ptr [[C]], ptr @f2)
; CHECK-NEXT:    ret void
;
;
; CHECK-LABEL: define internal void @outlined_ir_func_0(
; CHECK-NEXT:  newFuncRoot:
; CHECK-NEXT:    br label [[ENTRY_TO_OUTLINE:%.*]]
; CHECK:       entry_to_outline:
; CHECK-NEXT:    store i32 2, ptr [[TMP0:%.*]], align 4
; CHECK-NEXT:    store i32 3, ptr [[TMP1:%.*]], align 4
; CHECK-NEXT:    store i32 4, ptr [[TMP2:%.*]], align 4
; CHECK-NEXT:    call void [[TMP3:%.*]](ptr [[TMP0]], ptr [[TMP1]])
; CHECK-NEXT:    [[AL:%.*]] = load i32, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[BL:%.*]] = load i32, ptr [[TMP1]], align 4
; CHECK-NEXT:    [[CL:%.*]] = load i32, ptr [[TMP2]], align 4
; CHECK-NEXT:    br label [[ENTRY_AFTER_OUTLINE_EXITSTUB:%.*]]
; CHECK:       entry_after_outline.exitStub:
; CHECK-NEXT:    ret void
;
