// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-enable-irbuilder -x c++ -emit-llvm %s -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -o - | FileCheck %s --check-prefixes=ALL,IRBUILDER
//  %clang_cc1 -fopenmp -fopenmp-enable-irbuilder -x c++ -std=c++11 -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -emit-pch -o /tmp/t1 %s
//  %clang_cc1 -fopenmp -fopenmp-enable-irbuilder -x c++ -triple x86_64-unknown-unknown -fexceptions -fcxx-exceptions -debug-info-kind=limited -std=c++11 -include-pch /tmp/t1 -verify %s -emit-llvm -o - | FileCheck --check-prefixes=ALL-DEBUG,IRBUILDER-DEBUG %s

// expected-no-diagnostics

// TODO: Teach the update script to check new functions too.

#ifndef HEADER
#define HEADER

// ALL-LABEL: @_Z17nested_parallel_0v(
// ALL-NEXT:  entry:
// ALL-NEXT:    [[OMP_GLOBAL_THREAD_NUM:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
// ALL-NEXT:    br label [[OMP_PARALLEL:%.*]]
// ALL:       omp_parallel:
// ALL-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB1]], i32 0, ptr @_Z17nested_parallel_0v..omp_par.1)
// ALL-NEXT:    br label [[OMP_PAR_OUTLINED_EXIT12:%.*]]
// ALL:       omp.par.outlined.exit12:
// ALL-NEXT:    br label [[OMP_PAR_EXIT_SPLIT:%.*]]
// ALL:       omp.par.exit.split:
// ALL-NEXT:    ret void
//
void nested_parallel_0(void) {
#pragma omp parallel
  {
#pragma omp parallel
    {
    }
  }
}

// ALL-LABEL: @_Z17nested_parallel_1Pfid(
// ALL-NEXT:  entry:
// ALL-NEXT:    [[STRUCTARG14:%.*]] = alloca { ptr, ptr, ptr }, align 8
// ALL-NEXT:    [[R_ADDR:%.*]] = alloca ptr, align 8
// ALL-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// ALL-NEXT:    [[B_ADDR:%.*]] = alloca double, align 8
// ALL-NEXT:    store ptr [[R:%.*]], ptr [[R_ADDR]], align 8
// ALL-NEXT:    store i32 [[A:%.*]], ptr [[A_ADDR]], align 4
// ALL-NEXT:    store double [[B:%.*]], ptr [[B_ADDR]], align 8
// ALL-NEXT:    [[OMP_GLOBAL_THREAD_NUM:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// ALL-NEXT:    br label [[OMP_PARALLEL:%.*]]
// ALL:       omp_parallel:
// ALL-NEXT:    [[GEP_A_ADDR15:%.*]] = getelementptr { ptr, ptr, ptr }, ptr [[STRUCTARG14]], i32 0, i32 0
// ALL-NEXT:    store ptr [[A_ADDR]], ptr [[GEP_A_ADDR15]], align 8
// ALL-NEXT:    [[GEP_B_ADDR16:%.*]] = getelementptr { ptr, ptr, ptr }, ptr [[STRUCTARG14]], i32 0, i32 1
// ALL-NEXT:    store ptr [[B_ADDR]], ptr [[GEP_B_ADDR16]], align 8
// ALL-NEXT:    [[GEP_R_ADDR17:%.*]] = getelementptr { ptr, ptr, ptr }, ptr [[STRUCTARG14]], i32 0, i32 2
// ALL-NEXT:    store ptr [[R_ADDR]], ptr [[GEP_R_ADDR17]], align 8
// ALL-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB1]], i32 1, ptr @_Z17nested_parallel_1Pfid..omp_par.2, ptr [[STRUCTARG14]])
// ALL-NEXT:    br label [[OMP_PAR_OUTLINED_EXIT13:%.*]]
// ALL:       omp.par.outlined.exit13:
// ALL-NEXT:    br label [[OMP_PAR_EXIT_SPLIT:%.*]]
// ALL:       omp.par.exit.split:
// ALL-NEXT:    ret void
//
void nested_parallel_1(float *r, int a, double b) {
#pragma omp parallel
  {
#pragma omp parallel
    {
      *r = a + b;
    }
  }
}

// ALL-LABEL: @_Z17nested_parallel_2Pfid(
// ALL-NEXT:  entry:
// ALL-NEXT:    [[STRUCTARG:%.*]] = alloca { ptr, ptr, ptr }, align 8
// ALL-NEXT:    [[R_ADDR:%.*]] = alloca ptr, align 8
// ALL-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// ALL-NEXT:    [[B_ADDR:%.*]] = alloca double, align 8
// ALL-NEXT:    store ptr [[R:%.*]], ptr [[R_ADDR]], align 8
// ALL-NEXT:    store i32 [[A:%.*]], ptr [[A_ADDR]], align 4
// ALL-NEXT:    store double [[B:%.*]], ptr [[B_ADDR]], align 8
// ALL-NEXT:    [[OMP_GLOBAL_THREAD_NUM:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// ALL-NEXT:    br label [[OMP_PARALLEL:%.*]]
// ALL:       omp_parallel:
// ALL-NEXT:    [[GEP_A_ADDR:%.*]] = getelementptr { ptr, ptr, ptr }, ptr [[STRUCTARG]], i32 0, i32 0
// ALL-NEXT:    store ptr [[A_ADDR]], ptr [[GEP_A_ADDR]], align 8
// ALL-NEXT:    [[GEP_B_ADDR:%.*]] = getelementptr { ptr, ptr, ptr }, ptr [[STRUCTARG]], i32 0, i32 1
// ALL-NEXT:    store ptr [[B_ADDR]], ptr [[GEP_B_ADDR]], align 8
// ALL-NEXT:    [[GEP_R_ADDR:%.*]] = getelementptr { ptr, ptr, ptr }, ptr [[STRUCTARG]], i32 0, i32 2
// ALL-NEXT:    store ptr [[R_ADDR]], ptr [[GEP_R_ADDR]], align 8
// ALL-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB1]], i32 1, ptr @_Z17nested_parallel_2Pfid..omp_par.5, ptr [[STRUCTARG]])
// ALL-NEXT:    br label [[OMP_PAR_OUTLINED_EXIT55:%.*]]
// ALL:       omp.par.outlined.exit55:
// ALL-NEXT:    br label [[OMP_PAR_EXIT_SPLIT:%.*]]
// ALL:       omp.par.exit.split:
// ALL-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A_ADDR]], align 4
// ALL-NEXT:    [[CONV56:%.*]] = sitofp i32 [[TMP0]] to double
// ALL-NEXT:    [[TMP1:%.*]] = load double, ptr [[B_ADDR]], align 8
// ALL-NEXT:    [[ADD57:%.*]] = fadd double [[CONV56]], [[TMP1]]
// ALL-NEXT:    [[CONV58:%.*]] = fptrunc double [[ADD57]] to float
// ALL-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[R_ADDR]], align 8
// ALL-NEXT:    store float [[CONV58]], ptr [[TMP2]], align 4
// ALL-NEXT:    ret void
//
void nested_parallel_2(float *r, int a, double b) {
#pragma omp parallel
  {
    *r = a + b;
#pragma omp parallel
    {
      *r = a + b;
#pragma omp parallel
      {
        *r = a + b;
      }
      *r = a + b;
#pragma omp parallel
      {
        *r = a + b;
      }
      *r = a + b;
    }
    *r = a + b;
  }
  *r = a + b;
}

#endif