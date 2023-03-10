; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -verify-machineinstrs -mattr=+simd128 | FileCheck %s

; Regression test for an issue in which DAG combines created a constant i8x16
; vector with lane values of 255, which was outside the -128 to 127 range
; expected by our ISel patterns (and similar for the i16 version) and caused an
; ISel failure. The fix was to adjust out-of-range values manually in
; BUILD_VECTOR lowering.

target triple = "wasm32-unknown-unknown"

define <4 x i8> @test_i8(<4 x i8> %b) {
; CHECK-LABEL: test_i8:
; CHECK:         .functype test_i8 (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    v128.const 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.andnot
; CHECK-NEXT:    # fallthrough-return
  %c = and <4 x i8> %b, <i8 1, i8 1, i8 1, i8 1>
  %d = xor <4 x i8> %c, <i8 1, i8 1, i8 1, i8 1>
  ret <4 x i8> %d
}

define <4 x i16> @test_i16(<4 x i16> %b) {
; CHECK-LABEL: test_i16:
; CHECK:         .functype test_i16 (v128) -> (v128)
; CHECK-NEXT:  # %bb.0:
; CHECK-NEXT:    v128.const 1, 1, 1, 1, 1, 1, 1, 1
; CHECK-NEXT:    local.get 0
; CHECK-NEXT:    v128.andnot
; CHECK-NEXT:    # fallthrough-return
  %c = and <4 x i16> %b, <i16 1, i16 1, i16 1, i16 1>
  %d = xor <4 x i16> %c, <i16 1, i16 1, i16 1, i16 1>
  ret <4 x i16> %d
}
