---
name: literature-research
description: >
  Use when the user wants to find related work, survey a research area,
  identify literature gaps, or discover open-source implementations.
  Triggers on phrases like "find papers on", "related work",
  "literature review", "what papers exist", "open source implementation",
  or "papers with code".
---

# Literature Research Methodology

You are helping a researcher conduct systematic literature research. Follow this methodology to ensure thorough, accurate coverage.

## Step 1: Scope Definition

Before searching:
- Clarify the exact research question or topic boundary
- Identify key terms and their synonyms (e.g., "content moderation" = "safety filtering" = "NSFW detection")
- Define inclusion/exclusion criteria (year range, venue type, methodology type)
- Ask if the user has seed papers to start from

## Step 2: Systematic Search

Use multiple search strategies in order:

### 2a. Direct Search
Use [Paper Search CLI](https://github.com/fcakyon/paper-search-cli); follow [setup](../../commands/setup.md#paper-search-when-needed) if it is missing.

```bash
paper-search search 'object detection' -s fast -n 5
paper-search search 'object detection' -s arxiv,crossref -n 5
```

Inspect the JSON `errors` field and retain each paper's source ID and URL. Report unavailable providers rather than treating errors as an empty literature search. Vary search terms to catch different framings of the same concept. Use web search for proceedings and sources the CLI cannot access.

### 2b. Citation Chaining
From seed papers or initial results:
- **Forward chaining**: run `paper-search tool get_citing_papers <doi>`
- **Backward chaining**: run `paper-search tool get_referenced_papers <doi>`
- Both accept a DOI or OpenAlex work ID, not a title. Inspect pagination and truncation metadata; neither command promises an exhaustive citation list. Read the paper's reference section to verify cited works.
- This catches papers that use different terminology but address the same problem

### 2c. Venue Mining
- Identify top venues for the topic (conferences, journals, workshops)
- Check recent proceedings of these venues for relevant papers
- Workshop papers often contain early-stage work not yet in main conferences

### 2d. Open Source Discovery
- Search GitHub for implementations related to the topic
- Check Papers With Code for the specific task/dataset
- Look for "awesome-X" lists curated by the community

## Step 3: Categorization

Organize found papers into a structured taxonomy:
```
| Paper | Year | Venue | Approach | Key Result | Code? | Relevance |
|-------|------|-------|----------|-----------|-------|-----------|
```

Group by methodology or approach type, not chronologically.

## Step 4: Gap Identification

Map what exists vs. what's missing:

1. **Coverage matrix**: rows = problem aspects, columns = existing approaches
2. **Empty cells** = potential gaps
3. For each candidate gap:
   - Search specifically for work filling this gap (it may exist under different terms)
   - Check very recent papers (last 6 months) that might have addressed it
   - Assess whether the gap is meaningful (would filling it advance the field?)

## Step 5: Gap Validation

For each identified gap, verify it's real:
- [ ] Searched with at least 3 different phrasings
- [ ] Checked proceedings of top-3 venues from last 2 years
- [ ] No preprint on arXiv addressing this gap
- [ ] The gap is technically feasible to address
- [ ] Filling the gap would be a meaningful contribution

Rate confidence: HIGH (extensively searched, clearly missing), MEDIUM (searched but might have missed niche work), LOW (limited search, gap may exist elsewhere).

## Step 6: Output Format

Produce a structured research landscape:

1. **Topic summary** — 2-3 sentence overview of the research area
2. **Paper table** — categorized list with year, venue, approach, results, code availability
3. **Gap table** — identified gaps with confidence levels and evidence
4. **Recommended readings** — top 5-10 most relevant papers for the user's specific work
5. **Candidate citations** — BibTeX entries for papers worth citing (MUST verify against DBLP before presenting)

## Citation Integrity

Every paper mentioned must have verified metadata:
- Author names: cross-check with DBLP or the paper's official page
- Venue and year: confirm against the published version (not preprint)
- Claims about results: only include numbers you can trace to a specific table/figure in the paper
- If uncertain about any detail, flag it explicitly rather than guessing
