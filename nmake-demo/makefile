# nmake包含在Visual Studio中
# nmake 工具描述文件，文件保存为ANSI
name=main

# 指定输出文件
exe=$(name).exe
objs=$(name).obj
res=$(name).res

# 命令参数
asm_flag=/c /coff
link_flag=/subsystem:windows

# 输出及依赖关系
$(exe): $(objs) $(res)
	link $(link_flag) /out:$(exe) $(objs) $(res)
$(objs): resource.inc
$(res): manifest.xml

# 默认规则
.asm.obj:
	ml $(asm_flag) $<
.rc.res:
	rc $<

# 清理临时文件
clean:
	del $(objs)
	del $(res)