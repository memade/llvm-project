set(LLVM_LINK_COMPONENTS Support)

add_bolt_tool(merge-fdata
  merge-fdata.cpp

  DISABLE_LLVM_LINK_LLVM_DYLIB

  DEPENDS
  intrinsics_gen
)
set_target_properties(merge-fdata PROPERTIES FOLDER "BOLT")

add_dependencies(bolt merge-fdata)
install(PROGRAMS
  ${CMAKE_BINARY_DIR}/bin/merge-fdata
  DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT bolt
  )

# Emit relocations for BOLT meta test (bolt/test/runtime/meta-merge-fdata.test)
if (BOLT_INCLUDE_TESTS AND UNIX AND NOT APPLE)
  target_link_options(merge-fdata PRIVATE LINKER:--emit-relocs)
endif()
