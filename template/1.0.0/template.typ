// 表格 三线表线条粗细
#let toprule = table.hline(stroke: 0.08em)
#let midrule = table.hline(stroke: 0.05em)
#let bottomrule = toprule

#let template(
    chapter-numbering: false,
    section-symbol: false,
    outline-enable: false,
    outline-title: "目    录",
    title: "",
    authors: "",
    date: "",
    abstract: none,
    keywords: (),
    body,
) = {
    set text(lang: "zh")
    set document(author: authors, title: title)
    show link: set text(fill: rgb("#0000ff"))

    set page(
        paper: "a4",
        margin: (
          top: 25.4mm,
          bottom: 25.4mm,
          left: 25.0mm,
          right: 25.0mm,
        ),
        numbering: if outline-enable { none } else { "1/1" },
        number-align: right,
    )

    set par(justify: true, first-line-indent: 2em, leading: 1em)

    set text(
        font: ("Times New Roman", "SimSun"),
        size: 12pt,
        style: "normal",
        weight: "regular",
    )

    let chaptercounter = counter("chapter")
    set heading(numbering: "1.1.1.1")

    show heading: it => [
        #set text(font: ("Times New Roman", "SimSun"))

        #if it.level == 1 {
          if section-symbol {
            [#text(style: "italic")[§ ]#it.body]
          } else if it.numbering != none {
            text(rgb("#000000"))[#counter(heading).display() ]
            it.body
          } else {
            it.body
          }
        } else {
          if it.numbering != none {
            text(rgb("#000000"))[#counter(heading).display() ]
          }
          it.body
        }

        #v(0.1em)

        #if it.level == 1 and it.numbering != none {
          chaptercounter.step()
          counter(math.equation).update(0)
        }
    ]

    show heading.where(level: 1): it => box(width: 100%)[
      #set align(left)
      #set text(size: 14pt)
      #it
    ]

    show heading.where(level: 2): it => box(width: 100%)[
      #set align(left)
      #set text(size: 12pt)
      #it
    ]

    show heading.where(level: 3): it => box(width: 100%)[
      #set align(left)
      #set text(size: 12pt)
      #it
    ]

    show heading.where(level: 4): it => box(width: 100%)[
      #set align(left)
      #set text(size: 12pt)
      #it
    ]

    let fakepar = context {
      let b = par(box())
      b
      v(-measure(b + b).height)
    }

    show heading: it => it + fakepar
    show figure: it => it + fakepar
    show enum.item: it => it + fakepar
    show list.item: it => it + fakepar

    set math.equation(
      numbering: (..nums) => (
        context {
          set text(rgb("#0000ff"), font: ("Times New Roman", "SimSun"), size: 12pt)
          if chapter-numbering {
            numbering("(1-1)", chaptercounter.at(here()).first(), ..nums)
          } else {
            numbering("(1)", ..nums)
          }
        }
      ),
      supplement: [],
    )

    set figure(
      numbering: (..nums) => (
        context {
          set text(rgb("#0000ff"), font: ("Times New Roman", "SimSun"), size: 12pt)
          if chapter-numbering {
            numbering("1-1", chaptercounter.at(here()).first(), ..nums)
          } else {
            numbering("1", ..nums)
          }
        }
      ),
    )

    show figure.where(kind: image): set figure(supplement: [图])
    show figure.where(kind: table): set figure(supplement: [表])
    show figure.where(kind: table): set figure.caption(position: top)

    show figure.caption: set text(font: ("Times New Roman", "SimSun"))
    set figure.caption(separator: " ")
    set math.equation(supplement: [式])

    let mkabstruct(abstract, keywords) = {
      if abstract != none {
        set par(first-line-indent: 0em, leading: 1.0em)

        v(2pt)
        [#text(font: ("SimHei"))[摘要：]#abstract]

        v(1pt)
        if keywords != () [
          #text(font: ("SimHei"))[关键字：]
          #text(font: ("Times New Roman", "SimHei"), keywords.join("；"))
        ]

        v(10pt)
      }
    }

    if title != "" or authors != "" or date != "" or abstract != none or keywords != () {
      if title != "" {
        align(center)[
          #text(
            size: 18pt,
            font: ("Times New Roman", "SimHei"),
            weight: "bold",
          )[#title]
        ]
        v(4pt)
      }
    
      if authors != "" or date != "" {
        box(width: 100%)[
          #text(size: 12pt, font: ("Times New Roman", "SimSun"))[
            #authors
            #h(1fr)
            #date
          ]
        ]
        v(10pt)
      }
    
      mkabstruct(abstract, keywords)
    }

    if outline-enable {
      pagebreak()

      align(center)[
        #text(size: 16pt, font: ("Times New Roman", "SimHei"), weight: "bold")[
          #outline-title
        ]
      ]

      v(1em)
      outline(title: none)

      pagebreak()

      counter(page).update(1)
      set page(numbering: "1/1", number-align: right)

      body
    } else {
      body
    }
}
