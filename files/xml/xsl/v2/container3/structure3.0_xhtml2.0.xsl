<?xml version="1.0" encoding="UTF-8"?>
<!-- 名前空間"http://www.bbwtest.info/schema/2011/container2/"に属するXMLをXHTMLに変換するためのスタイルシート。 
	他のXSLTにインクルードまたはインポートされることを前提としたスタイルシートであり、 ルートに対してのテンプレートが無いのでこれを単独で使用するのは意味が無い。 -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/2002/06/xhtml2/"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        version="2.0">
    <xsl:include href="comment_controller.xslt"/>
    <!-- 全体で使う定数 -->
    <xsl:variable name="con" select="/c:container/@number"/>
    <xsl:variable name="box" select="/c:container/c:commentBox/@number"/>
    <!-- 文字列をバインドする。post属性がなければ空文字列を保存する -->
    <xsl:variable name="post-article" select="string(/c:container/@l:post-article)"/>
    <xsl:variable name="post-comment" select="string(/c:container/@l:post-comment)"/>
    <xsl:variable name="post-vote" select="string(/c:container/@l:post-vote)"/>

    <xsl:template match="c:author"></xsl:template>

    <xsl:template match="c:container">
        <section>
            <dl class="head">
                <xsl:call-template name="common.attr"></xsl:call-template>
            </dl>
            <xsl:apply-templates/>
        </section>
    </xsl:template>

    <xsl:template match="c:article">
        <h id="article">記事</h>
        <xsl:text>&#x0a;</xsl:text>
        <h>
            <xsl:value-of select="@title"/>
        </h>
        <section id="c0" class="article">
            <xsl:text>&#x0a;</xsl:text>
            <dl class="head">
                <xsl:call-template name="common.attr"></xsl:call-template>
            </dl>
            <xsl:text>&#x0a;</xsl:text>
            <ul class="pages">
                <xsl:apply-templates select="c:articleContent"/>
            </ul>
            <xsl:text>&#x0a;</xsl:text>
            <section class="foot">
                <xsl:if test="string-length($post-comment) > 0">
                    <a href="{$post-comment}&amp;ref=0">この記事へコメントを投稿</a>
                </xsl:if>
                <!--<xsl:if test="string-length($post-vote) > 0">
                    <xsl:text> | </xsl:text>
                    <a href="{$post-vote}&amp;ref={@number}#form">投票</a>
                </xsl:if>-->
            </section>
        </section>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>

    <xsl:template match="c:articleContent">
        <li class="page" id="c-{@number}">
            <dl class="head">
                <di>
                    <dt>ページ</dt>
                    <dd class="number">
                        <xsl:value-of select="@number"/>
                    </dd>
                </di>
            </dl>
            <section class="content">
                <xsl:apply-templates select="c:section|c:p"/>
            </section>
        </li>
    </xsl:template>

    <xsl:template match="c:commentBox">
        <h id="commentBox">コメント</h>
        <section class="commentBox">
            <dl class="head">
                <xsl:call-template name="common.attr"></xsl:call-template>
                <di>
                    <dt>コメント数</dt>
                    <dd class="numberOfComments">
                        <xsl:value-of select="@numberOfComments"/>
                    </dd>
                </di>
                <xsl:if test="@lastModified">
                    <di>
                        <dt>最終更新</dt>
                        <dd class="lastModified">
                            <xsl:value-of select="substring(@lastModified,1,10)"/>
                            <xsl:text>&#160;</xsl:text>
                            <xsl:value-of select="substring(@lastModified,12,8)"/>
                        </dd>
                    </di>
                </xsl:if>
            </dl>
            <ul class="childComments">
                <xsl:apply-templates/>
            </ul>
            <section class="foot">
                <xsl:if test="$post-comment">
                    <a href="{$post-comment}&amp;ref=0#form">投稿</a>
                </xsl:if>
                <!--<xsl:if test="$post-vote">
                    <xsl:text> | </xsl:text>
                    <a href="{$post-vote}&amp;ref=0#form">投票</a>
                </xsl:if>-->
            </section>
        </section>
    </xsl:template>

    <xsl:template match="c:comment">
        <xsl:variable name="com" select="@number"/>
        <li class="comment" id="c{$com}">
            <xsl:text>&#x0a;</xsl:text>
            <dl class="head">
                <di>
                    <dt>参照</dt>
                    <dd class="reference" href="#c{@reference}">
                        <xsl:value-of select="@reference"/>
                    </dd>
                </di>
                <di>
                    <dt>関係</dt>
                    <dd class="relation">
                        <xsl:value-of select="@relation"></xsl:value-of>
                    </dd>
                </di>
                <xsl:call-template name="common.attr"></xsl:call-template>
            </dl>
            <xsl:call-template name="printcc"></xsl:call-template>
            <xsl:text>&#x0a;</xsl:text>
            <div class="content">
                <xsl:apply-templates select="c:p|c:l"/>
            </div>
            <xsl:text>&#x0a;</xsl:text>
            <ul class="foot">
                <li href="asd{@number}.xhtml">ASD</li>
                <li href="sd{@number}.xhtml">SD</li>
                <li href="as{@number}.xhtml">AS</li>
                <li href="s{@number}.xhtml">S</li>
                <li href="psc{@number}.xhtml">PSC</li>
                <li href="/service/source.txt?kind=c&amp;con={$con}&amp;box={$box}&amp;com={$com}">ソースコード</li>
                <li href="{$post-comment}&amp;ref={@number}#form">投稿</li>
                <!--<li><a href="{$post-vote}&amp;ref={@number}#form">投票</a></li>-->
            </ul>
            <xsl:text>&#x0a;</xsl:text>
            <xsl:if test="c:comment">
                <ul class="childComments">
                    <xsl:apply-templates select="c:comment"/>
                </ul>
            </xsl:if>
        </li>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>

    <xsl:template name="common.attr">
        <di>
            <dt>番号</dt>
            <dd class="number">
                <xsl:value-of select="@number"/>
            </dd>
        </di>
        <di>
            <dt>日時</dt>
            <dd class="datetime">
                <xsl:value-of select="substring(@datetime,1,10)"/>
                <xsl:text>&#160;</xsl:text>
                <xsl:value-of select="substring(@datetime,12,8)"/>
            </dd>
        </di>
        <di>
            <dt>名前</dt>
            <dd class="authorName" href="/service/blog/{c:author/@type}_{c:author/@name}/">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="c:author/@type"/>
                <xsl:text>]</xsl:text>
                <xsl:value-of select="c:author/@name"/>
            </dd>
        </di>
    </xsl:template>

</xsl:stylesheet>
