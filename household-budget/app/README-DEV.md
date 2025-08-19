# Dev Notes

## Run

- `make up` (DB)
- IntelliJ에서 Spring Boot 앱 실행 또는 `mvn spring-boot:run`

## Test

- `mvn -B verify` (Testcontainers가 자동으로 DB 기동)

## Troubleshooting

- 로컬 포트 충돌 시 `.env`에서 `POSTGRES_PORT` 변경
