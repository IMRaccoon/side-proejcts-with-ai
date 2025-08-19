# DB Conventions (Shared)

- PostgreSQL. snake_case, id BIGSERIAL/UUID, created_at/updated_at 기본.
- 마이그레이션: Flyway, repeatable로 뷰/함수 관리.
- 낙관적 락(version 컬럼) 권장, Outbox 패턴(비동기 이벤트) 옵션.
