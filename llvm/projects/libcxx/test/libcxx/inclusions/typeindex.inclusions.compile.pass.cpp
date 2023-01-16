//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// WARNING: This test was generated by generate_header_inclusion_tests.py
// and should not be edited manually.
//
// clang-format off

// <typeindex>

// Test that <typeindex> includes all the other headers it's supposed to.

#include <typeindex>
#include "test_macros.h"

#if !defined(_LIBCPP_TYPEINDEX)
 #   error "<typeindex> was expected to define _LIBCPP_TYPEINDEX"
#endif
#if TEST_STD_VER > 17 && !defined(_LIBCPP_COMPARE)
 #   error "<typeindex> should include <compare> in C++20 and later"
#endif