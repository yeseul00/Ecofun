package com.study.springboot.dto;

import java.util.HashSet;
import java.util.Set;
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
@Table(name = "PROJECT_OPTION")
public class ProjectOptionDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PROJECT_OPTION_sequencer_gen")
	@SequenceGenerator(sequenceName = "PROJECT_OPTION_seq", allocationSize = 1, name = "PROJECT_OPTION_sequencer_gen")
	@Column(name = "op_no")
	private Long opNo;

	@Column(name = "pro_no")
	private Long proNo;

	@Column(name = "price")
	private int price;

	@Column(name = "op_name")
	private String opName;

	@Column(name = "op_used", nullable = false, length = 1, columnDefinition = "CHAR(1) DEFAULT 'y'")
	private String opUsed;

	@Transient
	private Set<Integer> priceArr = new HashSet<>();

	@Transient
	private Set<String> opNameArr = new HashSet<>();

	// public OrderOptionDto dup(OrderOptionDto optionDto) {
	// OrderOptionDto optionDto2 = optionDto;
	// optionDto2.setOpNo(optionDto.getOpNo() + 1);
	// return optionDto2;
	// }
}
