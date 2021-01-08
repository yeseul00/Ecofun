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
@Table(name = "APPLY")
public class ApplyDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "apply_sequencer_gen")
	@SequenceGenerator(sequenceName = "apply_seq", allocationSize = 1, name = "apply_sequencer_gen")
	@Column(name = "apl_no")
	private Long aplNo;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "apl_title")
	private String aplTitle;

	@Column(name = "apl_content", columnDefinition = "CLOB")
	private String aplContent;

	@Column(name = "apl_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime aplDate;

	@Column(name = "apl_state")
	private String aplState;

	@Column(name = "apl_comment")
	private String aplCmt;
}
