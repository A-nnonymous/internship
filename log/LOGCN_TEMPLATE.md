# 工作日记

> 此日志从8日由潘炤伍开始记录

## ***七月第四周至...月...周***

### ***任务***  

- #### 短期

1. - [x] 追溯序列比对算法的起源和发展，进行文献调研与分析

2. - [x] 继续学完makefile的语法

3. - [x] 整理C、C++工具书以待使用

4. - [x] 部署FPGA集成开发环境并测试（Quartus）

5. - [x] 测试 Arria 10 GX ES 是否完好可用

- #### 长期

1. [ +++++++++=========== ] 全面地阅读序列比对算法近些年发展的成果，试着找出可行方向和陷阱

2. [ +=================== ] 阅读BWA-MEM的源代码

3. [ +++================= ] 阅读BWA-MEM2的源代码

4. [ +=================== ] 阅读有关在Arria 10 平台上实现算法异构加速相关的官方手册和补充资料

### ***结果***
  
#### **短期1-起源追溯**

通过在WOS数据库中搜索 ***"((((TI=(sequence alignment)) OR TI=(read alignment)) NOT TI=(multiple)) NOT TI=(phylogenetic)) AND TS=(algorithm)sequence alignment"*** ，获得了900多条文章条目，并在**histcite**中进行了引文分析，150篇最有影响力的作品的引文图（按当地引文分数排序）如下所示：
![test.](../pics/out.png)
   在这些文章中，我选择了若干篇在引文网络中有着最高局部引用得分文章进行调研，被选择的论文列表如下：

- [ ] V. I. Levenshtein, “Binary Codes Capable of Correcting Deletions, Insertions, and Reversals,” Soviet Physics Doklady, vol. 10, pp. 707–710, Nov. 1965.
  > 基因比对算法的最初灵感竟然来源于通信领域，难以想象
- [ ]  S. B. Needleman and C. D. Wunsch, “A general method applicable to the search for similarities in the amino acid sequence of two proteins,” Journal of Molecular Biology, vol. 48, no. 3, pp. 443–453, Mar. 1970, doi: 10.1016/0022-2836(70)90057-4.

- [ ] M. S. Waterman, T. F. Smith, and W. A. Beyer, “Some biological sequence metrics,” Advances in Mathematics, vol. 20, no. 3, pp. 367–387, Jun. 1976, doi: 10.1016/0001-8708(76)90202-4.

- [ ] T. F. Smith, M. S. Waterman, and W. M. Fitch, “Comparative biosequence metrics,” J Mol Evol, vol. 18, no. 1, pp. 38–46, Jan. 1981, doi: 10.1007/BF01733210.

- [ ] T. F. Smith and M. S. Waterman, “Comparison of biosequences,” Advances in Applied Mathematics, vol. 2, no. 4, pp. 482–489, Dec. 1981, doi: 10.1016/0196-8858(81)90046-4.

- [ ] W. M. Fitch and T. F. Smith, “Optimal sequence alignments,” Proceedings of the National Academy of Sciences, vol. 80, no. 5, pp. 1382–1386, Mar. 1983, doi: 10.1073/pnas.80.5.1382.

- [ ] M. S. Waterman, “Efficient sequence alignment algorithms,” Journal of Theoretical Biology, vol. 108, no. 3, pp. 333–337, Jun. 1984, doi: 10.1016/S0022-5193(84)80037-5.

- [ ] M. A. S. Saqi and M. J. E. Sternberg, “A simple method to generate non-trivial alternate alignments of protein sequences,” Journal of Molecular Biology, vol. 219, no. 4, pp. 727–732, Jun. 1991, doi: 10.1016/0022-2836(91)90667-U.

- [ ] J. Thorne, H. Kishino, and J. Felsenstein, “An Evolutionary Model for Maximum Likelihood Alignment of DNA Sequences,” Journal of Molecular Evolution, vol. 33, pp. 114–124, Aug. 1991, doi: 10.1007/BF02193625.

