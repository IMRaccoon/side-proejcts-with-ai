package com.raccoon.householdbudget;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("dev")
class ApplicationTest {

    @Test
    void contextLoads() {
        // Spring Boot 컨텍스트가 정상적으로 로드되는지 검증
    }
}
