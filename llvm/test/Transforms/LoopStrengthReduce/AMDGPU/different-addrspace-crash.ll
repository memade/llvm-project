; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: llc < %s | FileCheck %s

target triple = "amdgcn--"

; We need to compile this for a target where we have different address spaces,
; and where pointers in those address spaces have different size.
; E.g. for amdgcn-- pointers in address space 0 are 32 bits and pointers in
; address space 1 are 64 bits.

; We shouldn't crash. Check that we get a loop with the two stores.
;CHECK-LABEL: foo:
;CHECK: [[LOOP_LABEL:.LBB[0-9]+_[0-9]+]]:
;CHECK: buffer_store_dword
;CHECK: buffer_store_dword
;CHECK: s_cbranch_vccnz [[LOOP_LABEL]]

define amdgpu_kernel void @foo() {
entry:
  br label %loop

loop:
  %idx0 = phi i32 [ %next_idx0, %loop ], [ 0, %entry ]
  %0 = getelementptr inbounds i32, ptr addrspace(5) null, i32 %idx0
  %1 = getelementptr inbounds i32, ptr addrspace(1) null, i32 %idx0
  store i32 1, ptr addrspace(5) %0
  store i32 7, ptr addrspace(1) %1
  %next_idx0 = add nuw nsw i32 %idx0, 1
  br label %loop
}
