---
description: Write a German Jira bug
argument-hint: "<titel oder beschreibung>"
---

Schreibe einen Jira Bug: $ARGUMENTS

Die verbindlichen Regeln stehen in
`~/projects/linked-planet/agent-comms/.claude/skills/jira/`. Lies zuerst
`SKILL.md`, dann `references/bug.md`.

Prüfe dabei die Entscheidungsregel: Ein Bug setzt voraus, dass das erwartete
Verhalten definiert oder implementiert war und jetzt falsch funktioniert. War es
nie spezifiziert, ist es eine Story, dann nimm `/story`. Im Zweifel Story.

Kurzfassung, falls die Dateien nicht erreichbar sind:

- Jira Markup, Überschriften als `h3.`
- Abschnitte: `h3. Ist`, `h3. Soll`, `h3. Reproduktion`
- `Ist` nennt auslösende Handlung, beobachtetes Ergebnis und wo es auftritt
- `Soll` beschreibt den Endzustand, nicht die Lösung
- Gelingt keine Reproduktion: "Reproduktion unklar". Erfinde keine Schritte.

Schreibe nach `bugs/bug-<slug>.md` und biete an, mit `wl-copy` in die
Zwischenablage zu kopieren.