- [ ] Zuker, “Suboptimal sequence alignment in molecular biology: Alignment with error analysis,” Journal of Molecular Biology, vol. 221, no. 2, pp. 403–420, Sep. 1991, doi: 10.1016/0022-2836(91)80062-Y.

- [ ] M. Schöniger and M. S. Waterman, “A local algorithm for DNA sequence alignment with inversions,” Bltn Mathcal Biology, vol. 54, no. 4, pp. 521–536, Jul. 1992, doi: 10.1007/BF02459633.

- [ ] F. Corpet and B. Michot, “RNAlign program: alignment of RNA sequences using both primary and secondary structures,” Bioinformatics, vol. 10, no. 4, pp. 389–399, Jul. 1994, doi: 10.1093/bioinformatics/10.4.389.

- [ ] C. Notredame and D. G. Higgins, “SAGA: Sequence Alignment by Genetic Algorithm,” Nucleic Acids Res, vol. 24, no. 8, pp. 1515–1524, Apr. 1996, doi: 10.1093/nar/24.8.1515.

- [ ] M. S. Gelfand, A. A. Mironov, and P. A. Pevzner, “Gene recognition via spliced sequence alignment.,” Proc Natl Acad Sci U S A, vol. 93, no. 17, pp. 9061–9066, Aug. 1996.

- [ ] R. Hughey, “Parallel hardware for sequence comparison and alignment,” Bioinformatics, vol. 12, no. 6, pp. 473–479, Dec. 1996, doi: 10.1093/bioinformatics/12.6.473.

- [ ] S. Rajko and S. Aluru, “Space and time optimal parallel sequence alignments,” IEEE Transactions on Parallel and Distributed Systems, vol. 15, no. 12, pp. 1070–1081, 2004, doi: 10.1109/TPDS.2004.86.

- [ ] R. Koike, K. Kinoshita, and A. Kidera, “Probabilistic description of protein alignments for sequences and structures,” Proteins, vol. 56, no. 1, pp. 157–166, Jul. 2004, doi: 10.1002/prot.20067.

- [ ] T. D. Pham and J. Zuegg, “A probabilistic measure for alignment-free sequence comparison,” Bioinformatics, vol. 20, no. 18, pp. 3455–3461, Dec. 2004, doi: 10.1093/bioinformatics/bth426.

- [ ] A. N. Arslan, “Regular expression constrained sequence alignment,” Journal of Discrete Algorithms, vol. 5, no. 4, pp. 647–661, Dec. 2007, doi: 10.1016/j.jda.2007.01.003.

- [ ] G. Lunter, A. Rocco, N. Mimouni, A. Heger, A. Caldeira, and J. Hein, “Uncertainty in homology inferences: Assessing and improving genomic sequence alignment,” Genome Res., vol. 18, no. 2, pp. 298–309, Jan. 2008, doi: 10.1101/gr.6725608.

- [ ] V. Polyanovsky, M. A. Roytberg, and V. G. Tumanyan, “Reconstruction of genuine pair-wise sequence alignment,” J Comput Biol, vol. 15, no. 4, pp. 379–391, May 2008, doi: 10.1089/cmb.2007.0145.
  > 文中使用“进化模型”的先验知识，人工制造了一些序列以测试比对算法的质量，提供有关比对理论本身发展的见解。

- [ ] K. Benkrid, Y. Liu, and A. Benkrid, “A Highly Parameterized and Efficient FPGA-Based Skeleton for Pairwise Biological Sequence Alignment,” IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 17, no. 4, pp. 561–570, Apr. 2009, doi: 10.1109/TVLSI.2008.2005314.
  > 文中开发了一个跨平台的加速框架，使用FPGA构造了一个可以灵活调整参数的比对专用硬件。 ***什么是Handel-C？还流行吗？***

