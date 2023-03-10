; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=verify,iroutliner -ir-outlining-no-cost < %s | FileCheck %s

; This test checks the isomorphic comparisons can be outlined together into one
; function.

; The following three function are identical, except that in the third, the
; operand order, and predicate are swapped, meaning it is structurally the same
; and should be outlined together.

define void @outline_slt1() {
; CHECK-LABEL: @outline_slt1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp slt i32 %al, %bl
  ret void
}

define void @outline_slt2() {
; CHECK-LABEL: @outline_slt2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp slt i32 %al, %bl
  ret void
}

define void @outline_sgt() {
; CHECK-LABEL: @outline_sgt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_1(ptr [[A]], ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp sgt i32 %bl, %al
  ret void
}

; This has a swapped predicate, but not swapped operands, so it cannot use
; the same outlined function as the ones above.

define void @dontoutline_sgt() {
; CHECK-LABEL: @dontoutline_sgt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store i32 2, ptr [[A]], align 4
; CHECK-NEXT:    store i32 3, ptr [[B]], align 4
; CHECK-NEXT:    [[AL:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    [[BL:%.*]] = load i32, ptr [[B]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = icmp sgt i32 [[AL]], [[BL]]
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp sgt i32 %al, %bl
  ret void
}

; The below functions use a different kind of predicate that is not compatible
; with the ones above, and should use a different outlined function.
; The other difference here is that the predicate with swapped operands comes
; first this time.

define void @outline_ugt1() {
; CHECK-LABEL: @outline_ugt1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp ugt i32 %al, %bl
  ret void
}

define void @outline_ugt2() {
; CHECK-LABEL: @outline_ugt2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp ugt i32 %al, %bl
  ret void
}

define void @outline_ult() {
; CHECK-LABEL: @outline_ult(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @outlined_ir_func_0(ptr [[A]], ptr [[B]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 2, ptr %a, align 4
  store i32 3, ptr %b, align 4
  %al = load i32, ptr %a
  %bl = load i32, ptr %b
  %0 = icmp ult i32 %bl, %al
  ret void
}

; CHECK: define internal void @outlined_ir_func_0(ptr [[ARG0:%.*]], ptr [[ARG1:%.*]]) #0 {
; CHECK: entry_to_outline:
; CHECK-NEXT:    store i32 2, ptr [[ARG0]], align 4
; CHECK-NEXT:    store i32 3, ptr [[ARG1]], align 4
; CHECK-NEXT:    [[AL:%.*]] = load i32, ptr [[ARG0]], align 4
; CHECK-NEXT:    [[BL:%.*]] = load i32, ptr [[ARG1]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ugt i32 [[AL]], [[BL]]

; CHECK: define internal void @outlined_ir_func_1(ptr [[ARG0:%.*]], ptr [[ARG1:%.*]]) #0 {
; CHECK: entry_to_outline:
; CHECK-NEXT:    store i32 2, ptr [[ARG0]], align 4
; CHECK-NEXT:    store i32 3, ptr [[ARG1]], align 4
; CHECK-NEXT:    [[AL:%.*]] = load i32, ptr [[ARG0]], align 4
; CHECK-NEXT:    [[BL:%.*]] = load i32, ptr [[ARG1]], align 4
; CHECK-NEXT:    [[TMP0:%.*]] = icmp slt i32 [[AL]], [[BL]]
