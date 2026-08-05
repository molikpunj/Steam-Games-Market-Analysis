-- See Table
SELECT * FROM cleaned_steam_data;

-- 1. Top 10 Genres
SELECT "Genres", COUNT(*) AS total_games FROM cleaned_steam_data WHERE "Genres" IS NOT NULL GROUP BY "Genres" ORDER BY total_games DESC LIMIT 10;

-- 2. Highest Rated Genres (Minimum 100 Games)
SELECT "Genres", AVG("Review Score %"),2 AS avg_review, COUNT(*) AS games FROM cleaned_steam_data WHERE "Total Reviews" > 50 AND "Genres" IS NOT NULL GROUP BY "Genres" HAVING COUNT(*) >= 100 ORDER BY avg_review DESC LIMIT 10;

-- 3. Top Developers
SELECT "Developers", COUNT(*) AS total_games FROM cleaned_steam_data WHERE "Developers" IS NOT NULL GROUP BY "Developers" ORDER BY total_games DESC LIMIT 10;

-- 4. Top Publishers
SELECT "Publishers", COUNT(*) AS total_games FROM cleaned_steam_data WHERE "Publishers" IS NOT NULL GROUP BY "Publishers" ORDER BY total_games DESC LIMIT 10;

-- 5. Highest Rated Developers (Minimum 5 Games)
SELECT "Developers", AVG("Review Score %"),2 AS avg_review, COUNT(*) AS games FROM cleaned_steam_data WHERE "Developers" IS NOT NULL AND "Total Reviews" > 50 GROUP BY "Developers" HAVING COUNT(*) >= 5 ORDER BY avg_review DESC LIMIT 10;

-- 6. Average Price by Price Category
SELECT "Price Category", AVG("Price"),2 AS average_price FROM cleaned_steam_data GROUP BY "Price Category";

-- 7. Average Review Score by Price Category
SELECT "Price Category", AVG("Review Score %"),2 AS average_review FROM cleaned_steam_data GROUP BY "Price Category" ORDER BY average_review DESC;

-- 8. Games Released Per Year
SELECT "Release Year", COUNT(*) AS games_released FROM cleaned_steam_data GROUP BY "Release Year" ORDER BY "Release Year";

-- 9. Average Playtime by Genre
SELECT "Genres", AVG("Average playtime forever"),0 AS average_playtime FROM cleaned_steam_data WHERE "Genres" IS NOT NULL GROUP BY "Genres" ORDER BY average_playtime DESC LIMIT 10;

-- 10. Most Popular Games by Peak CCU
SELECT "Name", "Peak CCU" FROM cleaned_steam_data ORDER BY "Peak CCU" DESC LIMIT 10;

-- 11. Most Owned Games
SELECT "Name", "Estimated owners" FROM cleaned_steam_data ORDER BY "Estimated owners" DESC LIMIT 10;

-- 12. Top Free Games by Review Score
SELECT "Name", "Review Score %", "Total Reviews" FROM cleaned_steam_data WHERE "Price Category" = 'Free' AND "Total Reviews" > 1000 ORDER BY "Review Score %" DESC LIMIT 10;

-- 13. Top Premium Games by Review Score
SELECT "Name", "Price", "Review Score %" FROM cleaned_steam_data WHERE "Price Category" = 'Premium' AND "Total Reviews" > 1000 ORDER BY "Review Score %" DESC LIMIT 10;

-- 14. Rank Publishers by Number of Games
SELECT "Publishers", COUNT(*) AS games_published, RANK() OVER (ORDER BY COUNT(*) DESC) AS publisher_rank FROM cleaned_steam_data WHERE "Publishers" IS NOT NULL GROUP BY "Publishers";

-- 15. Top 5 Games Within Each Genre
SELECT * FROM (SELECT "Genres", "Name", "Review Score %", ROW_NUMBER() OVER (PARTITION BY "Genres" ORDER BY "Review Score %" DESC) AS rank FROM cleaned_steam_data WHERE "Total Reviews" > 100) ranked WHERE rank <= 5;