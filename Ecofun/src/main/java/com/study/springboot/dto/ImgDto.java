package com.study.springboot.dto;

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
@Table(name = "IMG")
public class ImgDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "img_sequencer_gen")
	@SequenceGenerator(sequenceName = "img_seq", allocationSize = 1, name = "img_sequencer_gen")
	@Column(name = "img_no")
	private Long imgNo;

	@Column(name = "img_url")
	private String imgUrl;

	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "b_no")
	private Long bNo;

	@Column(name = "apl_no")
	private Long aplNo;

}
