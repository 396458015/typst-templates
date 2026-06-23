# Typst Template

一个适用于课程报告、科研论文、技术文档的 Typst 中文模板。

## 功能特性

* 中文排版（宋体 + Times New Roman）
* 图、表、公式自动编号
* 三线表支持
* 可选章节编号
* 可选 § 风格一级标题
* 可选自动生成目录
* 目录页不显示页码
* 正文页码自动从 1 开始计数
* 支持 GB/T 7714 参考文献
* 支持 `gb7714-bilingual` 双语参考文献包

---

# 安装

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

其中：

```toml
[package]
name = "template"
version = "1.0.0"
entrypoint = "template.typ"
authors = ["Maxl"]
description = "A Typst template for reports and papers."
```

---

# 导入模板

```typst
#import "@local/template:1.0.0": *
```

---

# 基本使用

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

# 模板参数

## 章节编号

开启章节关联编号：

```typst
#show: template.with(
  chapter-numbering: true,
)
```

效果：

```text
图 1-1
表 1-1
式 (1-1)
```

关闭：

```typst
#show: template.with(
  chapter-numbering: false,
)
```

效果：

```text
图 1
表 1
式 (1)
```

---

## § 风格一级标题

开启：

```typst
#show: template.with(
  section-symbol: true,
)
```

效果：

```text
§ 第一章
§ 第二章
```

关闭：

```typst
#show: template.with(
  section-symbol: false,
)
```

效果：

```text
1 第一章
2 第二章
```

---

## 目录

开启目录：

```typst
#show: template.with(
  outline-enable: true,
)
```

特点：

* 自动生成目录
* 目录标题居中显示
* 目录页不显示页码
* 正文从第 1 页开始重新计数

关闭目录：

```typst
#show: template.with(
  outline-enable: false,
)
```

---

# 参考文献

推荐配合 `gb7714-bilingual` 使用。

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
  read("refs.bib"),
  style: "numeric",
  version: "2025",
)
```

正文引用：

```typst
#multicite[@ma2023]

#multicite[@ma2023, @zj2017]
```

生成参考文献：

```typst
#pagebreak()
#gb7714-bibliography()
```

---

# 示例

```typst
#import "@local/template:1.0.0": *
#import "@local/gb7714-bilingual:0.2.3":
  init-gb7714,
  gb7714-bibliography,
  multicite

#show: init-gb7714.with(
  read("refs.bib"),
  style: "numeric",
  version: "2025",
)

#show: template.with(
  chapter-numbering: false,
  section-symbol: false,
  outline-enable: true,

  title: "标题",
  authors: "作者1, 作者2",
  date: "2026-01-01",

  abstract: [摘要内容。],

  keywords: (
    "关键词1",
    "关键词2",
  ),
)

= 第一章

正文内容。

#multicite[@ma2023]

#pagebreak()
#gb7714-bibliography()
```

---

# 关于 gb7714-bilingual 0.2.3

使用 `gb7714-bilingual 0.2.3` 时，部分文档在 PDF 末尾可能会出现额外空白页。

经测试，问题来源于包内：

```text
gb7714-bilingual/
└── src/
    └── api.typ
```

中的如下代码：

```typst
hide(place(bibliography(bytes(bib-content), title: none)))
```

该代码用于支持 Typst 原生 `@key` 引用语法。

可修改为：

```typst
bibliography(bytes(bib-content), title: none)
```

修改位置：

```text
C:\Users\<User>\AppData\Roaming\typst\packages\local\gb7714-bilingual\0.2.3\src\api.typ
```

修改后经测试：

* 保留 `@key` 引用功能；
* 保留 `#multicite[...]` 引用功能；
* 参考文献正常生成；
* PDF 末尾不再产生额外空白页。

---

# License

MIT License
