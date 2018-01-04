1, loadstring功能
A，测试多行编辑器中的字符串，随意修改字符串，检测loadstring的错误信息
B，复制一些多字节和特殊字符，查看loadstring有没有问题
C，从网上复制一下json字符串，查看是否可以加载成功

2, loadFile功能
A，加载不同的文件，查看各错误提示
B，加载通过generator保存的文件
C，校验支持的文件类型

3，generate string
A，将loadfile的parser对象，输出为字符，这个已体现在2中
B，将loadstring加载的字符修改后，重新输出
总体实现为将jsonparser对象的内容借助jsongenerator，输出为字符串

4，generate file
将已有的json文件，通过jsonparser和jsongenerator对象，重新保存为新的文件，借助2功能辅助测试，比较前后文件差异
A，可以重新保存为任何格式的问题
B，可以测试文件被占用情况

5，load picture
主要测试加载不同类型的图片，查看jsonparser和jsongenerator的效率情况，执行结果是否正常

6，generate tree
将多行编辑器中的json字符串，输出到树结构，需要保证loadstring合法