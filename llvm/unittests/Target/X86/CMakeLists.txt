include_directories(
  ${PROJECT_SOURCE_DIR}/lib/Target/X86
  ${PROJECT_BINARY_DIR}/lib/Target/X86
  )

set(LLVM_LINK_COMPONENTS
  Analysis
  CodeGen
  Core
  MC
  MIRParser
  Support
  Target
  TargetParser
  X86CodeGen
  X86Desc
  X86Info
  )

add_llvm_unittest(X86Tests
  MachineSizeOptsTest.cpp
  )

set_property(TARGET X86Tests PROPERTY FOLDER "Tests/UnitTests/TargetTests")
