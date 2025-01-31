// 表格 三线表线条粗细
#let toprule = table.hline(stroke: 0.08em)
#let midrule = table.hline(stroke: 0.05em)
#let bottomrule = toprule

#let book(
    title: "",
    authors: "",
    date: "",
    abstract: none,
    keywords: (),
    bibliography-file: none,
    bibliography-style: "china-national-standard-gb-t-7714-2015-numeric.csl",
    body,
) = {
    set text(lang: "zh")
    set document(author: authors, title: title)

    // 设置页面
    set page(
        paper:"a4",
        margin: (
        top:25.4mm,
        bottom:25.4mm,
        left:25.0mm,
        right:25.0mm
    ),
        numbering:"1/1",
        number-align:right,  // center
    )

    // 设置段落
    set par(
        justify: true,
        first-line-indent: 2em,  // 段前缩进2字符
        leading: 1em,
    )

    // 设置正文格式
    set text(
        font: ("Times New Roman", "SimSun"),
        size:12pt,
        style:"normal",
        weight:"regular",
    )// 14pt-四号字体,12pt-小四号字体,10.5pt-五号字体

    // 标题计数器
    let chaptercounter = counter("chapter")  // 标题计数器
    set heading(numbering: "1.1.1.1")

    show heading: it => [
        #set text(font: ("Times New Roman", "SimSun"))
        #if it.numbering != none {
        // text(rgb("#2196F3"), weight: 500)[#sym.section]
        // h(0.5em)
        text(rgb("#000000"))[#counter(heading).display() ]
    }
        #it.body
        #v(0.1em)
        #if it.level == 1 and it.numbering != none {
        chaptercounter.step()
        counter(math.equation).update(0)
    }
    ]

    // 一级标题样式
    show heading.where(level: 1): it => box(width: 100%)[
      #set align(left)
      #set text(size: 14pt)
      #set heading(numbering: "1.1.1.1 ")
      #it
    ]

    // 标题样式
    show heading: it => box(width: 100%)[
      #set align(left)
      #set text(size: 12pt)
      #set heading(numbering: "1.1.1.1 ")
      #it
    ]

    // 首行缩进
    let fakepar = context {
      let b = par(box())
      b
      v(-measure(b + b).height)
    }
    // show math.equation.where(block: true): it => it + fakepar // 公式后缩进
    show heading: it => it + fakepar // 标题后缩进
    show figure: it => it + fakepar // 图表后缩进
    show enum.item: it => it + fakepar
    show list.item: it => it + fakepar // 列表后缩进

    //公式编号--与章节关联
    set math.equation(
        numbering: (..nums) => (
        context {
        set text(rgb("#0000ff"),font: ("Times New Roman", "SimSun"), size: 12pt)
        numbering("(1-1)", chaptercounter.at(here()).first(), ..nums)
    }
    ),
        supplement:[]
    )

    // 图片编号--与章节关联
    set figure(
        numbering: (..nums) => (
        context {
        set text(rgb("#0000ff"),font: ("Times New Roman", "SimSun"), size: 12pt)
        numbering("1-1", chaptercounter.at(here()).first(), ..nums)
    }
    ),
    )

    show figure.where(kind: image): set figure(supplement: [图])
    show figure.where(kind: table): set figure(supplement: [表])
    show figure.where(kind: table): set figure.caption(position: top)

    // 使用正确的编号与图表标题字体及分隔符
    show figure.caption: set text(font: ("Times New Roman", "SimSun"))
    set figure.caption(separator: " ")
    set math.equation(supplement: [式])


    // 摘要&关键字
    let mkabstruct(abstract, keywords) = {
      if (abstract != none) {
        set par(first-line-indent: 0em,leading: 1.0em)
        v(2pt)
        [#text(font: ("SimHei"))[摘要：]#abstract]  //如果是中文“摘要”
        // [#text(font: ("Times New Roman"))[*Abstract*: ]#abstract]  //如果是英文“Abstract”

        v(1pt)
        if keywords!= () [
          #text(font: ("SimHei"))[关键字：]  //如果是中文“关键字”
          // #text(font: ("Times New Roman"))[*Keywords*: ]  //如果是英文“Keywords”
          #text(font: ("Times New Roman", "SimHei"), keywords.join("；"))
        ]
        v(10pt)
      }
    }

    // pagebreak()
    // counter(page).update(0)
    // outline()
    // pagebreak()

    // 正文
    strong({
      block(text(size: 18pt,font: ("Times New Roman", "SimHei"), title))
      v(4pt)
      text(size: 12pt,font: ("Times New Roman", "SimSun"), authors)
        h(2em)
        text(size: 12pt,font: ("Times New Roman", "SimSun"), date)
    })

    v(10pt)
    mkabstruct(abstract, keywords)

    body

    //  参考文献格式
    if bibliography-file != none {
    set text(font: ("Times New Roman", "SimSun")) //设置参考文献字体
    pagebreak()
    show bibliography: set text(12.0pt)
    set bibliography(title:"References",style: bibliography-style)
    bibliography-file
    }
}
