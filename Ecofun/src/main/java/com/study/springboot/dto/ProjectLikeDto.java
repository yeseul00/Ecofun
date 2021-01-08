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
@Table(name = "PROJECT_LIKE")
public class ProjectLikeDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_like_sequencer_gen")
	@SequenceGenerator(sequenceName = "project_like_seq", allocationSize = 1, name = "project_like_sequencer_gen")
	@Column(name = "like_no")
	private Long likeNo;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "like_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime likeDate;

	@Transient
	private ProjectDto projectDto; // #28 좋아한 리스트를 불러오기 위한 객체

}
