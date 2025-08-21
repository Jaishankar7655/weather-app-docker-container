package com.WeatherForcast.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;

    @RestController
    public class WeatherAppController {

        private final String API_KEY = "5598c625e9e565e76416b61f1b95a8a1"; // put your OpenWeatherMap API key here
        private final String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

        @GetMapping("/weather")
        public ResponseEntity<String> getWeather(@RequestParam String city) {
            String url = BASE_URL + "?q=" + city + "&appid=" + API_KEY + "&units=metric";
            RestTemplate restTemplate = new RestTemplate();
            String response = restTemplate.getForObject(url, String.class);
            return ResponseEntity.ok(response);
        }
    }








