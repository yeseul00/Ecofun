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
	 * cron = "* * * * * *"
	 * 珥?(0~59)
	 * 遺?(0~59)
	 * ??(0~23)
	 * ??(1~31)
	 * ??(1~12)
	 * ?붿씪 (0~7)
	 * ex) ?ㅽ썑 5??30遺?07珥?-> cron = "7 30 17 * * *"
	 */
	@Scheduled(cron = "0 0 0 * * *") // ?먯젙???몄텧
	public void projectStateUpdate() {
		System.out.println("?먯젙???몄텧");
		projectService.stateUpdateScheduler();
	}
	
	/**
	 * ?쒕쾭 ?쒖옉??10(initialDelay)珥???遺??20珥?fixedDelay) 媛꾧꺽?쇰줈 ?몄텧
	 * fixedDelay = ?댁쟾 ?묒뾽??醫낅즺????20,000 諛由ъ꽭而⑤뱶 ???몄텧 (諛섎났 ?몄텧, update ?뚯뒪???⑸룄)
	 * fixedRate = ?댁쟾 ?묒뾽??醫낅즺?섏? ?딆븘???쒖옉
	 */
	@Scheduled(fixedDelay = 300000, initialDelay = 60000)
	public void projectStateUpdateTest() {
		System.out.println("300,000 諛由ъ꽭而⑤뱶 ???몄텧");
		projectService.stateUpdateScheduler();
	}
	
}
