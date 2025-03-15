<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
        <head>
            <title>Movie List</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #E6E6FA; /* Lavender background */
                    text-align: center;
                    margin: 0;
                    padding: 20px;
                }
                h2 {
                    color: #4B0082; /* Deep purple */
                    font-size: 32px;
                    font-weight: bold;
                    text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.2);
                    margin-bottom: 20px;
                }
                .movies-container {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); 
                    gap: 20px;
                    padding: 20px;
                    justify-content: center;
                    max-width: 1200px;
                    margin: 0 auto;
                }
                .movie-card {
                    background-color: #D8BFD8; /* Light purple */
                    border-radius: 12px;
                    padding: 16px;
                    box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);
                    text-align: left;
                    transition: transform 0.3s ease;
                }
                .movie-card:hover {
                    transform: scale(1.05);
                }
                .movie-title {
                    font-size: 20px;
                    font-weight: bold;
                    color: #4B0082; /* Deep purple */
                }
                .movie-info {
                    font-size: 14px;
                    color: #333;
                    margin: 5px 0;
                }
                .movie-info b {
                    font-style: italic;
                    color: #6A0DAD; /* Medium purple */
                }
            </style>
        </head>
        <body>
            <h2>Movies List</h2>

            <div class="movies-container">
                <xsl:for-each select="movies/movie">
                    <div class="movie-card">
                        <div class="movie-title">
                            <xsl:value-of select="movieTitle"/>
                        </div>
                        <p class="movie-info">
                            <b>Directed by:</b> <i><xsl:value-of select="director"/></i>
                        </p>
                        <p class="movie-info">
                            <b>Year:</b> <xsl:value-of select="year"/>
                        </p>
                        <p class="movie-info">
                            <b>Cast:</b>
                            <xsl:for-each select="actors/actor">
                                <xsl:value-of select="."/>
                                <xsl:if test="position() != last()">, </xsl:if>
                            </xsl:for-each>
                        </p>
                    </div>
                </xsl:for-each>
            </div>
        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
