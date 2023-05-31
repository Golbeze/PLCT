# syzkaller排错

## debug

为了解决上周的问题，用gdb-multiarch配合qemu的调试选项进行opensbi的debug

通过调试发现opensbi挂起时mcause寄存器值为3，通过查阅文档和结合ai生成信息可以知道是illegal instruction错误

通过学习riscv下的异常反馈机制，了解到可以查看mepc寄存器与mtval寄存器来获取更多异常相关信息

得到发生错误时的pc，恰好为opensbi的next addr，即理论上下一段的内核引导代码位置，且mtval寄存器指示此时pc指向的数据为0

引发了illegal instruction

## 分析与解决方案

通过与其他组员讨论，推测原因为opensbi没有成功将内核加载到指定地址，则此时有两种解决方案

1. 通过qemu的loader device语法强制将内核加载到预期地址
2. 加入uboot层来引导kernel