//===-- PPCSubtarget.h - Define Subtarget for the PPC ----------*- C++ -*--===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares the PowerPC specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_POWERPC_PPCSUBTARGET_H
#define LLVM_LIB_TARGET_POWERPC_PPCSUBTARGET_H

#include "PPCFrameLowering.h"
#include "PPCISelLowering.h"
#include "PPCInstrInfo.h"
#include "llvm/ADT/Triple.h"
#include "llvm/CodeGen/GlobalISel/CallLowering.h"
#include "llvm/CodeGen/GlobalISel/LegalizerInfo.h"
#include "llvm/CodeGen/RegisterBankInfo.h"
#include "llvm/CodeGen/SelectionDAGTargetInfo.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/MC/MCInstrItineraries.h"
#include <string>

#define GET_SUBTARGETINFO_HEADER
#include "PPCGenSubtargetInfo.inc"

// GCC #defines PPC on Linux but we use it as our namespace name
#undef PPC

namespace llvm {
class StringRef;

namespace PPC {
  // -m directive values.
enum {
  DIR_NONE,
  DIR_32,
  DIR_440,
  DIR_601,
  DIR_602,
  DIR_603,
  DIR_7400,
  DIR_750,
  DIR_970,
  DIR_A2,
  DIR_E500,
  DIR_E500mc,
  DIR_E5500,
  DIR_PWR3,
  DIR_PWR4,
  DIR_PWR5,
  DIR_PWR5X,
  DIR_PWR6,
  DIR_PWR6X,
  DIR_PWR7,
  DIR_PWR8,
  DIR_PWR9,
  DIR_PWR10,
  DIR_PWR_FUTURE,
  DIR_64
};
}

class GlobalValue;

class PPCSubtarget : public PPCGenSubtargetInfo {
public:
  enum POPCNTDKind {
    POPCNTD_Unavailable,
    POPCNTD_Slow,
    POPCNTD_Fast
  };

protected:
  /// TargetTriple - What processor and OS we're targeting.
  Triple TargetTriple;

  /// stackAlignment - The minimum alignment known to hold of the stack frame on
  /// entry to the function and which must be maintained by every function.
  Align StackAlignment;

  /// Selected instruction itineraries (one entry per itinerary class.)
  InstrItineraryData InstrItins;

// Bool members corresponding to the SubtargetFeatures defined in tablegen.
#define GET_SUBTARGETINFO_MACRO(ATTRIBUTE, DEFAULT, GETTER)                    \
  bool ATTRIBUTE = DEFAULT;
#include "PPCGenSubtargetInfo.inc"

  /// Which cpu directive was used.
  unsigned CPUDirective;

  bool IsPPC64;
  bool IsLittleEndian;

  POPCNTDKind HasPOPCNTD;

  const PPCTargetMachine &TM;
  PPCFrameLowering FrameLowering;
  PPCInstrInfo InstrInfo;
  PPCTargetLowering TLInfo;
  SelectionDAGTargetInfo TSInfo;

  /// GlobalISel related APIs.
  std::unique_ptr<CallLowering> CallLoweringInfo;
  std::unique_ptr<LegalizerInfo> Legalizer;
  std::unique_ptr<RegisterBankInfo> RegBankInfo;
  std::unique_ptr<InstructionSelector> InstSelector;

public:
  /// This constructor initializes the data members to match that
  /// of the specified triple.
  ///
  PPCSubtarget(const Triple &TT, const std::string &CPU,
               const std::string &TuneCPU, const std::string &FS,
               const PPCTargetMachine &TM);

  /// ParseSubtargetFeatures - Parses features string setting specified
  /// subtarget options.  Definition of function is auto generated by tblgen.
  void ParseSubtargetFeatures(StringRef CPU, StringRef TuneCPU, StringRef FS);

  /// getStackAlignment - Returns the minimum alignment known to hold of the
  /// stack frame on entry to the function and which must be maintained by every
  /// function for this subtarget.
  Align getStackAlignment() const { return StackAlignment; }

  /// getCPUDirective - Returns the -m directive specified for the cpu.
  ///
  unsigned getCPUDirective() const { return CPUDirective; }

  /// getInstrItins - Return the instruction itineraries based on subtarget
  /// selection.
  const InstrItineraryData *getInstrItineraryData() const override {
    return &InstrItins;
  }

  const PPCFrameLowering *getFrameLowering() const override {
    return &FrameLowering;
  }
  const PPCInstrInfo *getInstrInfo() const override { return &InstrInfo; }
  const PPCTargetLowering *getTargetLowering() const override {
    return &TLInfo;
  }
  const SelectionDAGTargetInfo *getSelectionDAGInfo() const override {
    return &TSInfo;
  }
  const PPCRegisterInfo *getRegisterInfo() const override {
    return &getInstrInfo()->getRegisterInfo();
  }
  const PPCTargetMachine &getTargetMachine() const { return TM; }

  /// initializeSubtargetDependencies - Initializes using a CPU, a TuneCPU,  and
  /// feature string so that we can use initializer lists for subtarget
  /// initialization.
  PPCSubtarget &initializeSubtargetDependencies(StringRef CPU,
                                                StringRef TuneCPU,
                                                StringRef FS);

private:
  void initializeEnvironment();
  void initSubtargetFeatures(StringRef CPU, StringRef TuneCPU, StringRef FS);

public:
  /// isPPC64 - Return true if we are generating code for 64-bit pointer mode.
  ///
  bool isPPC64() const;

