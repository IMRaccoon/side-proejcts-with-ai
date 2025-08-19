# Docker Compose 사용을 위한 애플리케이션 실행 가이드

## 1. Docker Compose 서비스 시작

```bash
cd household-budget/infra
export $(cat ../.env | xargs)  # .env 파일 환경변수 로드
docker-compose up -d           # PostgreSQL과 pgAdmin 시작
```

## 2. 애플리케이션 실행

```bash
cd household-budget/app
export $(cat ../.env | xargs)  # .env 파일 환경변수 로드
mvn spring-boot:run            # 또는 dev 프로필: mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

## 3. 서비스 확인

- **애플리케이션**: http://localhost:8080
- **Health Check**: http://localhost:8080/actuator/health
- **pgAdmin**: http://localhost:8081 (admin@example.com / admin)

## 4. Docker Compose 서비스 중지

```bash
cd household-budget/infra
docker-compose down -v  # 볼륨까지 함께 삭제
```
