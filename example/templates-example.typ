#import "@local/article:1.0.0": *
// #import "@local/book:1.0.0": *

#show: article.with(
// #show: book.with(
  title: "标题",
  authors: "作者1, 作者2, 作者3",
  date: "2024-11-27",

  abstract: [摘要内容。],
  // abstract: none,

  keywords: (
    "关键词1",
    "关键词2",
  ),
  // keywords:(),

  bibliography-file: bibliography("refs.bib"),
)

= 第一章
第一章的内容

$ F = m a $ <eq1>
// #h(2em)@eq1 中$F$为外力。
@eq1 中$F$为外力。

#figure(
image("images/test1.png", width: 30%),
caption: [图片名称],
)<i1>

#figure(
    grid(
        columns: (1fr,)*2, row-gutter: 2mm, column-gutter: 1mm,
        image("images/test1.png",width: 4cm),
        image("images/test1.png",width: 4cm),
        "(a) image 1", "(b) image 2"
    ),
    caption: [图片名称]
)<i2>

#figure(
    grid(
        columns: (1fr,)*3, row-gutter: 2mm, column-gutter: 1mm,
        image("images/test1.png",width: 4cm),
        image("images/test1.png",width: 4cm),
        image("images/test1.png",width: 4cm),
        "(a) image 1", "(b) image 2","(c) image 3",
        image("images/test1.png",width: 4cm),
        image("images/test1.png",width: 4cm),
        image("images/test1.png",width: 4cm),
        "(d) image 4","(e) image 5","(f) image 6"
    ),
    caption: [图片名称]
)<i3>

= 第二章
== 小节
第二章内容

= 第三章
第三章内容

#figure(
    caption: [表格名称],
    table(
        // columns: 2,
        columns: (5cm,5cm),
        align: center + horizon,
        stroke:none,
        toprule,
        table.header(
            [Name], [Made public]
        ),
        midrule,
        [Typst], [2023],
        [LaTeX], [1984],
        bottomrule,
    ),
)<t1>

@i1、@i2 和@i3 表明了XXX，数据见@t1。

XXX@ma@ma2023@zj2017@HKCB201905003 说的对，XXXX@example2025 也说的很对。