  // useSoftFloat - Return true if soft-float option is turned on.
  bool useSoftFloat() const {
    if (isAIXABI() && !HasHardFloat)
      report_fatal_error("soft-float is not yet supported on AIX.");
    return !HasHardFloat;
  }

  // isLittleEndian - True if generating little-endian code
  bool isLittleEndian() const { return IsLittleEndian; }

// Getters for SubtargetFeatures defined in tablegen.
#define GET_SUBTARGETINFO_MACRO(ATTRIBUTE, DEFAULT, GETTER)                    \
  bool GETTER() const { return ATTRIBUTE; }
#include "PPCGenSubtargetInfo.inc"

  Align getPlatformStackAlignment() const {
    return Align(16);
  }

  unsigned  getRedZoneSize() const {
    if (isPPC64())
      // 288 bytes = 18*8 (FPRs) + 18*8 (GPRs, GPR13 reserved)
      return 288;

    // AIX PPC32: 220 bytes = 18*8 (FPRs) + 19*4 (GPRs);
    // PPC32 SVR4ABI has no redzone.
    return isAIXABI() ? 220 : 0;
  }

  bool needsSwapsForVSXMemOps() const {
    return hasVSX() && isLittleEndian() && !hasP9Vector();
  }

  POPCNTDKind hasPOPCNTD() const { return HasPOPCNTD; }

  const Triple &getTargetTriple() const { return TargetTriple; }

  bool isTargetELF() const { return TargetTriple.isOSBinFormatELF(); }
  bool isTargetMachO() const { return TargetTriple.isOSBinFormatMachO(); }
  bool isTargetLinux() const { return TargetTriple.isOSLinux(); }

  bool isAIXABI() const { return TargetTriple.isOSAIX(); }
  bool isSVR4ABI() const { return !isAIXABI(); }
  bool isELFv2ABI() const;

  bool is64BitELFABI() const { return  isSVR4ABI() && isPPC64(); }
  bool is32BitELFABI() const { return  isSVR4ABI() && !isPPC64(); }
  bool isUsingPCRelativeCalls() const;

  /// Originally, this function return hasISEL(). Now we always enable it,
  /// but may expand the ISEL instruction later.
  bool enableEarlyIfConversion() const override { return true; }

  /// Scheduling customization.
  bool enableMachineScheduler() const override;
  /// Pipeliner customization.
  bool enableMachinePipeliner() const override;
  /// Machine Pipeliner customization
  bool useDFAforSMS() const override;
  /// This overrides the PostRAScheduler bit in the SchedModel for each CPU.
  bool enablePostRAScheduler() const override;
  AntiDepBreakMode getAntiDepBreakMode() const override;
  void getCriticalPathRCs(RegClassVector &CriticalPathRCs) const override;

  void overrideSchedPolicy(MachineSchedPolicy &Policy,
                           unsigned NumRegionInstrs) const override;
  bool useAA() const override;

  bool enableSubRegLiveness() const override;

  /// True if the GV will be accessed via an indirect symbol.
  bool isGVIndirectSymbol(const GlobalValue *GV) const;

  /// True if the ABI is descriptor based.
  bool usesFunctionDescriptors() const {
    // Both 32-bit and 64-bit AIX are descriptor based. For ELF only the 64-bit
    // v1 ABI uses descriptors.
    return isAIXABI() || (is64BitELFABI() && !isELFv2ABI());
  }

  unsigned descriptorTOCAnchorOffset() const {
    assert(usesFunctionDescriptors() &&
           "Should only be called when the target uses descriptors.");
    return IsPPC64 ? 8 : 4;
  }

  unsigned descriptorEnvironmentPointerOffset() const {
    assert(usesFunctionDescriptors() &&
           "Should only be called when the target uses descriptors.");
    return IsPPC64 ? 16 : 8;
  }

  MCRegister getEnvironmentPointerRegister() const {
    assert(usesFunctionDescriptors() &&
           "Should only be called when the target uses descriptors.");
     return IsPPC64 ? PPC::X11 : PPC::R11;
  }

  MCRegister getTOCPointerRegister() const {
    assert((is64BitELFABI() || isAIXABI()) &&
           "Should only be called when the target is a TOC based ABI.");
    return IsPPC64 ? PPC::X2 : PPC::R2;
  }

  MCRegister getStackPointerRegister() const {
    return IsPPC64 ? PPC::X1 : PPC::R1;
  }

  bool isXRaySupported() const override { return IsPPC64 && IsLittleEndian; }

  bool isPredictableSelectIsExpensive() const {
    return PredictableSelectIsExpensive;
  }

  // Select allocation orders of GPRC and G8RC. It should be strictly consistent
  // with corresponding AltOrders in PPCRegisterInfo.td.
  unsigned getGPRAllocationOrderIdx() const {
    if (is64BitELFABI())
      return 1;
    if (isAIXABI())
      return 2;
    return 0;
  }

  // GlobalISEL
  const CallLowering *getCallLowering() const override;
  const RegisterBankInfo *getRegBankInfo() const override;
  const LegalizerInfo *getLegalizerInfo() const override;
  InstructionSelector *getInstructionSelector() const override;
};
} // End llvm namespace

#endif