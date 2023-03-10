; REQUIRES: asserts
; RUN: opt -passes=inline -mtriple=x86_64-unknown-unknown -S -debug-only=inline-cost < %s 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-unknown"

define i32 @outer1(ptr %ptr, i32 %i) {
  %C = call i32 @inner1(ptr %ptr, i32 %i)
  ret i32 %C
}

; zext from i32 to i64 is free.
; CHECK: Analyzing call of inner1
; CHECK: NumInstructionsSimplified: 3
; CHECK: NumInstructions: 4
define i32 @inner1(ptr %ptr, i32 %i) {
  %E = zext i32 %i to i64
  %G = getelementptr inbounds i32, ptr %ptr, i64 %E
  %L = load i32, ptr %G
  ret i32 %L
}

define i16 @outer2(ptr %ptr) {
  %C = call i16 @inner2(ptr %ptr)
  ret i16 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner2
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i16 @inner2(ptr %ptr) {
  %L = load i8, ptr %ptr
  %E = zext i8 %L to i16
  ret i16 %E
}

define i16 @outer3(ptr %ptr) {
  %C = call i16 @inner3(ptr %ptr)
  ret i16 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner3
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i16 @inner3(ptr %ptr) {
  %L = load i8, ptr %ptr
  %E = sext i8 %L to i16
  ret i16 %E
}

define i32 @outer4(ptr %ptr) {
  %C = call i32 @inner4(ptr %ptr)
  ret i32 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner4
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i32 @inner4(ptr %ptr) {
  %L = load i8, ptr %ptr
  %E = zext i8 %L to i32
  ret i32 %E
}

define i32 @outer5(ptr %ptr) {
  %C = call i32 @inner5(ptr %ptr)
  ret i32 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner5
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i32 @inner5(ptr %ptr) {
  %L = load i8, ptr %ptr
  %E = sext i8 %L to i32
  ret i32 %E
}

define i32 @outer6(ptr %ptr) {
  %C = call i32 @inner6(ptr %ptr)
  ret i32 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner6
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i32 @inner6(ptr %ptr) {
  %L = load i16, ptr %ptr
  %E = zext i16 %L to i32
  ret i32 %E
}

define i32 @outer7(ptr %ptr) {
  %C = call i32 @inner7(ptr %ptr)
  ret i32 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner7
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i32 @inner7(ptr %ptr) {
  %L = load i16, ptr %ptr
  %E = sext i16 %L to i32
  ret i32 %E
}

define i64 @outer8(ptr %ptr) {
  %C = call i64 @inner8(ptr %ptr)
  ret i64 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner8
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i64 @inner8(ptr %ptr) {
  %L = load i8, ptr %ptr
  %E = zext i8 %L to i64
  ret i64 %E
}

define i64 @outer9(ptr %ptr) {
  %C = call i64 @inner9(ptr %ptr)
  ret i64 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner9
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i64 @inner9(ptr %ptr) {
  %L = load i8, ptr %ptr
  %E = sext i8 %L to i64
  ret i64 %E
}

define i64 @outer10(ptr %ptr) {
  %C = call i64 @inner10(ptr %ptr)
  ret i64 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner10
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i64 @inner10(ptr %ptr) {
  %L = load i16, ptr %ptr
  %E = zext i16 %L to i64
  ret i64 %E
}

define i64 @outer11(ptr %ptr) {
  %C = call i64 @inner11(ptr %ptr)
  ret i64 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner11
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i64 @inner11(ptr %ptr) {
  %L = load i16, ptr %ptr
  %E = sext i16 %L to i64
  ret i64 %E
}

define i64 @outer12(ptr %ptr) {
  %C = call i64 @inner12(ptr %ptr)
  ret i64 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner12
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i64 @inner12(ptr %ptr) {
  %L = load i32, ptr %ptr
  %E = zext i32 %L to i64
  ret i64 %E
}

define i64 @outer13(ptr %ptr) {
  %C = call i64 @inner13(ptr %ptr)
  ret i64 %C
}

; It is an ExtLoad.
; CHECK: Analyzing call of inner13
; CHECK: NumInstructionsSimplified: 2
; CHECK: NumInstructions: 3
define i64 @inner13(ptr %ptr) {
  %L = load i32, ptr %ptr
  %E = sext i32 %L to i64
  ret i64 %E
}