- [ ] R. Li et al., “SOAP2: An improved ultrafast tool for short read alignment,” Bioinformatics (Oxford, England), vol. 25, pp. 1966–7, Jul. 2009, doi: 10.1093/bioinformatics/btp336.
  > 著名对齐工具SOAP2的论文，与BWA密切相关***需要精读***

- [ ] H. Li and R. Durbin, “Fast and accurate long-read alignment with Burrows-Wheeler transform,” Bioinformatics, vol. 26, no. 5, pp. 589–595, Mar. 2010, doi: 10.1093/bioinformatics/btp698.
  > 著名对齐工具BWA的论文***需要精读。***

- [ ] N. Sebastião, N. Roma, and P. Flores, “Hardware accelerator architecture for simultaneous short-read DNA sequences alignment with enhanced traceback phase,” Microprocessors and Microsystems, vol. 36, no. 2, pp. 96–109, Mar. 2012, doi: 10.1016/j.micpro.2011.05.003.
  > 使用FPGA加速SW算法及其回溯阶段，用片上的软核当baseline进行了性能对比，写的很细，有参考价值。 **高价值**

- [ ] B. Langmead and S. L. Salzberg, “Fast gapped-read alignment with Bowtie 2,” Nat Methods, vol. 9, no. 4, Art. no. 4, Apr. 2012, doi: 10.1038/nmeth.1923.
  > 著名对齐工具Bowtie2的论文***需要精读。***

- [ ] M. Abbasi, L. Paquete, A. Liefooghe, M. Pinheiro, and P. Matias, “Improvements on bicriteria pairwise sequence alignment: algorithms and applications,” Bioinformatics, vol. 29, no. 8, pp. 996–1003, Apr. 2013, doi: 10.1093/bioinformatics/btt098.
  > 使用数学和博弈论（？）方法描述了序列比对中的两个不同优化问题。

- [ ] N. Neves et al., “BioBlaze: Multi-core SIMD ASIP for DNA sequence alignment,” in 2013 IEEE 24th International Conference on Application-Specific Systems, Architectures and Processors, Jun. 2013, pp. 241–244. doi: 10.1109/ASAP.2013.6567581.
  > 使用 FPGA 设计了一个专用处理器，同时利用了细粒度和粗粒度并行性。基于 GCC 的编译框架重新设计了一个指令集以简化编程。 **硬核**

- [x] S. Horwege et al., “Spaced words and kmacs: fast alignment-free sequence comparison based on inexact word matches,” Nucleic Acids Research, vol. 42, no. W1, pp. W7–W11, Jul. 2014, doi: 10.1093/nar/gku398.
  > 非比对算法，引入了许多先验假设，仅仅用于拓宽视野

- [ ] L. Ji, X. Pu, H. Qu, and G. Liu, “One-dimensional pairwise CNN for the global alignment of two DNA sequences,” Neurocomputing, vol. 149, pp. 505–514, Feb. 2015, doi: 10.1016/j.neucom.2014.08.023.
  > ***与热门的卷积神经网络不同，此处CNN 代表细胞神经网络*** 文中提出的工作表明，在这个冷门的硬件算法中，全局序列比对的时间复杂度可以降低到**线性时间**。 ***包括全局比对、回溯和相似度计算，可以考虑用FPGA进行实验验证。***

- [x] Y. Liu and B. Schmidt, “GSWABE: Faster GPU-accelerated sequence alignment with optimal alignment retrieval for short DNA sequences,” Concurrency and Computation Practice and Experience, vol. 27, Mar. 2015, doi: 10.1002/cpe.3371.
  > 设计了一种使用GPU的 all-to-all 长度的比对算法，包括回溯。还提出了一种比对中对任务进行Tiling划分的方法。

- [ ] B. Liu, H. Guo, M. Brudno, and Y. Wang, “deBGA: read alignment with de Bruijn graph-based seed and extension,” Bioinformatics, vol. 32, no. 21, pp. 3224–3232, Nov. 2016, doi: 10.1093/bioinformatics/btw371.
  > 使用de bruijn图重建参考基因组，并与基于图的种子和扩展算法对齐，大大减少了重复区域带来的计算负担 ***de Bruijn图组装的算法很经典，但用于建立基因组索引并用其比对还未听说过***

