// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +experimental-zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv1f16.i64(<vscale x 1 x half> [[V0:%.*]], <vscale x 1 x half> [[V1:%.*]], <vscale x 1 x half> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16mf4(_Float16 *base, vfloat16mf4_t v0, vfloat16mf4_t v1, vfloat16mf4_t v2, size_t vl) {
  return vsseg3e16_v_f16mf4(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv2f16.i64(<vscale x 2 x half> [[V0:%.*]], <vscale x 2 x half> [[V1:%.*]], <vscale x 2 x half> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16mf2(_Float16 *base, vfloat16mf2_t v0, vfloat16mf2_t v1, vfloat16mf2_t v2, size_t vl) {
  return vsseg3e16_v_f16mf2(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv4f16.i64(<vscale x 4 x half> [[V0:%.*]], <vscale x 4 x half> [[V1:%.*]], <vscale x 4 x half> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16m1(_Float16 *base, vfloat16m1_t v0, vfloat16m1_t v1, vfloat16m1_t v2, size_t vl) {
  return vsseg3e16_v_f16m1(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv8f16.i64(<vscale x 8 x half> [[V0:%.*]], <vscale x 8 x half> [[V1:%.*]], <vscale x 8 x half> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16m2(_Float16 *base, vfloat16m2_t v0, vfloat16m2_t v1, vfloat16m2_t v2, size_t vl) {
  return vsseg3e16_v_f16m2(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv1i16.i64(<vscale x 1 x i16> [[V0:%.*]], <vscale x 1 x i16> [[V1:%.*]], <vscale x 1 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16mf4(int16_t *base, vint16mf4_t v0, vint16mf4_t v1, vint16mf4_t v2, size_t vl) {
  return vsseg3e16_v_i16mf4(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv2i16.i64(<vscale x 2 x i16> [[V0:%.*]], <vscale x 2 x i16> [[V1:%.*]], <vscale x 2 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16mf2(int16_t *base, vint16mf2_t v0, vint16mf2_t v1, vint16mf2_t v2, size_t vl) {
  return vsseg3e16_v_i16mf2(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv4i16.i64(<vscale x 4 x i16> [[V0:%.*]], <vscale x 4 x i16> [[V1:%.*]], <vscale x 4 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16m1(int16_t *base, vint16m1_t v0, vint16m1_t v1, vint16m1_t v2, size_t vl) {
  return vsseg3e16_v_i16m1(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv8i16.i64(<vscale x 8 x i16> [[V0:%.*]], <vscale x 8 x i16> [[V1:%.*]], <vscale x 8 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16m2(int16_t *base, vint16m2_t v0, vint16m2_t v1, vint16m2_t v2, size_t vl) {
  return vsseg3e16_v_i16m2(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16mf4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv1i16.i64(<vscale x 1 x i16> [[V0:%.*]], <vscale x 1 x i16> [[V1:%.*]], <vscale x 1 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16mf4(uint16_t *base, vuint16mf4_t v0, vuint16mf4_t v1, vuint16mf4_t v2, size_t vl) {
  return vsseg3e16_v_u16mf4(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16mf2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv2i16.i64(<vscale x 2 x i16> [[V0:%.*]], <vscale x 2 x i16> [[V1:%.*]], <vscale x 2 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16mf2(uint16_t *base, vuint16mf2_t v0, vuint16mf2_t v1, vuint16mf2_t v2, size_t vl) {
  return vsseg3e16_v_u16mf2(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16m1(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv4i16.i64(<vscale x 4 x i16> [[V0:%.*]], <vscale x 4 x i16> [[V1:%.*]], <vscale x 4 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16m1(uint16_t *base, vuint16m1_t v0, vuint16m1_t v1, vuint16m1_t v2, size_t vl) {
  return vsseg3e16_v_u16m1(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16m2(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.nxv8i16.i64(<vscale x 8 x i16> [[V0:%.*]], <vscale x 8 x i16> [[V1:%.*]], <vscale x 8 x i16> [[V2:%.*]], ptr [[BASE:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16m2(uint16_t *base, vuint16m2_t v0, vuint16m2_t v1, vuint16m2_t v2, size_t vl) {
  return vsseg3e16_v_u16m2(base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv1f16.i64(<vscale x 1 x half> [[V0:%.*]], <vscale x 1 x half> [[V1:%.*]], <vscale x 1 x half> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16mf4_m(vbool64_t mask, _Float16 *base, vfloat16mf4_t v0, vfloat16mf4_t v1, vfloat16mf4_t v2, size_t vl) {
  return vsseg3e16_v_f16mf4_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv2f16.i64(<vscale x 2 x half> [[V0:%.*]], <vscale x 2 x half> [[V1:%.*]], <vscale x 2 x half> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16mf2_m(vbool32_t mask, _Float16 *base, vfloat16mf2_t v0, vfloat16mf2_t v1, vfloat16mf2_t v2, size_t vl) {
  return vsseg3e16_v_f16mf2_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv4f16.i64(<vscale x 4 x half> [[V0:%.*]], <vscale x 4 x half> [[V1:%.*]], <vscale x 4 x half> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16m1_m(vbool16_t mask, _Float16 *base, vfloat16m1_t v0, vfloat16m1_t v1, vfloat16m1_t v2, size_t vl) {
  return vsseg3e16_v_f16m1_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_f16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv8f16.i64(<vscale x 8 x half> [[V0:%.*]], <vscale x 8 x half> [[V1:%.*]], <vscale x 8 x half> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_f16m2_m(vbool8_t mask, _Float16 *base, vfloat16m2_t v0, vfloat16m2_t v1, vfloat16m2_t v2, size_t vl) {
  return vsseg3e16_v_f16m2_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv1i16.i64(<vscale x 1 x i16> [[V0:%.*]], <vscale x 1 x i16> [[V1:%.*]], <vscale x 1 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16mf4_m(vbool64_t mask, int16_t *base, vint16mf4_t v0, vint16mf4_t v1, vint16mf4_t v2, size_t vl) {
  return vsseg3e16_v_i16mf4_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv2i16.i64(<vscale x 2 x i16> [[V0:%.*]], <vscale x 2 x i16> [[V1:%.*]], <vscale x 2 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16mf2_m(vbool32_t mask, int16_t *base, vint16mf2_t v0, vint16mf2_t v1, vint16mf2_t v2, size_t vl) {
  return vsseg3e16_v_i16mf2_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv4i16.i64(<vscale x 4 x i16> [[V0:%.*]], <vscale x 4 x i16> [[V1:%.*]], <vscale x 4 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16m1_m(vbool16_t mask, int16_t *base, vint16m1_t v0, vint16m1_t v1, vint16m1_t v2, size_t vl) {
  return vsseg3e16_v_i16m1_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_i16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv8i16.i64(<vscale x 8 x i16> [[V0:%.*]], <vscale x 8 x i16> [[V1:%.*]], <vscale x 8 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_i16m2_m(vbool8_t mask, int16_t *base, vint16m2_t v0, vint16m2_t v1, vint16m2_t v2, size_t vl) {
  return vsseg3e16_v_i16m2_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16mf4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv1i16.i64(<vscale x 1 x i16> [[V0:%.*]], <vscale x 1 x i16> [[V1:%.*]], <vscale x 1 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16mf4_m(vbool64_t mask, uint16_t *base, vuint16mf4_t v0, vuint16mf4_t v1, vuint16mf4_t v2, size_t vl) {
  return vsseg3e16_v_u16mf4_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16mf2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv2i16.i64(<vscale x 2 x i16> [[V0:%.*]], <vscale x 2 x i16> [[V1:%.*]], <vscale x 2 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16mf2_m(vbool32_t mask, uint16_t *base, vuint16mf2_t v0, vuint16mf2_t v1, vuint16mf2_t v2, size_t vl) {
  return vsseg3e16_v_u16mf2_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16m1_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv4i16.i64(<vscale x 4 x i16> [[V0:%.*]], <vscale x 4 x i16> [[V1:%.*]], <vscale x 4 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16m1_m(vbool16_t mask, uint16_t *base, vuint16m1_t v0, vuint16m1_t v1, vuint16m1_t v2, size_t vl) {
  return vsseg3e16_v_u16m1_m(mask, base, v0, v1, v2, vl);
}

// CHECK-RV64-LABEL: @test_vsseg3e16_v_u16m2_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.vsseg3.mask.nxv8i16.i64(<vscale x 8 x i16> [[V0:%.*]], <vscale x 8 x i16> [[V1:%.*]], <vscale x 8 x i16> [[V2:%.*]], ptr [[BASE:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret void
//
void test_vsseg3e16_v_u16m2_m(vbool8_t mask, uint16_t *base, vuint16m2_t v0, vuint16m2_t v1, vuint16m2_t v2, size_t vl) {
  return vsseg3e16_v_u16m2_m(mask, base, v0, v1, v2, vl);
}
