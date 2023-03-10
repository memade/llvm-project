; RUN: opt -passes=deadargelim -S < %s | FileCheck %s

; If caller is changed to pass in poison, noundef, dereferenceable and other
; attributes that imply immediate undefined behavior must be deleted.
; Other attributes like nonnull, which only imply poison, can be safely kept.

; CHECK:   define i64 @bar(ptr nonnull %0, i64 %1)
define i64 @bar(ptr nonnull dereferenceable(8) %0, i64 %1) {
entry:
  %2 = add i64 %1, 8
  ret i64 %2
}

define i64 @foo(ptr %p, i64 %v) {
; CHECK:   %retval = call i64 @bar(ptr nonnull poison, i64 %v)
  %retval = call i64 @bar(ptr nonnull dereferenceable(8) %p, i64 %v)
  ret i64 %retval
}
