<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" >
<xsl:output omit-xml-declaration="yes" indent="yes"/>
    <!-- Identity template, copies everything as is -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- Override for target element -->
    <xsl:template match="/domain">
        <!-- Copy the element -->
        <xsl:copy>
            <!-- And everything inside it -->
            <xsl:apply-templates select="@* | node()"/>
        <!-- Add new node -->
            <xsl:element name="channel">
                <xsl:attribute name="type">unix</xsl:attribute>
                <xsl:element name="source">
                    <xsl:attribute name="mode">bind</xsl:attribute>
                </xsl:element>
                <xsl:element name="target">
                    <xsl:attribute name="type">virtio</xsl:attribute>
                    <xsl:attribute name="name">org.qemu.guest_agent.0</xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
