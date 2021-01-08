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
@Table(name = "ADDRESS")
public class AddressDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "address_sequencer_gen")
	@SequenceGenerator(sequenceName = "address_seq", allocationSize = 1, name = "address_sequencer_gen")
	@Column(name = "delivery_no")
	private Long deliveryNo;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "address_mem_name")
	private String addressMemName;

	@Column(name = "postal_code")
	private int postalCode;

	@Column(name = "address1")
	private String address1;

	@Column(name = "address2")
	private String address2;

	@Column(name = "address3")
	private String address3;

	@Column(name = "address4")
	private String address4;

	@Column(name = "address_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime addressDate;

}
