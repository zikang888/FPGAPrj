# 协议规则治理

`protocol_rules.yaml` 是成员 C 维护的唯一协议规则源，覆盖事件 ABI、协议参数、
事务边界、异常判定、触发条件、测试用例和验收阈值。

协作流程：

1. C 修改规则并提升 `rules_version`。
2. A/B 只做影响评估和建议，不直接改变规则含义。
3. C 将 `approval_status` 改为冻结状态并记录文件 SHA-256。
4. A 在 PL 中实现，B/STM32 按同版本产生流量，C 按同版本验收。
5. 任何实现提交都在说明中写明 `rules_version`；冻结后语义变更必须同步提升平台 VERSION。

当前草案对齐仓库已经仿真和构建验证的 ABI：

```text
START = 0x00
DATA  = 0x01
END   = 0x02
ERROR = 0x3F
```

`0x03..0x3E` 保留，新增事件类型必须经过成员 C 审核。
