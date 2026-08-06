---
name: mermaid-style
description: House style for Mermaid diagrams — flowcharts with subgraphs (never sequence diagrams), the required semantic color palette, and rich node content. Use whenever generating or editing a Mermaid diagram, or when asked to visualize an architecture, flow, actor/service interaction, pipeline, or hierarchy as a diagram.
---

# Mermaid diagrams

## Structure

- **Use flowcharts with subgraphs** — prefer `graph TD` / `graph LR` with `subgraph` blocks to
  organize related nodes. This is the default diagram type for all visualizations.
- **Never use sequence diagrams** — model actor/service interactions as a flowchart with subgraphs
  representing each actor/service and edges representing the interactions.
- **Subgraph naming** — use quoted descriptive labels: `subgraph Core["Main Service"]`. The ID is a
  short key; the quoted string is the human-readable title.
- **Internal direction** — set `direction TB` or `direction LR` inside each subgraph.
- **Direction** — `TD` (top-down) for hierarchical flows, `LR` (left-right) for pipelines/timelines.

## Styling (required)

Every diagram must include explicit styling. Every subgraph must have a `style` declaration with
`fill`, `stroke`, `stroke-width`, and `color`. Use this semantic palette:

| Role / meaning        | fill      | stroke    |
|-----------------------|-----------|-----------|
| Primary / core system | `#f0f4ff` | `#0969da` |
| Success / result      | `#f0fff4` | `#1a7f37` |
| Secondary / agent     | `#f0f4ff` | `#8250df` |
| Warning / gateway     | `#fff8f0` | `#bc4c00` |
| Error / deny          | `#ffcdd2` | `#c62828` |

Always set `color:#1f2328` for readable text, and `stroke-width:2px` for primary subgraphs (1px for
secondary/supporting ones). Nodes representing error states or decision outcomes should get
individual `style` declarations (e.g. `style Deny fill:#ffcdd2,stroke:#c62828,stroke-width:2px`).

## Rich node content

- **HTML line breaks** — use `<br/>` inside node labels for multi-line content.
- **Italic annotations** — use `<i>...</i>` for secondary details within node labels.
- **Edge labels** — describe the action or data being passed (e.g. `-->|"POST /login"|`).
- **Dashed edges** — use `-.->` for secondary/reference/async flows; solid (`-->`) for the happy path.
