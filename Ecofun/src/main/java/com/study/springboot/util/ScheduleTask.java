package com.study.springboot.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.study.springboot.service.ProjectService;

@Component
public class ScheduleTask {

	@Autowired
	ProjectService projectService;

	/**
	 * cron = "* * * * * *" 초 (0~59) 분 (0~59) 시 (0~23) 일 (1~31) 월 (1~12) 요일 (0~7) ex) 오후 5시 30분 07초 -> cron = "7 30 17 * * *"
	 */
	@Scheduled(cron = "0 0 0 * * *") // 자정에 호출
	public void projectStateUpdate() {
		System.out.println("자정에 호출");
		projectService.stateUpdateScheduler();
	}

	/**
	 * 서버 시작시 10(initialDelay)초 후 부터 20초(fixedDelay) 간격으로 호출 fixedDelay = 이전 작업이 종료된 후 20,000 밀리세컨드 후 호출 (반복 호출, update 테스트 용도) fixedRate = 이전 작업이 종료되지 않아도 시작
	 */
	@Scheduled(fixedDelay = 300000, initialDelay = 60000)
	public void projectStateUpdateTest() {
		System.out.println("300,000 밀리세컨드 후 호출");
		projectService.stateUpdateScheduler();
	}

}
