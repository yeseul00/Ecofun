package com.study.springboot.dto;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "BOARD")
public class BoardDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "board_sequencer_gen")
	@SequenceGenerator(sequenceName = "board_seq", allocationSize = 1, name = "board_sequencer_gen")
	@Column(name = "b_no")
	private Long bbsNo;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "b_type")
	private String bbsType;

	@Column(name = "b_title")
	private String bbsTitle;

	@Column(name = "b_content", columnDefinition = "CLOB")
	private String bbsContent;

	// @Column(name="b_main_img", columnDefinition="BLOB")
	// private String bbsMainImg; //BLOB를 저장할 땐, String 대신 byte로 받아야함. 수정대신 주석처리 후 실행시 오류X
	//
	@Column(name = "b_thumb")
	private String bbsThumb;

	@Column(name = "b_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime bbsDate;

	@Column(name = "b_update_date")
	private LocalDateTime bbsUpdateDate;

	@Column(name = "b_start", columnDefinition = "date")
	private Date bbsStart;

	@Column(name = "b_end", columnDefinition = "date")
	private Date bbsEnd;

	private LocalDate getBbsStart(Date bbsStart) {
		return bbsStart.toLocalDate();
	}

	private LocalDate getBbsEnd(Date bbsEnd) {
		return bbsEnd.toLocalDate();
	}
}
