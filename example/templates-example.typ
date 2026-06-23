#import "@local/template:1.0.0": *
#import "@local/gb7714-bilingual:0.2.3": init-gb7714, gb7714-bibliography, multicite
#show: init-gb7714.with(read("refs.bib"), style: "numeric", version: "2025")
#show: template.with(
chapter-numbering: false,
section-symbol: false,
outline-enable: false,

    title: "标题",
    // authors: "作者1, 作者2, 作者3",
    // date: "XXXX-XX-XX",

    // abstract: [摘要内容。],
    // keywords: (
    //   "关键词1",
    //   "关键词2",
    // ),
)




= 第一章

第一章的内容。

$ F = m a $ <eq1>

@eq1 中 $F$ 为外力。

#figure(
  image("images/test1.png", width: 30%),
  caption: [图片名称],
)<i1>

#figure(
  grid(
    columns: (1fr,) * 2,
    row-gutter: 2mm,
    column-gutter: 1mm,

    image("images/test1.png", width: 4cm),
    image("images/test1.png", width: 4cm),

    [(a) image 1],
    [(b) image 2],
  ),
  caption: [图片名称],
)<i2>

#figure(
  grid(
    columns: (1fr,) * 3,
    row-gutter: 2mm,
    column-gutter: 1mm,

    image("images/test1.png", width: 4cm),
    image("images/test1.png", width: 4cm),
    image("images/test1.png", width: 4cm),

    [(a) image 1],
    [(b) image 2],
    [(c) image 3],

    image("images/test1.png", width: 4cm),
    image("images/test1.png", width: 4cm),
    image("images/test1.png", width: 4cm),

    [(d) image 4],
    [(e) image 5],
    [(f) image 6],
  ),
  caption: [图片名称],
)<i3>

= 第二章

== 小节

第二章内容。

= 第三章

第三章内容。

#figure(
  caption: [表格名称],
  table(
    columns: (5cm, 5cm),
    align: center + horizon,
    stroke: none,

    toprule,
    table.header([Name], [Made public]),
    midrule,

    [Typst], [2023],
    [LaTeX], [1984],

    bottomrule,
  ),
)<t1>

@i1、@i2 和 @i3 表明了 XXX，数据见 @t1。

已有研究表明，相关问题可参考 #multicite[@ma2023, @zj2017]。

进一步地，文献 #multicite[@HKCB201905003] 也给出了类似结论。

#pagebreak()
#gb7714-bibliography()
