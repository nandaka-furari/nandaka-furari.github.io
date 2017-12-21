files
===============
This software is released under the MIT License, see LICENSE.txt

---

このリポジトリでは様々なテキストファイルを集めています。
なるべく多くの人に使えるようなものを置きたいと思っていますが、個人的な物が多いかと思います。
ディレクトリはファイルの種類で分けるようにしています。例えばXSLファイルsample.xslはXSLのバージョンが2.0の場合、

```
xml/xslt/v2/sample.xsl
```

に置きます。
ルールとしてはXSLはXMLであるのでxmlディレクトリに属し、
そして、いくつかあるサブディレクトリ（名前空間とそれに結び付けられたスキーマをもつファイルを格納するもの）に属し、
バージョンがの違いがあるならvn（nは整数）ディレクトリに置かれるようにします。

## XMLエンティティ

XMLと関連が深いファイルとしてXML解析対象エンティティ(parsed entity)ファイルがあり、多くの場合それを見る必要があるかもしれません。
XMLエンティティに関しては[Studying XML -- second step -- [ エンティティの分類 ]](http://www015.upp.so-net.ne.jp/StudyingXML/xml/xml_2/entityType.html)を参照するといいと思います。
エンティティファイルの置き方はまだ決めていませんが、名前空間またはスキーマを持つXMLと関係するようにしています。
例えばApache IvyのためのivyファイルはXML Schemaファイル http://ant.apache.org/ivy/schemas/ivy.xsd と結び付けれられています。
これは

```
ent/ivy/dependency/logging-latest_integration.ent
```

の様に置かれます。
DTDファイルもありますがスキーマとしてではなくエンティティ宣言のコレクションとして動作するように書いていくつもりです。