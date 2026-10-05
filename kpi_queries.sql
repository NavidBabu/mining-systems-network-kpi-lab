-- Mining Systems Network & KPI Lab
-- All tables/data are simulated for portfolio use.

-- 1) Event volume by severity
SELECT
    severity,
    COUNT(*) AS event_count
FROM operational_events
GROUP BY severity
ORDER BY event_count DESC;

-- 2) Average MTTR for resolved incidents
SELECT
    AVG(resolution_minutes) AS avg_mttr_minutes
FROM operational_events
WHERE status = 'Resolved'
  AND resolution_minutes > 0;

-- 3) Data completeness KPI
SELECT
    100.0 * SUM(CASE WHEN data_complete = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS data_completeness_pct
FROM operational_events;

-- 4) Network reachability KPI
SELECT
    100.0 * SUM(CASE WHEN network_reachable = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS network_reachability_pct
FROM operational_events;

-- 5) Recurring event categories
SELECT
    event_type,
    root_cause_category,
    COUNT(*) AS occurrences
FROM operational_events
GROUP BY event_type, root_cause_category
ORDER BY occurrences DESC;

-- 6) High-severity incidents by system
SELECT
    system,
    COUNT(*) AS high_severity_events
FROM operational_events
WHERE severity IN ('High', 'Critical')
GROUP BY system
ORDER BY high_severity_events DESC;
