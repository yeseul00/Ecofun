package com.study.springboot.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
@Table(name = "PROJECT_CMT")
public class ProjectCmtDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_cmt_sequencer_gen")
	@SequenceGenerator(sequenceName = "project_cmt_seq", allocationSize = 1, name = "project_cmt_sequencer_gen")
	@Column(name = "pro_cmt_no")
	private Long cmtNo;

	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "pro_comment")
	private String comment;

	@Column(name = "pro_cmt_mem_no")
	private Long cmtMemNo;

	@Column(name = "pro_cmt_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime cmtDate;

	public String getCmtDate() {
		return cmtDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd (hh:mm:ss)"));		
	}
}