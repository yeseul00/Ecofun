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
@Table(name = "MEMBER_ACCOUNT")
public class MemberAccountDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "member_account_sequencer_gen")
	@SequenceGenerator(sequenceName = "member_account_seq", allocationSize = 1, name = "member_account_sequencer_gen")
	@Column(name = "account_no")
	private Long accountNo;

	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "bank_name")
	private String bankName;

	@Column(name = "account_name")
	private String accountName;

	@Column(name = "account_number")
	private int accountNumber;

	@Column(name = "account_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime accountDate;
}