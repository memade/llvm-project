// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -S -disable-O0-optnone -Werror -o /dev/null %s
#include <arm_sve.h>

// CHECK-LABEL: @test_svundef_s8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 16 x i8> undef
//
// CPP-CHECK-LABEL: @_Z15test_svundef_s8v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> undef
//
svint8_t test_svundef_s8()
{
  return svundef_s8();
}

// CHECK-LABEL: @test_svundef_s16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 8 x i16> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_s16v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> undef
//
svint16_t test_svundef_s16()
{
  return svundef_s16();
}

// CHECK-LABEL: @test_svundef_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 4 x i32> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_s32v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> undef
//
svint32_t test_svundef_s32()
{
  return svundef_s32();
}

// CHECK-LABEL: @test_svundef_s64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 2 x i64> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_s64v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> undef
//
svint64_t test_svundef_s64()
{
  return svundef_s64();
}

// CHECK-LABEL: @test_svundef_u8(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 16 x i8> undef
//
// CPP-CHECK-LABEL: @_Z15test_svundef_u8v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> undef
//
svuint8_t test_svundef_u8()
{
  return svundef_u8();
}

// CHECK-LABEL: @test_svundef_u16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 8 x i16> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_u16v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> undef
//
svuint16_t test_svundef_u16()
{
  return svundef_u16();
}

// CHECK-LABEL: @test_svundef_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 4 x i32> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_u32v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> undef
//
svuint32_t test_svundef_u32()
{
  return svundef_u32();
}

// CHECK-LABEL: @test_svundef_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 2 x i64> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_u64v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> undef
//
svuint64_t test_svundef_u64()
{
  return svundef_u64();
}

// CHECK-LABEL: @test_svundef_f16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 8 x half> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_f16v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 8 x half> undef
//
svfloat16_t test_svundef_f16()
{
  return svundef_f16();
}

// CHECK-LABEL: @test_svundef_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 4 x float> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_f32v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 4 x float> undef
//
svfloat32_t test_svundef_f32()
{
  return svundef_f32();
}

// CHECK-LABEL: @test_svundef_f64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 2 x double> undef
//
// CPP-CHECK-LABEL: @_Z16test_svundef_f64v(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    ret <vscale x 2 x double> undef
//
svfloat64_t test_svundef_f64()
{
  return svundef_f64();
}