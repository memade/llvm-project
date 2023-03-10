// RUN: mlir-opt -split-input-file -convert-gpu-to-spirv -verify-diagnostics %s -o - | FileCheck %s

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupFAdd <Workgroup> <Reduce> %[[ARG]] : f32
    %reduced = gpu.all_reduce add %arg uniform {} : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformFAdd "Workgroup" "Reduce" %[[ARG]] : f32
    %reduced = gpu.all_reduce add %arg {} : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupIAdd <Workgroup> <Reduce> %[[ARG]] : i32
    %reduced = gpu.all_reduce add %arg uniform {} : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformIAdd "Workgroup" "Reduce" %[[ARG]] : i32
    %reduced = gpu.all_reduce add %arg {} : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupFAdd <Subgroup> <Reduce> %[[ARG]] : f32
    %reduced = gpu.subgroup_reduce add %arg uniform : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformFAdd "Subgroup" "Reduce" %[[ARG]] : f32
    %reduced = gpu.subgroup_reduce add %arg : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupIAdd <Subgroup> <Reduce> %[[ARG]] : i32
    %reduced = gpu.subgroup_reduce add %arg uniform : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformIAdd "Subgroup" "Reduce" %[[ARG]] : i32
    %reduced = gpu.subgroup_reduce add %arg : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.KHR.GroupFMul <Workgroup> <Reduce> %[[ARG]] : f32
    %reduced = gpu.all_reduce mul %arg uniform {} : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformFMul "Workgroup" "Reduce" %[[ARG]] : f32
    %reduced = gpu.all_reduce mul %arg {} : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.KHR.GroupIMul <Workgroup> <Reduce> %[[ARG]] : i32
    %reduced = gpu.all_reduce mul %arg uniform {} : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformIMul "Workgroup" "Reduce" %[[ARG]] : i32
    %reduced = gpu.all_reduce mul %arg {} : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.KHR.GroupFMul <Subgroup> <Reduce> %[[ARG]] : f32
    %reduced = gpu.subgroup_reduce mul %arg uniform : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: f32)
  gpu.func @test(%arg : f32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformFMul "Subgroup" "Reduce" %[[ARG]] : f32
    %reduced = gpu.subgroup_reduce mul %arg : (f32) -> (f32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.KHR.GroupIMul <Subgroup> <Reduce> %[[ARG]] : i32
    %reduced = gpu.subgroup_reduce mul %arg uniform : (i32) -> (i32)
    gpu.return
  }
}

}

// -----

module attributes {
  gpu.container_module,
  spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>
} {

gpu.module @kernels {
  // CHECK-LABEL:  spirv.func @test
  //  CHECK-SAME: (%[[ARG:.*]]: i32)
  gpu.func @test(%arg : i32) kernel
    attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
    // CHECK: %{{.*}} = spirv.GroupNonUniformIMul "Subgroup" "Reduce" %[[ARG]] : i32
    %reduced = gpu.subgroup_reduce mul %arg : (i32) -> (i32)
    gpu.return
  }
}

}
