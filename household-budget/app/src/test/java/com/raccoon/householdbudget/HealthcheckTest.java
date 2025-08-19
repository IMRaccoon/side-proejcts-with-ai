package com.raccoon.householdbudget;

import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

import org.junit.jupiter.api.Test;

public class HealthcheckTest extends E2EBase {

  @Test
  void actuatorHealthShouldReturn200() {
    given().when().get("/actuator/health").then().statusCode(200).body("status", equalTo("UP"));
  }
}
