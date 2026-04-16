# /bug

Document a German bug story following requirements engineering best practices.

## Usage
```
/bug <title>
```

## Behavior
1. Creates structured bug documentation with title, current state (Ist), expected state (Soll), and analysis hints
2. Writes bug to `bugs/bug-<sanitized-title>.md`
3. Offers to copy content to clipboard with wl-copy
4. Uses concise, professional German language
5. Follows format:
   - ### [Title]
   - ### Ist
   - ### Soll
   - ### Hinweise (optional)

## Example
```
/bug Buchungskonflikt falsche Zeitzone
```

Creates bug documentation with clear problem description, expected behavior, and technical analysis.