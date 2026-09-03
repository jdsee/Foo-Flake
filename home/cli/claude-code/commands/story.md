---
description: Write a German Jira story
argument-hint: "<titel oder beschreibung>"
---

Schreibe eine Jira Story: $ARGUMENTS

Die verbindlichen Regeln stehen in
`~/projects/linked-planet/agent-comms/.claude/skills/jira/`. Lies zuerst
`SKILL.md`, dann `references/story.md`. Halte dich an das, was dort steht, nicht
an das, was du sonst über User Stories weißt.

Prüfe dabei die Entscheidungsregel: Ist das Verhalten neu oder nie spezifiziert
gewesen, ist es eine Story. Funktioniert spezifiziertes Verhalten falsch, ist es
ein Bug, dann nimm `/bug`.

Kurzfassung, falls die Dateien nicht erreichbar sind:

- Jira Markup, Überschriften als `h3.`
- Abschnitte: `h3. Motivation`, `h3. Akzeptanzkriterien`, optional `h3. Hinweise`
- Kein "Als [Rolle] möchte ich...", außer ausdrücklich verlangt
- Akzeptanzkriterien als nummerierte Liste (`#`), jedes ein prüfbarer
  Endzustand, keine Aufgabe

Schreibe nach `stories/story-<slug>.md` und biete an, mit `wl-copy` in die
Zwischenablage zu kopieren.
