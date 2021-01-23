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
@Table(name = "PRO_COMMENT")
public class ProCommentDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "pro_cmt_no_sequencer_gen")
	@SequenceGenerator(sequenceName = "pro_cmt_seq", allocationSize = 1, name = "pro_cmt_sequencer_gen")
	@Column(name = "pro_cmt_no")
	private Long proCmtNo;

	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "pro_comment")
	private String proComment;

	@Column(name = "pro_cmt_mem_no")
	private Long proCmtMemNo;

	@Column(name = "pro_cmt_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime proCmtDate;
}