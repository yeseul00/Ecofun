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
@Table(name = "ASK")
public class AskDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ask_sequencer_gen")
	@SequenceGenerator(sequenceName = "ask_seq", allocationSize = 1, name = "ask_sequencer_gen")
	@Column(name = "ask_no")
	private Long askNo;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "ask_title")
	private String askTitle;

	@Column(name = "ask_content")
	private String askContent;

	@Column(name = "ask_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime askDate;

	@Column(name = "ask_state")
	private String askState;

	@Column(name = "ask_comment")
	private String askCmt;
}
