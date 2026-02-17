# 004: Album Comparison Includes Track Count

## Status
Accepted

## Context
Initial implementation compared source and target folders by normalized folder name only. An album that was partially transferred (e.g. due to an error mid-sync) would show as "Present" even though it was incomplete.

## Decision
Compare both folder name and track count. Albums are categorized as:

- **Missing**: folder does not exist in target
- **Incomplete**: folder exists but has fewer tracks than source
- **Present**: folder exists with at least as many tracks as source

Missing and Incomplete albums are pre-checked for syncing.

## Consequences
- Partially transferred albums are easy to identify and re-sync
- Comparison does not verify file contents/integrity, only count
