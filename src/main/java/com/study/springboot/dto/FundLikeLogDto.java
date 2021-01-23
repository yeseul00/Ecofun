package com.study.springboot.dto;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="FUND_LIKE_LOG")
public class FundLikeLogDto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "fund_like_log_sequencer_gen")
	@SequenceGenerator(sequenceName = "fund_like_log_seq", allocationSize = 1, name = "fund_like_log_sequencer_gen")
	@Column(name="fund_like_no")
	private Long fundLikeNo;
	
	@Column(name="mem_no")
	private Long memNo;
	
	@Column(name="pro_no")
	private Long proNo;
	
	@Column(name="like_date", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime likeDate;
	
	@Transient
	private ProjectDto projectDto; // #28 좋아한 리스트를 불러오기 위한 객체
	
}