; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -loop-reduce -S %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

; Make sure we do not crash when applying info from loop guards to expressions in @bar.
; Test case for PR47776.

define void @bar() personality ptr @zot {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1.loopexit:
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP:%.*]] = phi i32 [ 1, [[BB:%.*]] ], [ 0, [[BB1_LOOPEXIT:%.*]] ]
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i64 [ 0, [[BB1]] ], [ [[TMP7:%.*]], [[BB5:%.*]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = invoke i32 @fn()
; CHECK-NEXT:    to label [[BB5]] unwind label [[BB23_LOOPEXIT_SPLIT_LP:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    [[TMP6:%.*]] = load atomic i32, ptr addrspace(1) undef unordered, align 8
; CHECK-NEXT:    [[TMP7]] = add nuw nsw i64 [[TMP3]], 1
; CHECK-NEXT:    [[C_0:%.*]] = icmp ult i64 [[TMP7]], 10000
; CHECK-NEXT:    br i1 [[C_0]], label [[BB2]], label [[BB8:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    [[TMP9:%.*]] = icmp ult i32 [[TMP]], [[TMP6]]
; CHECK-NEXT:    br i1 [[TMP9]], label [[BB10:%.*]], label [[BB29:%.*]]
; CHECK:       bb10:
; CHECK-NEXT:    [[TMP11:%.*]] = mul i32 [[TMP]], -1
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[TMP11]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw i64 [[TMP0]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = sub i64 [[TMP1]], [[TMP7]]
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP2]] to i32
; CHECK-NEXT:    [[TMP16:%.*]] = and i32 [[TMP1]], 7
; CHECK-NEXT:    br label [[BB17:%.*]]
; CHECK:       bb17:
; CHECK-NEXT:    [[TMP18:%.*]] = phi i32 [ [[TMP21:%.*]], [[BB20:%.*]] ], [ [[TMP16]], [[BB10]] ]
; CHECK-NEXT:    [[TMP19:%.*]] = invoke i32 @fn()
; CHECK-NEXT:    to label [[BB20]] unwind label [[BB23_LOOPEXIT:%.*]]
; CHECK:       bb20:
; CHECK-NEXT:    [[TMP21]] = add i32 [[TMP18]], -1
; CHECK-NEXT:    [[TMP22:%.*]] = icmp eq i32 [[TMP21]], 0
; CHECK-NEXT:    br i1 [[TMP22]], label [[BB1_LOOPEXIT]], label [[BB17]]
; CHECK:       bb23.loopexit:
; CHECK-NEXT:    [[LPAD_LOOPEXIT:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    br label [[BB23:%.*]]
; CHECK:       bb23.loopexit.split-lp:
; CHECK-NEXT:    [[LPAD_LOOPEXIT_SPLIT_LP:%.*]] = landingpad token
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    br label [[BB23]]
; CHECK:       bb23:
; CHECK-NEXT:    ret void
; CHECK:       bb29:
; CHECK-NEXT:    ret void
;
bb:
  br label %bb1

bb1:                                              ; preds = %bb20, %bb
  %tmp = phi i32 [ 1, %bb ], [ 0, %bb20 ]
  br label %bb2

bb2:                                              ; preds = %bb5, %bb1
  %tmp3 = phi i64 [ 0, %bb1 ], [ %tmp7, %bb5 ]
  %tmp4 = invoke i32 @fn()
  to label %bb5 unwind label %bb23

bb5:                                              ; preds = %bb2
  %tmp6 = load atomic i32, ptr addrspace(1) undef unordered, align 8
  %tmp7 = add nuw nsw i64 %tmp3, 1
  %c.0 = icmp ult i64 %tmp7, 10000
  br i1 %c.0, label %bb2, label %bb8

bb8:                                              ; preds = %bb5
  %tmp9 = icmp ult i32 %tmp, %tmp6
  br i1 %tmp9, label %bb10, label %bb29

bb10:                                             ; preds = %bb8
  %tmp11 = mul i32 %tmp, -1
  %tmp12 = zext i32 %tmp11 to i64
  %tmp13 = sub i64 %tmp12, %tmp7
  %tmp14 = add i64 %tmp13, 1
  %tmp15 = trunc i64 %tmp14 to i32
  %tmp16 = and i32 %tmp15, 7
  br label %bb17

bb17:                                             ; preds = %bb20, %bb10
  %tmp18 = phi i32 [ %tmp21, %bb20 ], [ %tmp16, %bb10 ]
  %tmp19 = invoke i32 @fn()
  to label %bb20 unwind label %bb23

bb20:                                             ; preds = %bb17
  %tmp21 = add i32 %tmp18, -1
  %tmp22 = icmp eq i32 %tmp21, 0
  br i1 %tmp22, label %bb1, label %bb17

bb23:                                             ; preds = %bb17
  %tmp24 = landingpad token
  cleanup
  ret void

bb29:                                             ; preds = %bb8
  ret void
}

declare ptr @zot() #1

declare i32 @fn()
