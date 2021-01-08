package com.study.springboot.dto;

import java.sql.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
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
@Table(name = "PROJECT")
public class ProjectDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_sequencer_gen")
	@SequenceGenerator(sequenceName = "project_seq", allocationSize = 1, name = "project_sequencer_gen")
	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "pro_state")
	private String proState;

	@Column(name = "pro_type")
	private String proType;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "pro_Title")
	private String proTitle;

	@Column(name = "pro_content", columnDefinition = "CLOB")
	@Lob
	private String proContent;

	@Column(name = "pro_thumb")
	private String proThumb;

	@Column(name = "op_no")
	private Long opNo;

	@Column(name = "pro_start", columnDefinition = "date")
	private Date proStart;

	@Column(name = "pro_end", columnDefinition = "date")
	private Date proEnd;

	@Column(name = "pro_target")
	private int proTarget;

	@Column(name = "pro_now")
	private Long proNow;

	@Column(name = "proceed")
	private int proceed;

	@Column(name = "pro_hit")
	private Long proHit;

	@Transient
	private ImgDto imgDto; // 참여리스트에서 이미지를 불러오기 위한 객체
}
