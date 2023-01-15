// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64 -target-feature +zksh -emit-llvm %s -o - \
// RUN:     | FileCheck %s  -check-prefix=RV64ZKSH

// RV64ZKSH-LABEL: @sm3p0(
// RV64ZKSH-NEXT:  entry:
// RV64ZKSH-NEXT:    [[RS1_ADDR:%.*]] = alloca i64, align 8
// RV64ZKSH-NEXT:    store i64 [[RS1:%.*]], ptr [[RS1_ADDR]], align 8
// RV64ZKSH-NEXT:    [[TMP0:%.*]] = load i64, ptr [[RS1_ADDR]], align 8
// RV64ZKSH-NEXT:    [[TMP1:%.*]] = call i64 @llvm.riscv.sm3p0.i64(i64 [[TMP0]])
// RV64ZKSH-NEXT:    ret i64 [[TMP1]]
//
long sm3p0(long rs1) {
  return __builtin_riscv_sm3p0(rs1);
}


// RV64ZKSH-LABEL: @sm3p1(
// RV64ZKSH-NEXT:  entry:
// RV64ZKSH-NEXT:    [[RS1_ADDR:%.*]] = alloca i64, align 8
// RV64ZKSH-NEXT:    store i64 [[RS1:%.*]], ptr [[RS1_ADDR]], align 8
// RV64ZKSH-NEXT:    [[TMP0:%.*]] = load i64, ptr [[RS1_ADDR]], align 8
// RV64ZKSH-NEXT:    [[TMP1:%.*]] = call i64 @llvm.riscv.sm3p1.i64(i64 [[TMP0]])
// RV64ZKSH-NEXT:    ret i64 [[TMP1]]
//
long sm3p1(long rs1) {
  return __builtin_riscv_sm3p1(rs1);
}