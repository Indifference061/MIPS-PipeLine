# MIPS-PipeLine
MIPS流水线设计
## 实验内容：
- 仔细阅读教材7.4节(P240-255)内容 
- 完成MIPS流水线处理器设计
- 用教材图7-60(P276)测试代码，测试上述设计 
- 参考《Multicycle Processor.pdf》完成设计、模拟
- 在NEXYS4 DDR板上实现两位正整数加法运算，如12+34=046 
## 实验方案：
### 基础部分：
<br>	1)MIPS指令处理器可以分为程序计数器（计算PC值）、寄存器文件（读取指令中的rs、rt地址进行读写操作）、指令存储器（读取指令）、数据存储器（将计算结果进行存储）4个状态元件。不同的状态元件通过数据通路连接，并使用复用器，进行其他指令的数据拓展。
<br>	2）MIPS指令处理器通过读入instr，并通过真值表进行对应的解析，进行过相应的操作，基础部分的主译码器真值表如下：

<br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/e04d85ff-7729-4a83-8d64-b8a7e33f9d38)


<p>ALU译码器真值表：

<br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/2fd1a385-cf1a-4511-b51f-385900d84be2)


<p>分别使用主译码器和ALU译码器对instr对应位置指令进行译码，产生一个2位的信号aluop，与funct信号决定alucontrol的值，作为alu计算选择信号。
<br>	3）流水线处理器与单周期的区别在于：可以将一条指令分为五个阶段：取值，译码，执行，存储，写回（如果需要），且每个阶段可以在数据不冲突的前提下可以同时进行，每个阶段的所用时间由最慢的阶段决定
<br>下图为流水线的抽象表示：

<br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/e9f1dff0-6aee-4a5d-b72b-c4d6ffa4a8da)

<br>下图为带有数字信号的流水线处理器的原理图：

<br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/9f6b1ca0-00ca-46d1-8c26-5d827c99a295)

<br>冲突：当一条指令所依赖的另一条指令（寄存器结果、跳转分支或者数据、地址等）还没结束，就会产生冲突。
<p>若出现控制冲突，可以采用分时使用控制元件和增加逻辑元件等方法；倘若出现数据冲突，可以通过插入nops、重定向、阻塞三种方式进行解决：
<br>①	插入空操作：把指令向前移动或者插入nop操作
<br>②	重定位：当执行阶段，有rs或者rt与存储或者写回阶段的目的寄存器匹配时，需要重定位，增加源操作数的来源，

  <br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/a0bda27f-f00e-4a99-83de-922c00042a5f)

<br>③	若无法使用重定向（如beq要执行跳转指令时，会改变pc值，已计算出的pc+4值内的指令不能取进指令寄存器），就要通过阻塞处理冲突，设置StallF、StallD ：迫使取指阶段(F)、译码阶段(D)流水寄存器保持原来的值；FlushE (刷新) ：清除执行阶段(E)流水线寄存器的内容，并去掉无效控制信号，以防止更新内存和状态，并增加equalD比较两个操作数是否相等，若相等则跳转并在译码结束确定PC值
<br>下图为处理冲突的流水线处理器原理图

<br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/f109a6ed-6c7e-4ec4-83b6-2f90f436aa47)

<br> 5）设计仿真文件对memfile.dat进行仿真测试。

### 上板部分：
<br>1）需要增加andi指令，就需要在基础的部分，在maindec中增加表示andi的状态，并增加数据通路或者复用器。
<br>各个状态对应control对应参数的赋值
<br>指令 	opc ode 	funct 	regwrite 	regdst 	alusrc 	branch 	Nbranch 	memwrite 	memtoreg 	jump 	aluop 	immsel <br>add 	000 000 	100000 	1 	1 	0 	0 	0 	0 	0 	0 	010 	0 
<br>sub 	000 000 	100010 	1 	1 	0 	0 	0 	0 	0 	0 	010 	0 
<br>and 	000 000 	100100 	1 	1 	0 	0 	0 	0 	0 	0 	010 	0 
<br>or 	  000 000 	100101 	1 	1 	0 	0 	0 	0 	0 	0 	010 	0 
<br>slt 	000 000 	101010 	1 	1 	0 	0 	0 	0 	0 	0 	010 	0 
<br>addi 	001 000 	/ 	    1 	0 	1 	0 	0 	0 	0 	0 	000 	0 
<br>andi 	001 100 	/ 	    1 	0 	1 	0 	0 	0 	0 	0 	100 	1 
<br>ori 	001 101 	/ 	    1 	0 	1 	0 	0 	0 	0 	0 	011 	1 
<br>lw 	  100 011 	/ 	    1 	0 	1 	0 	0 	0 	1 	0 	000 	0 
<br>sw 	  101 011 	/ 	    0 	0 	1 	0 	0 	1 	0 	0 	000 	0 
<br>j 	000 010 	/ 	0 	0 	0 	0 	0 	0 	0 	1 	000 	0 
<br>beq 	000 100 	/ 	0 	0 	0 	1 	0 	0 	0 	0 	001 	0 
<br>bne 	000 101 	/ 	0 	0 	0 	0 	1 	0 	0 	0 	001 	0 

<br>Alu译码器如下：
<br>操作	Aluop	Funct	Alucontrol
<br>Addi	000	/	010
<br>Andi	100	/	000
<br>Add	010	100000	010
<br>Sub	010	100010	110
<br>And	010	100100	000
<br>Or	010	100101	001
<br>Slt	010	101010	111
### IO接口部分
<br>增加IO模块，并用dMemoryDecoder模块将其dmem扩展，包括dmem，IO模块和7段数码管，并进行仿真
<br>原理图如下：

<br>![图片](https://github.com/Indifference061/MIPS-PipeLine/assets/87850383/ce48c754-5146-4f15-8422-bfbeb0a76878)

<br>主要增加了两个IO设备：16位开关输入和七段数码管进行加法结果输出，BTNR和BTNL作为状态端口分别控制数据的输入输出，当BTNR为1时，可输入新数据,  status[1]=1，当BTNL为1时，led已准备好，可输出新数据, status[0]=1。
	在IO模块中传入writeData，并根据控制端口以及addr[7]决定的Write使能对led进行计算结果赋值
	七段数码管的数据由IO传入，由switch[15:0],0000,led[11:0]构成，在数码管上进行分时显示。
