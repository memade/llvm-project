// RUN: %clang_cc1 %s -O0 -ffake-address-space-map -emit-llvm -o - | FileCheck %s --check-prefixes=CHECK,SPIR
// RUN: %clang_cc1 %s -O0 -cl-std=CL3.0 -cl-ext=-all -ffake-address-space-map -emit-llvm -o - | FileCheck %s --check-prefixes=CHECK,SPIR
// RUN: %clang_cc1 %s -O0 -cl-std=clc++2021 -cl-ext=-all -ffake-address-space-map -emit-llvm -o - | FileCheck %s --check-prefixes=CHECK,SPIR
// RUN: %clang_cc1 %s -O0 -DCL20 -cl-std=CL2.0 -ffake-address-space-map -emit-llvm -o - | FileCheck %s --check-prefixes=CL20,CL20SPIR
// RUN: %clang_cc1 %s -O0 -triple amdgcn-amd-amdhsa -emit-llvm -o - | FileCheck --check-prefixes=CHECK,AMDGCN %s
// RUN: %clang_cc1 %s -O0 -triple amdgcn-amd-amdhsa -cl-std=CL3.0 -emit-llvm -o - | FileCheck --check-prefixes=CHECK,AMDGCN %s
// RUN: %clang_cc1 %s -O0 -triple amdgcn-amd-amdhsa -DCL20 -cl-std=CL2.0 -emit-llvm -o - | FileCheck %s --check-prefixes=CL20,CL20AMDGCN
// RUN: %clang_cc1 %s -O0 -triple amdgcn-mesa-mesa3d -emit-llvm -o - | FileCheck --check-prefixes=CHECK,AMDGCN %s
// RUN: %clang_cc1 %s -O0 -triple amdgcn-mesa-mesa3d -cl-std=CL3.0 -emit-llvm -o - | FileCheck --check-prefixes=CHECK,AMDGCN %s
// RUN: %clang_cc1 %s -O0 -triple r600-- -emit-llvm -o - | FileCheck --check-prefixes=CHECK,AMDGCN %s
// RUN: %clang_cc1 %s -O0 -triple r600-- -emit-llvm -cl-std=CL3.0 -o - | FileCheck --check-prefixes=CHECK,AMDGCN %s

// SPIR: %struct.S = type { i32, i32, ptr }
// CL20SPIR: %struct.S = type { i32, i32, ptr addrspace(4) }
struct S {
  int x;
  int y;
  int *z;
};

// CL20-DAG: @g_extern_var = external {{(dso_local )?}}addrspace(1) global float
// CL20-DAG: @l_extern_var = external {{(dso_local )?}}addrspace(1) global float
// CL20-DAG: @test_static.l_static_var = internal addrspace(1) global float 0.000000e+00
// CL20-DAG: @g_static_var = internal addrspace(1) global float 0.000000e+00

#ifdef CL20
// CL20-DAG: @g_s = {{(common )?}}{{(dso_local )?}}addrspace(1) global %struct.S zeroinitializer
struct S g_s;
#endif

// SPIR: ptr %arg
// AMDGCN: ptr addrspace(5) %arg
void f__p(__private int *arg) {}

// CHECK: ptr addrspace(1) %arg
void f__g(__global int *arg) {}

// CHECK: ptr addrspace(3) %arg
void f__l(__local int *arg) {}

// SPIR: ptr addrspace(2) %arg
// AMDGCN: ptr addrspace(4) %arg
void f__c(__constant int *arg) {}

// SPIR: ptr %arg
// AMDGCN: ptr addrspace(5) %arg
void fp(private int *arg) {}

// CHECK: ptr addrspace(1) %arg
void fg(global int *arg) {}

// CHECK: ptr addrspace(3) %arg
void fl(local int *arg) {}

// SPIR: ptr addrspace(2) %arg
// AMDGCN: ptr addrspace(4) %arg
void fc(constant int *arg) {}

// SPIR: ptr addrspace(5) %arg
// AMDGCN: ptr addrspace(1) %arg
void fd(__attribute__((opencl_global_device)) int *arg) {}

// SPIR: ptr addrspace(6) %arg
// AMDGCN: ptr addrspace(1) %arg
void fh(__attribute__((opencl_global_host)) int *arg) {}

#ifdef CL20
int i;
// CL20-DAG: @i = {{(dso_local )?}}addrspace(1) global i32 0
int *ptr;
// CL20SPIR-DAG: @ptr = {{(common )?}}{{(dso_local )?}}addrspace(1) global ptr addrspace(4) null
// CL20AMDGCN-DAG: @ptr = {{(dso_local )?}}addrspace(1) global ptr null
#endif

// SPIR: ptr noundef %arg
// AMDGCN: ptr addrspace(5) noundef %arg
// CL20SPIR-DAG: ptr addrspace(4) noundef %arg
// CL20AMDGCN-DAG: ptr noundef %arg
void f(int *arg) {

  int i;
// SPIR: %i = alloca i32,
// AMDGCN: %i = alloca i32{{.*}}addrspace(5)
// CL20SPIR-DAG: %i = alloca i32,
// CL20AMDGCN-DAG: %i = alloca i32{{.*}}addrspace(5)

#ifdef CL20
  static int ii;
// CL20-DAG: @f.ii = internal addrspace(1) global i32 0
#endif
}

typedef int int_td;
typedef int *intp_td;
// SPIR: define {{(dso_local )?}}void @{{.*}}test_typedef{{.*}}(ptr addrspace(1) noundef %x, ptr addrspace(2) noundef %y, ptr noundef %z)
void test_typedef(global int_td *x, constant int_td *y, intp_td z) {
  *x = *y;
  *z = 0;
}

// SPIR: define {{(dso_local )?}}void @{{.*}}test_struct{{.*}}()
void test_struct() {
  // SPIR: %ps = alloca ptr
  // CL20SPIR: %ps = alloca ptr addrspace(4)
  struct S *ps;
  // SPIR: store i32 0, ptr %x
  // CL20SPIR: store i32 0, ptr addrspace(4) %x
  ps->x = 0;
#ifdef CL20
  // CL20SPIR: store i32 0, ptr addrspace(1) @g_s
  g_s.x = 0;
#endif
}

// SPIR-LABEL: define {{(dso_local )?}}void @{{.*}}test_void_par{{.*}}()
void test_void_par(void) {}

// On ppc64 returns signext i32.
// SPIR-LABEL: define{{.*}} i32 @{{.*}}test_func_return_type{{.*}}()
int test_func_return_type(void) {
  return 0;
}

#ifdef CL20
extern float g_extern_var;

// CL20-LABEL: define {{.*}}void @test_extern(
kernel void test_extern(global float *buf) {
  extern float l_extern_var;
  buf[0] += g_extern_var + l_extern_var;
}

static float g_static_var;

// CL20-LABEL: define {{.*}}void @test_static(
kernel void test_static(global float *buf) {
  static float l_static_var;
  buf[0] += g_static_var + l_static_var;
}

#endif
