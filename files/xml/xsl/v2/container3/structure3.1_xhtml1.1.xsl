<?xml version="1.0" encoding="UTF-8"?>
<!-- 名前空間"http://www.bbwtest.info/schema/2011/container2/"に属するXMLをXHTMLに変換するためのスタイルシート。 
他のXSLTにインクルードまたはインポートされることを前提としたスタイルシートであり、 ルートに対してのテンプレートが無いのでこれを単独で使用するのは意味が無い。 -->
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:x="http://www.w3.org/1999/xhtml"
        xmlns:c="http://www.bbwtest.info/schema/2011/container3/"
        xmlns:l="http://www.bbwtest.info/schema/2011/gottaniLocal/"
        xmlns="http://www.w3.org/1999/xhtml"
        exclude-result-prefixes="xsl c l x"
        version="2.0">
    <xsl:output method="xhtml"/>
    <!-- 全体で使う定数 -->
    <xsl:variable name="con" select="/c:container/@number"/>
    <xsl:variable name="box" select="/c:container/c:commentBox/@number"/>
    <!-- 文字列をバインドする。post属性がなければ空文字列を保存する -->
    <xsl:variable name="post-article" select="string(/c:container/@l:post-article)"/>
    <xsl:variable name="post-comment" select="string(/c:container/@l:post-comment)"/>
    <xsl:variable name="post-vote" select="string(/c:container/@l:post-vote)"/>
    <xsl:variable name="data-url" select="string(/c:container/@l:data-url)"/>

    <xsl:template match="c:author"></xsl:template>

    <xsl:template match="c:container">
        <div class="container">
            <dl class="head">
                <xsl:call-template name="common.attr"></xsl:call-template>
            </dl>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="c:article">
        <h2 id="article">記事</h2>
        <xsl:text>&#x0a;</xsl:text>
        <h3>
            <xsl:value-of select="@title"/>
        </h3>
        <div id="c0" class="article">
            <xsl:text>&#x0a;</xsl:text>
            <dl class="head">
                <xsl:call-template name="common.attr"></xsl:call-template>
            </dl>
            <xsl:text>&#x0a;</xsl:text>
            <div class="articleContent">
                <xsl:apply-templates/>
            </div>
            <xsl:text>&#x0a;</xsl:text>
            <div class="foot">
                <div class="add_button">
                    <!-- AddThis Button BEGIN -->
                    <div class="addthis_toolbox addthis_default_style"
                         xmlns:addthis="http://www.addthis.com/help/api-spec" addthis:url="{$data-url}">
                        <a class="addthis_button_facebook_like" data-href="{$data-url}"></a>
                        <a class="addthis_button_tweet" data-url="{$data-url}"></a>
                        <a class="addthis_button_google_plusone"></a>
                        <a class="addthis_button_hatena"></a>
                        <a class="addthis_counter addthis_pill_style"></a>
                    </div>
                    <script type="text/javascript">var addthis_config =
                        {"data_track_addressbar":false,data_track_clickback: false};
                    </script>
                    <script type="text/javascript"
                            src="http://s7.addthis.com/js/300/addthis_widget.js#pubid=ra-4d9330cf1edc6043">
                        <xsl:text>&#x0a;</xsl:text>
                    </script>
                    <!-- AddThis Button END -->
                </div>
                <xsl:if test="string-length($post-comment) > 0">
                    <a href="{$post-comment}&amp;ref=0">この記事へコメントを投稿</a>
                </xsl:if>
                <!--<xsl:if test="string-length($post-vote) > 0">
                        <xsl:text> | </xsl:text>
                        <a href="{$post-vote}&amp;ref={@number}#form">投票</a>
                </xsl:if>-->
            </div>
        </div>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>

    <xsl:template match="c:articleContent">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="c:commentBox">
        <h2 id="commentBox">コメント</h2>
        <div class="commentBox">
            <dl class="head">
                <!-- <xsl:call-template name="common.attr"></xsl:call-template> -->
                <dt>コメント数</dt>
                <dd class="numberOfComments">
                    <xsl:value-of select="@numberOfComments"/>
                </dd>
                <xsl:if test="@lastModified">
                    <dt>最終更新</dt>
                    <dd class="lastModified">
                        <xsl:value-of select="substring(@lastModified,1,10)"/>
                        <xsl:text>&#160;</xsl:text>
                        <xsl:value-of select="substring(@lastModified,12,8)"/>
                    </dd>
                </xsl:if>
            </dl>
            <div class="childComments">
                <xsl:apply-templates/>
            </div>
            <div class="foot">
                <xsl:if test="$post-comment">
                    <a href="{$post-comment}&amp;ref=0#form">投稿</a>
                </xsl:if>
                <!--<xsl:if test="$post-vote">
                        <xsl:text> | </xsl:text>
                        <a href="{$post-vote}&amp;ref=0#form">投票</a>
                </xsl:if>-->
            </div>
        </div>
    </xsl:template>

    <xsl:template match="c:commentContent">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="c:comment">
        <xsl:variable name="com" select="@number"/>
        <div class="comment" id="c{$com}">
            <xsl:text>&#x0a;</xsl:text>
            <dl class="head">
                <dt>参照</dt>
                <dd class="reference">
                    <a href="#c{@reference}">
                        <xsl:value-of select="@reference"/>
                    </a>
                </dd>
                <dt>関係</dt>
                <dd class="relation">
                    <xsl:value-of select="@relation"></xsl:value-of>
                </dd>
                <xsl:call-template name="common.attr"></xsl:call-template>
            </dl>
            <xsl:text>&#x0a;</xsl:text>
            <div class="commentContent">
                <xsl:apply-templates select="c:commentContent"/>
            </div>
            <xsl:text>&#x0a;</xsl:text>
            <ul class="foot">
                <li>
                    <a href="asd{@number}.html">ASD</a>
                </li>
                <li>
                    <a href="sd{@number}.html">SD</a>
                </li>
                <li>
                    <a href="as{@number}.html">AS</a>
                </li>
                <li>
                    <a href="s{@number}.html">S</a>
                </li>
                <li>
                    <a href="psc{@number}.html">PSC</a>
                </li>
                <li>
                    <a href="/bbwtest/source.txt?kind=c&amp;con={$con}&amp;box={$box}&amp;com={$com}">ソース</a>
                </li>
                <li>
                    <a href="{$post-comment}&amp;ref={@number}#form">投稿</a>
                </li>
                <!--<li><a href="{$post-vote}&amp;ref={@number}#form">投票</a></li>-->
            </ul>
            <xsl:text>&#x0a;</xsl:text>
            <xsl:if test="c:comment">
                <div class="childComments">
                    <xsl:apply-templates select="c:comment"/>
                </div>
            </xsl:if>
        </div>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>

    <xsl:template name="common.attr">
        <dt>番号</dt>
        <dd class="number">
            <xsl:value-of select="@number"/>
        </dd>
        <xsl:text>&#x0a;</xsl:text>
        <dt>日時</dt>
        <dd class="datetime">
            <xsl:value-of select="substring(@datetime,1,10)"/>
            <xsl:text>&#160;</xsl:text>
            <xsl:value-of select="substring(@datetime,12,8)"/>
        </dd>
        <xsl:text>&#x0a;</xsl:text>
        <dt>名前</dt>
        <dd class="authorName">
            <a href="/bbwtest/member/mid{c:author/@id}/">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="c:author/@type"/>
                <xsl:text>]</xsl:text>
                <xsl:value-of select="c:author/@name"/>
            </a>
        </dd>
        <xsl:text>&#x0a;</xsl:text>
        <xsl:if test="c:author/@uri">
            <dt>URI</dt>
            <dd>
                <a href="{c:author/@uri}">URI</a>
            </dd>
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
