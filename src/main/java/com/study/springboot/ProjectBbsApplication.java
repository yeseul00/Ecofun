package com.study.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class ProjectBbsApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectBbsApplication.class, args);
	}

}
