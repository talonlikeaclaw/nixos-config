---
name: obsidian-objects
description: Use when creating, editing, or organizing typed notes in Obsidian vault at /home/talon/Documents/Obsidian/talon, especially when defining new object types, creating YAML frontmatter, or building Bases
---

# Obsidian Object Model

## Overview

Vault follows Markdown-first object model. Every durable note may have `type`, structured properties, typed relationships. YAML frontmatter = canonical metadata layer; prose + backlinks = primary knowledge graph.

**Core principle:** Markdown files are canonical. Everything else is derived. Never build schema engine, global registry, or UUID system.

## When to Use

**Always:**
- Creating new typed note (project, person, resource, task, etc.)
- Editing YAML frontmatter on existing notes
- Adding/modifying object types in Object model guide
- Creating/updating Bases
- Creating templates
- Organizing notes into folder structure
- Updating Iconize icon rules in `.obsidian/plugins/obsidian-icon-folder/data.json` when creating/moving durable typed notes

**Use these types when semantic distinction is useful:**
- `achievement` - milestones, results, outcomes
- `album`, `book`, `game` - media with tracking workflows
- `bookmark` - saved external links not yet developed
- `creator` - public creative identities (artists, bands, collectives)
- `event` - occurrences with defined time
- `goal` - measurable outcomes with success criteria
- `idea` - lightweight captured possibilities
- `interest` - sustained subjects of personal interest
- `job_application` - applications with recurring workflow
- `organization` - companies, institutions, formal groups
- `project` - temporary work toward goals (active, on_hold, completed, cancelled)
- `resource` - curated external works with durable value
- `task` - standalone actions with status
- `technology` - tools, platforms, languages worth tracking
- `area`, `decision`, `note`, `person` - ongoing responsibilities, decisions, general knowledge, direct-life individuals

**Use `person` for** people directly in your life (family, friends, colleagues).
**Use `creator` for** public creative identities (artists, stage names, bands, duos, collectives).
**Use `organization` for** legal or operational entities (labels, studios, companies).
**Use both only when** direct-life relationship requires own contact workflow.

## Folder Contract

```text
00 Inbox/        Unprocessed captures
10 Journal/      Daily and time-bound notes
20 Projects/     Goals and finite work
30 Areas/        Ongoing responsibilities
40 Knowledge/    Ideas, procedures, and evergreen notes
50 People/       People, organizations, and creative identities
60 Sources/      External references
70 Attachments/  Binary files
80 System/       Templates/, Bases/, Guides/, Tools/, Types/
90 Archive/      Inactive or completed material
```

**Folders are stable homes, not tags.** Do not create folders for every topic, source format, status, or object subtype.

## YAML Conventions

