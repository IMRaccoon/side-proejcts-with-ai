# Repository-wide Copilot Instructions

## Build & Test

- Java 21 + Spring Boot 3.3.x (Maven).
- 통합 테스트: Testcontainers(PostgreSQL). 기본 명령: `mvn -B verify`.

## Coding Standards

- Controller → Service → Repository 3계층, DTO/Entity/Mapper 분리.
- API는 오직 OpenAPI 스펙(`./shared/assets/schemas/api_common.yaml` + 각 프로젝트 `docs/API.yaml`)을 단일 근거로 삼을 것.
- 환경 분리(dev/test/prod) 고려. 기본 가정: dev.

## AI Guardrails (Global)

- 테스트 코드/공용 API 파라미터/마이그레이션 파일 **수정 금지**.
- 라이브러리/런타임 버전 **임의 변경 금지**.
- 문맥이 모호하면 변경 전에 반드시 코멘트를 남겨 질문할 것.

## Shared Knowledge

- 공통 규칙과 힌트: `./shared/docs/03_AI_rules_global.md`
