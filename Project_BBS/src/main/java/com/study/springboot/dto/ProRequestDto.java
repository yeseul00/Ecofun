package com.study.springboot.dto;

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
@Table(name="PRO_REQUEST")
public class ProRequestDto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "pro_request_sequencer_gen")
	@SequenceGenerator(sequenceName = "pro_request_seq", allocationSize = 1, name = "pro_request_sequencer_gen")
	@Column(name="req_no")
	private Long reqNo;
	
	@Column(name="mem_no")
	private Long memNo;
	
	@Column(name="req_title")
	private String reqTitle;
	
	@Column(name="req_content" , columnDefinition="CLOB")
	private String reqContent;
	
	@Column(name="req_date", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime reqDate;
	
	@Column(name="req_reply")
	private String reqReply;
	
	@Column(name="req_mem_no")
	private Long reqMemNo;
	
}