- [ ] R. Kaplan, L. Yavits, R. Ginosar, and U. Weiser, “A Resistive CAM Processing-in-Storage Architecture for DNA Sequence Alignment,” IEEE Micro, vol. 37, no. 4, pp. 20–28, 2017, doi: 10.1109/MM.2017.3211121.
  > 文中提出了一种使用按内容寻址的存算一体结构（非冯诺依曼体系）无论序列长度如何，它在固定周期中用很高的能效比找到匹配得分。但尽管对FPGA的设计来说具有一定参考意义， ***其目前的工作并不包括回溯（输出最佳比对）过程***

- [ ] H. Li, “Minimap2: pairwise alignment for nucleotide sequences,” Bioinformatics, vol. 34, no. 18, pp. 3094–3100, Sep. 2018, doi: 10.1093/bioinformatics/bty191.
  > 一种通用的比对算法，使用分割read将各种长度的核苷酸读序映射到参考基因组。具有跳过序列比对中的重复区域的能力，这是之前short read alignment算法的瓶颈。

- [ ] M. Alser, H. Hassan, A. Kumar, O. Mutlu, and C. Alkan, “Shouji: a fast and efficient pre-alignment filter for sequence alignment,” Bioinformatics, vol. 35, no. 21, pp. 4255–4263, Nov. 2019, doi: 10.1093/bioinformatics/btz234.
  > 基于预比对筛选的硬件/软件协同设计短序列比对加速算法。文中的filter算法在使用计算成本高昂的DP算法之前，加了一层低复杂度的启发式算法快速消除一些不可能匹配的序列，纵使“不可能”是作者的一种先验假设。

#### **长期任务 7月30日阶段性总结**  

追溯至其起源，不难发现序列比对算法中最有影响力的工作，都是在规避或优化使用动态规划算法方面付出了巨大的努力。

为了避免DP的使用，精心调整的Seed-Extension操作、全局比对中启发式的“有界编辑距离”和精心设计的全文索引构成了当今序列比对算法的主流框架，但清除冗余次优匹配仍然是Seeding阶段的一个巨大问题，虽然存在其他方法，如预比对或基于图的比对（之前常用于de novo组装），但其是否能够被有效调优、比对的准确性仍有待讨论。

在优化（或加速）DP内核时，选择了各种硬件来迎合此计算任务的特点：通用处理器中的SIMD指令、GPGPU中的SIMT执行、FPGA中的波动阵列、细胞神经网络甚至自定义指令集和存算一体结构都被用来发掘这个特殊计算任务的内在特征，以最大限度地减少DP中的时间消耗，但Scoring和Backtracking是两个不同的问题，快速回溯通常伴随着较大的内存占用，哪怕是可定制性最强的硬件（如CAM），有关于Backtracking的工作也是欠缺的（可能是故意的？），我猜想，在回溯算法本身发生重大改进之前，这种时间和空间+设计复杂度上的权衡在计算中仍然是不可避免的，至于细胞神经网络那篇文献中对于回溯的特殊优化，之后一定要安排时间尝试验证验证。

截至7月30日，此次回溯所涉及到的文献阅读已经接近完成了一半，大约到了2008年的时间节点，在此之前学术界对动态规划算法、评分矩阵的合理性甚至都存在质疑，尚未有对基因比对流程产生共识，因此产生了许多对DP、评分矩阵合理性的验证（从概率论、最优化角度），以及很多新奇的、昙花一现的比对方法，之后的阅读将会涉及到更久远的文献，也希望它们能给我更多的启发吧。下周的文献阅读中会重点关注几个需要精读的论文，包括SOAP、BWA、minimap，同时开始系统性的从BWA-MEM算法读起，先搁置对MEM2的研读。  

