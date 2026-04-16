# /story

Write a German user story following requirements engineering best practices.

## Usage
```
/story <title>
```

## Behavior
1. Creates structured user story with title, story sentence, motivation, acceptance criteria, and optional hints
2. Writes story to `stories/story-<sanitized-title>.md` 
3. Offers to copy content to clipboard with wl-copy
4. Uses concise, professional German language
5. Follows format:
   - ### [Title]
   - Als [Rolle] möchte ich [Funktionalität], damit [Nutzen]
   - ### Motivation
   - ### Akzeptanzkriterien (numbered list)
   - ### Hinweise (optional)

## Example
```
/story Statusfarb-Logik vom Backend ins Frontend verlagern
```

Creates story with clear intent, actionable criteria, and technical context.