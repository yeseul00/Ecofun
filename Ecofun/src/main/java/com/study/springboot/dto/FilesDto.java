package com.study.springboot.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import org.springframework.stereotype.Component;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "FILES")
public class FilesDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "files_sequencer_gen")
	@SequenceGenerator(sequenceName = "files_seq", allocationSize = 1, name = "files_sequencer_gen")
	@Column(name = "files_no")
	private Long filesNo;

	@Column(name = "files_url")
	private String filesUrl;

	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "b_no")
	private Long bNo;

	@Column(name = "apl_no")
	private Long aplNo;

	public FilesDto dup(FilesDto filesDto) {
		FilesDto filesDto2 = filesDto;
		filesDto2.setFilesNo(filesDto.getFilesNo() + 1);
		return filesDto2;
	}

}
