<?xml version="1.0" encoding="UTF-8"?>
<!-- XHTML2.0系の要素をXHTML1.0系の要素に変換するXSLの基本となるXSL。 他のXSLTにインクルードまたはインポートされることを前提としたスタイルシートであり、 ルートに対してのテンプレートが無いのでこれを単独で使用するのは意味が無い。 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:template name="printcc">
        <ul class="comment-controller">
            <li onclick="compressComment(getComment({@number}), true);">複圧縮</li>
            <li onclick="uncompressComment(getComment({@number}), true);">複展開</li>
            <li onclick="compunc(getComment({@number}));">圧縮/展開</li>
            <li onclick="closeComment(getComment({@number}), true);">複閉じ</li>
            <li onclick="openComment(getComment({@number}), true);">複開け</li>
            <li onclick="clopen(getComment({@number}));">開閉</li>
        </ul>
    </xsl:template>
</xsl:stylesheet>