Use valid YAML frontmatter:
- Lowercase `snake_case` keys
- Lowercase singular type values
- Unambiguous ISO dates
- Type-specific fields only (don't impose global schema)

```yaml
---
type: project
project_status: active
aliases: []
tags: []
goals: []
people: []
technologies: []
started: 2026-08-04
due:
---
```

**Rules:**
- Use lists for many-to-many fields: `areas`, `goals`, `people`, `members`, `projects`, `organizations`, `technologies`, `resources`, `roles`, `aliases`
- Use quoted Obsidian links in YAML lists when relation must appear in Base: `- "[[Ada Lovelace]]"`
- Use `tags` only for small set of broad facets
- Use `aliases` for genuine alternate names
- Do not add `created`, `updated`, UUID, database ID, backlink, or generic `related` properties
- Do not use generic `status` or universal workflow-state vocabulary
- Use `snake_case` values for controlled vocabularies
- Do not use `other` as durable controlled value

## Links and Relationships

**Prose links are default knowledge graph.** Prefer standard Markdown links. Obsidian wikilinks acceptable where they materially help.

```markdown
## Relationships

- Project: [Build personal site](../20%20Projects/Build%20personal%20site.md)
- Person: [Ada Lovelace](../50%20People/Ada%20Lovelace.md)
```

**Store explicit YAML relation only if it drives recurring Base, filter, or workflow.** Assert once at natural source. Do not create reciprocal YAML relations; use backlinks for inverse discovery.

**Use specific relations** (`areas`, `people`, `projects`, `resources`, `authors`, `developers`, `publishers`, `members`, `parent`) over `related`. Use `related` only when no more meaningful relationship exists.

**Relationship ownership** - Goals list Areas, Projects list Goals, Tasks and job applications list Projects, Achievements list Goals. Do not add inverse YAML fields for backlinks.

## Naming and Note Creation

- Descriptive, human-readable filenames: `Ada Lovelace.md`, `Build personal site.md`
- Portable filenames: avoid `/`, `#`, `[`, `]`, `|`, `?`, `*`, `:`, `<`, `>`, `\`, quotes
- Dates only for journal, event, meeting, time-bound records: `2026-08-04.md`
- Parenthetical qualifier only to disambiguate: `Alex Chen (designer).md`
- No type prefixes, serial numbers, or opaque identifiers
- **Search vault before creating** people, projects, resources, durable concepts
- Split note only if new content has independent value, incoming links, or different lifecycle

## Templates

- Static Markdown templates in `80 System/Templates/`
- Use Obsidian core Templates plugin first
- Configure template folder as `80 System/Templates`
- Do not add Templater until demonstrated workflow need
- Project template must minimally include: `type`, `project_status`, relevant relationship lists, outcome, next actions, notes, relationships

## Bases and Dashboards

- Native Obsidian Base definitions in `80 System/Bases/`
- Create Base only for recurring decision or workflow
- Type landing pages in `80 System/Types/`
- Filter active records instead of moving/deleting for cosmetic cleanliness
- Keep filters and formulas simple
- Every type or operational Base must exclude `80 System/Templates/`
- Avoid hand-maintained dashboard copies of properties or relationships
- Prefer focused Base (e.g., Active Projects) over universal home dashboard
- Use authored MOCs only when narrative route adds value

## Plugins, Git, Attachments

- Prefer core Obsidian features: Properties, Bases, Templates, Search, Bookmarks, Backlinks, Daily Notes
- Treat Dataview, Templater, task plugins as optional enhancements
- Iconize and Style Settings approved for presentation only
- When creating/moving durable typed note, update `.obsidian/plugins/obsidian-icon-folder/data.json` if existing rules do not already assign correct icon and Catppuccin color
- Iconize is path-based, not type-aware: use folder fallbacks
  - Area: `LiHeart`, `#a6e3a1`
  - Project: `LiBriefcase`, `#89b4fa`
  - Goal: `LiTarget`, `#f9e2af`
  - Task: `LiListTodo`, `#89b4fa`
  - Job application: `LiSend`, `#89b4fa`
  - People folder: `#f5c2e7`
  - Sources folder: `#fab387`
  - Knowledge folder: `#94e2d5`
- Prefer semantically specific Lucide icon over folder fallback; place specific rule before folder fallback and preserve existing rule order
- Version Markdown, templates, Bases, meaningful configuration in Git
- Ignore volatile workspace state (`.obsidian/workspace.json`)
- Binary files in `70 Attachments/`
- Never store credentials, API tokens, recovery codes

## Archiving

- Move completed project working material to `90 Archive/` when no longer belongs in active browsing
- Preserve valuable final outcomes, decisions, evergreen knowledge where discoverable
- Do not archive people, resources, or knowledge merely because old
- Prefer type-specific workflow-state filter to deletion

## Maintenance Checks

When adding or changing conventions, verify:

1. Note readable outside Obsidian
2. Metadata supports real search, Base, or workflow
3. Relationship asserted once and semantically specific
4. Change does not require community plugin to interpret core data
5. Change does not create duplicate canonical note or topic taxonomy
6. File moves and renames preserve links

## Red Flags - STOP and Start Over

- Creating UUIDs, database IDs, or global registries
- Adding reciprocal YAML relations for backlinks
- Forcing all notes into object model
- Creating folders for every topic or status
- Adding generic `status` or universal workflow vocabulary
- Creating excessive types without demonstrated need
- Building Anytype-like schema engines
- Prioritizing Base/metadata over Markdown readability
- Using `related` when specific relation exists
- Adding `created`, `updated`, backlink properties by default
- Creating reciprocal properties for inverse discovery

**All of these mean: Delete and restart.**

## Rationalization Table

| Excuse | Reality |
|--------|---------|
| "Need UUIDs for deduplication" | Git handles deduplication. Backlinks handle relationships. |
| "Reciprocal relations make browsing easier" | Backlinks provide inverse discovery. Explicit inverses duplicate data. |
| "Everything should be an object" | Fleeting captures and simple journal entries may be plain Markdown. |
| "Folders for every topic is organized" | Folders are stable homes, not tags. Every topic = folder sprawl. |
| "Generic status is flexible" | Type-scoped workflow state (project_status, task_status) is clearer. |
| "Need a new type for this" | Existing types cover most cases. New type requires 4 criteria met. |
| "Base is better than Markdown" | Markdown is canonical. Bases are derived views. |
| "I'll add related to connect things" | Use specific relations (people, projects, resources). related is fallback only. |
| "Created/updated metadata is useful" | Git tracks history. File metadata tracks timestamps. Don't duplicate. |

## Quick Reference

### Object Type Catalog

| Type | Lifecycle | Purpose |
|------|-----------|---------|
| `achievement` | Milestone | Result worth reviewing |
| `album`, `book`, `game` | Media | Distinct tracking or reflection |
| `bookmark` | Saved link | External link not yet developed |
| `creator` | Public identity | Artist, alias, band, collective |
| `event` | Time-bound | Occurrence with defined time |
| `goal` | Measurable | Outcome with success criteria |
| `idea` | Lightweight | Captured possibility |
| `interest` | Sustained | Subject of personal interest |
| `job_application` | Recurring | Application workflow |
| `organization` | Durable | Company, institution, group |
| `project` | Temporary | Work toward goals |
| `resource` | Curated | External work with value |
| `task` | Standalone | Action with status |
| `technology` | Trackable | Tool, platform, language |
| `area` | Ongoing | Responsibility |
| `decision` | Material | Decision worth recording |
| `note` | General | Knowledge |
| `person` | Direct-life | People in your life |

### Property Quick Reference

| Property | Type | Usage |
|----------|------|-------|
| `type` | string | Required for typed notes |
| `project_status` | enum | active, on_hold, completed, cancelled |
| `task_status` | enum | todo, in_progress, done |
| `aliases` | list | Alternate names |
| `tags` | list | Broad facets only |
| `areas` | list | Areas this belongs to |
| `goals` | list | Goals this serves |
| `people` | list | People involved |
| `projects` | list | Projects involved |
| `organizations` | list | Organizations involved |
| `technologies` | list | Technologies used |
| `resources` | list | Resources referenced |
| `members` | list | Team members |
| `parent` | string | Parent note |
| `rating` | number | Rating (1-5) |
| `favorite` | boolean | Favorite flag |
| `url` | string | External URL |
| `started` | date | Start date (ISO) |
| `finished` | date | End date (ISO) |
| `due` | date | Due date (ISO) |

### Folder Quick Reference

| Folder | Contents |
|--------|----------|
| `00 Inbox/` | Unprocessed captures |
| `10 Journal/` | Daily notes, time-bound records |
| `20 Projects/` | Active/completed projects |
| `30 Areas/` | Ongoing responsibilities |
| `40 Knowledge/` | Evergreen notes, procedures |
| `50 People/` | People, organizations, creators |
| `60 Sources/` | External references |
| `70 Attachments/` | Binary files |
| `80 System/` | Templates, Bases, Guides, Tools, Types |
| `90 Archive/` | Inactive material |
