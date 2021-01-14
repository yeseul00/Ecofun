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
@Table(name="PRO_REQUEST_STATE")
public class ProRequestStateDto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "pro_request_state_sequencer_gen")
	@SequenceGenerator(sequenceName = "pro_request_state_seq", allocationSize = 1, name = "pro_request_state_sequencer_gen")
	@Column(name="reqs_no")
	private Long reqsNo;
	
	@Column(name="req_no")
	private Long reqNo;
	
	@Column(name="reqs_reply")
	private String reqsReply;
	
	@Column(name="reqs_mem_no")
	private Long reqsMemNo;
	
	@Column(name="reqs_state")
	private String reqsState;
	
	@Column(name="reqs_date", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime reqsDate;
	
}
