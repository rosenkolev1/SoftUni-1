--EXERCISE 12
SELECT mc.CountryCode ,m.MountainRange ,p.PeakName, p.Elevation
FROM Peaks AS p
JOIN Mountains AS m ON p.MountainId = m.Id
JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--EXERCISE 13
SELECT mc.CountryCode, COUNT(m.MountainRange) FROM Mountains AS m 
JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
WHERE mc.CountryCode IN ('BG', 'RU', 'US')
GROUP BY mc.CountryCode

--EXERCISE 14
SELECT TOP(5) c.CountryName, r.RiverName
FROM (SELECT TOP(5) CountryName, CountryCode FROM Countries WHERE ContinentCode ='AF' ORDER BY CountryName) AS c
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON  cr.RiverId = r.Id

--EXERCISE 15
SELECT k.ContinentCode, k.CurrencyCode, k.CurrencyUsage 
FROM (SELECT  c.ContinentCode, 
			  c.CurrencyCode,
			  COUNT(c.CurrencyCode) AS [CurrencyUsage],
			  DENSE_RANK() OVER(PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS CurrencyRank
		FROM Countries AS c
		GROUP BY c.ContinentCode, c.CurrencyCode
		HAVING COUNT(c.CurrencyCode) > 1) AS k
WHERE k.CurrencyRank = 1
ORDER BY k.ContinentCode

--EXERCISE 16
SELECT COUNT(*) AS [Count] FROM Countries AS c
LEFT JOIN MountainsCountries AS m ON c.CountryCode = m.CountryCode
WHERE m.CountryCode IS NULL


--EXERCISE 17

SELECT TOP(5) f.CountryName, MAX(s.Elevation) AS [HighestPeakElevation], MAX(f.Length) AS [LongestRiverLength] FROM (SELECT DISTINCT c.CountryName, r.Length FROM Countries AS c
JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
JOIN Rivers AS r ON cr.RiverId = r.Id) AS f
JOIN (SELECT DISTINCT c.CountryName, p.Elevation FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
JOIN Peaks AS p ON mc.MountainId= p.MountainId ) AS s ON f.CountryName = s.CountryName
GROUP BY f.CountryName
ORDER BY MAX(s.Elevation) DESC, MAX(f.Length) DESC, f.CountryName 

--EXERCISE 18
SELECT TOP(5) CountryName, ISNULL(PeakName, '(no highest peak)') AS [Highest Peak Name], ISNULL([Highest Peak Elevation], 0) AS [Highest Peak Elevation], ISNULL(Mountain, '(no mountain)') AS [Mountain]
FROM (SELECT c.CountryName,
		p.PeakName, 
		p.Elevation AS [Highest Peak Elevation],
		m.MountainRange AS Mountain,
		DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS [Rank]
			FROM Countries AS c
			LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
			LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
			LEFT JOIN Peaks AS p ON p.MountainId = m.Id) AS r
WHERE r.Rank = 1
ORDER BY CountryName, [Highest Peak Name]






