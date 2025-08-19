# Contributing

## Branching

- 기본: `main`, `develop`
- 프로젝트별: `{project명}/feature/*`, `{project명}/fix/*`

## Commit

- Conventional Commits 권장:
  - `feat: ...`
  - `fix: ...`
  - `docs: ...`
  - `refactor: ...`
  - `test: ...`
  - `chore: ...`

## Pull Requests

- CI (`mvn -B verify`) 통과 필수.
- Lint/Format 통과 필수.
- 변경 범위는 “시킨 것만 고치기” 원칙.

## Code Review

- CODEOWNERS(@IMRaccoon) 승인 필수.
- 큰 변경은 ADR 문서 동반.
