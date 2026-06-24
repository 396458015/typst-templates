# Typst Template

适用于课程报告、科研论文和技术文档的 Typst 中文模板。

## 特性

* 中文排版（宋体 + Times New Roman）
* 图、表、公式自动编号
* 三线表支持
* 可选章节编号
* 可选 § 风格一级标题
* 可选自动目录
* 目录页不显示页码，正文从 1 开始计数
* 支持 GB/T 7714 参考文献
* 支持 `gb7714-bilingual`

---

## 安装

参考 Typst 官方文档：

https://github.com/typst/packages#local-packages

将模板放置于：

```text
C:\Users\<用户名>\AppData\Roaming\typst\packages\local\template\1.0.0
```

目录结构：

```text
template
└── 1.0.0
    ├── template.typ
    └── typst.toml
```

```toml
[package]
name = "template"
version = "1.0.0"
entrypoint = "template.typ"
authors = ["Maxl"]
description = "A Typst template for reports and papers."
```

---

## 使用

导入模板：

```typst
#import "@local/template:1.0.0": *
```

基本示例：

```typst
#import "@local/template:1.0.0": *

#show: template.with(
  title: "标题",
  authors: "作者",
  date: "2026-01-01",
)

= 第一章

正文内容
```

---

## 模板参数

```typst
#show: template.with(
  chapter-numbering: false, // 图表公式编号是否关联章节
  section-symbol: false,    // 一级标题是否使用 §
  outline-enable: true,     // 是否生成目录

  title: "标题",
  authors: "作者",
  date: "2026-01-01",

  abstract: [摘要内容],
  keywords: ("关键词1", "关键词2"),
)
```

| 参数                  | 说明              |
| ------------------- | --------------- |
| `chapter-numbering` | 图、表、公式编号是否关联章节  |
| `section-symbol`    | 一级标题显示为 `§ 第一章` |
| `outline-enable`    | 自动生成目录          |

---

## 参考文献

导入：

```typst
#import "@local/gb7714-bilingual:0.2.3":
  init-gb7714,
  gb7714-bibliography,
  multicite
```

初始化：

```typst
#show: init-gb7714.with(
  read("ref.bib"),
  style: "numeric",
  version: "2025",
)
```

引用：

```typst
@ma2023

#multicite[@ma2023]

#multicite[@ma2023, @zj2017]
```

生成参考文献：

```typst
#pagebreak()
#gb7714-bibliography()
```

---

## gb7714-bilingual 0.2.3 空白页问题

部分情况下，`gb7714-bilingual 0.2.3` 会导致 PDF 末尾出现空白页。

修改文件：

```text
gb7714-bilingual/src/api.typ
```

原代码：

```typst
hide(place(bibliography(bytes(bib-content), title: none)))
```

### 方案一（稳定）

修改为：

```typst
// hide(place(bibliography(bytes(bib-content), title: none)))
```

此时不能使用：

```typst
@ma2023
```

全文需统一使用：

```typst
#multicite[@ma2023]
#multicite[@ma2023, @zj2017]
```

### 方案二（推荐）

修改为：

```typst
bibliography(bytes(bib-content), title: none)
```

同时支持：

```typst
@ma2023
#multicite[@ma2023]
#multicite[@ma2023, @zj2017]
```

并可消除 PDF 末尾空白页。

---

## License

MIT License
