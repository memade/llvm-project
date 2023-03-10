; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=newgvn -S | FileCheck %s

; github issue #56039
define i8 @src(ptr %a, ptr %b, i1 %c) {
; CHECK-LABEL: @src(
; CHECK-NEXT:    br i1 [[C:%.*]], label [[BB1:%.*]], label [[BB2:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[LB1:%.*]] = load i8, ptr [[B:%.*]], align 1
; CHECK-NEXT:    [[TOBOOL3_NOT_I:%.*]] = icmp eq i8 [[LB1]], 0
; CHECK-NEXT:    br i1 [[TOBOOL3_NOT_I]], label [[BB4:%.*]], label [[BB3:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[LB2:%.*]] = load i8, ptr [[B]], align 1
; CHECK-NEXT:    [[CMP_NOT_I:%.*]] = icmp ult i8 0, [[LB2]]
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[CMP_NOT_I]])
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    [[LA:%.*]] = load i8, ptr [[A:%.*]], align 1
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       bb4:
; CHECK-NEXT:    ret i8 0
;
  br i1 %c, label %bb1, label %bb2

bb1:
  %lb1 = load i8, ptr %b
  %tobool3.not.i = icmp eq i8 %lb1, 0
  br i1 %tobool3.not.i, label %bb4, label %bb3

bb2:
  %lb2 = load i8, ptr %b
  %cmp.not.i = icmp ult i8 0, %lb2
  tail call void @llvm.assume(i1 %cmp.not.i)
  br label %bb3

bb3:
  %p = phi i8 [ %lb1, %bb1 ], [ %lb2, %bb2 ]
  %la = load i8, ptr %a
  %xor = xor i8 %la, %p
  br label %bb4

bb4:
  ret i8 0
}

declare void @llvm.assume(i1)
