; RUN: opt -S -passes=mergefunc < %s | FileCheck %s

; There is a slight different in these two functions, in that the label values
; are switched. They are thus not mergeable. This tests that block addresses
; referring to blocks within each respective compared function are correctly
; ordered.

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @_Z1fi(i32 %i) #0 {
; CHECK-LABEL: define i32 @_Z1fi
; CHECK-NEXT: entry:
; CHECK-NEXT: alloca
entry:
  %i.addr = alloca i32, align 4
  %ret = alloca i32, align 4
  %l = alloca ptr, align 8
  store i32 %i, ptr %i.addr, align 4
  store i32 0, ptr %ret, align 4
; Right here, this is val_0, and later the if might assign val_1
  store ptr blockaddress(@_Z1fi, %val_0), ptr %l, align 8
  %0 = load i32, ptr %i.addr, align 4
  %and = and i32 %0, 256
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  store ptr blockaddress(@_Z1fi, %val_1), ptr %l, align 8
  br label %if.end

if.end:
  %1 = load ptr, ptr %l, align 8
  br label %indirectgoto

val_0:
  store i32 12, ptr %ret, align 4
  br label %end

val_1:
  store i32 42, ptr %ret, align 4
  br label %end

end:
  %2 = load i32, ptr %ret, align 4
  ret i32 %2

indirectgoto:
  %indirect.goto.dest = phi ptr [ %1, %if.end ]
  indirectbr ptr %indirect.goto.dest, [label %val_0, label %val_1]
}

; Function Attrs: nounwind uwtable
define i32 @_Z1gi(i32 %i) #0 {
; CHECK-LABEL: define i32 @_Z1gi
; CHECK-NEXT: entry:
; CHECK-NEXT: alloca
entry:
  %i.addr = alloca i32, align 4
  %ret = alloca i32, align 4
  %l = alloca ptr, align 8
  store i32 %i, ptr %i.addr, align 4
  store i32 0, ptr %ret, align 4
; This time, we store val_1 initially, and later the if might assign val_0
  store ptr blockaddress(@_Z1gi, %val_1), ptr %l, align 8
  %0 = load i32, ptr %i.addr, align 4
  %and = and i32 %0, 256
  %cmp = icmp eq i32 %and, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:
  store ptr blockaddress(@_Z1gi, %val_0), ptr %l, align 8
  br label %if.end

if.end:
  %1 = load ptr, ptr %l, align 8
  br label %indirectgoto

val_0:
  store i32 12, ptr %ret, align 4
  br label %end

val_1:
  store i32 42, ptr %ret, align 4
  br label %end

end:
  %2 = load i32, ptr %ret, align 4
  ret i32 %2

indirectgoto:
  %indirect.goto.dest = phi ptr [ %1, %if.end ]
  indirectbr ptr %indirect.goto.dest, [label %val_1, label %val_0]
}

