# Brain: portable project context

Brain is the canonical home of the task ledger, work diary, research instructions, PhD proposal benchmark, status, correspondence and meeting records. Paths within this folder are relative to the document containing them. The repository root is the parent of Brain.

## Start on another laptop

Clone the complete Paper3_Final repository, then read `Brain/GEMINI.md`, `Brain/Tasks.md` and `Brain/WORK_DIARY.md`. Repository-root `AGENTS.md` and `GEMINI.md` point here. The old laptop's `.gemini` forwarding files are compatibility pointers only; they are not required on the new laptop. Resolve a relative path from its containing document, not from the terminal's current directory.

## Dependency audit and migration scope

- Move the seven requested Markdown files plus the complete `email` and `meeting transcript` directories, including meeting screenshots.
- GEMINI.md refers to email, meeting records, Tasks.md, WORK_DIARY.md, PhD_proposal.md and PhD_Status.md. The analysis-loop note refers to GEMINI.md. PhD_Status.md links to PhD_proposal.md and a historical outline. Rewrite these references for Brain.
- Copied the three original proposal, confirmation and grant-renewal documents into `source_documents`, along with the referenced ethics form, backpack paper, colleague comments and historical outline in Word/Markdown. Kept their originals in place.
- Questionnaire backup is incomplete: only `Questionnaires and their citations.docx` was locally readable. The other 16 files are OneDrive placeholders and could not be hydrated because the cloud provider was not running. They are listed with `blocked_cloud_placeholder` in the manifest. Start OneDrive and make those source files available offline before completing the laptop transfer.
- Existing Obsidian workflow/index/memory notes refer to the old `.gemini` tracking locations. Compatibility forwarding files at those locations point to Brain, preserving discovery without moving the vault.
- `Tasks.md` is approximately 50 MB. It includes historical references across other research and trading projects. Migrating the ledger does not migrate every historical data file, environment, repository or output it mentions.
- Existing references to the parameter-acronym manual and the old `Paper3_Github/Paper3_files/Paper3_structure.md` were missing before migration. They remain unresolved; they must not be assumed to have been transferred.
- Other project repositories, raw sensor data, literature libraries, OneDrive content, software environments and credentials are separate dependencies. Clone/copy those separately for analyses that require them. Historical paths are provenance, not a guarantee that those external files exist.

## Verification and privacy

`migration_manifest.csv` records source paths, original hashes and destination paths. Files are checked after movement/copying and before mechanical path rewriting; final hashes record rewritten content. The manifest intentionally retains original paths as provenance.

Credential-like patterns were checked in the requested text files without printing matched content. This is not an exhaustive secret or privacy review. Correspondence, transcripts, signed ethics records and proposals contain personal/confidential information. Check repository visibility and permissions before publishing. Authentication/configuration files from `.gemini` are excluded.

Keep one canonical copy of each tracking file in Brain. Do not write new task history into the old forwarding files. Status and historical workflow statements retain their original dates; relocation does not validate or refresh their scientific claims.
