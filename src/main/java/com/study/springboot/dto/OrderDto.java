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
@Table(name="REQ_ORDER")
public class OrderDto {
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "order_sequencer_gen")
	@SequenceGenerator(sequenceName = "order_seq", allocationSize = 1, name = "order_sequencer_gen")
	@Column(name="order_no")
	private Long orderNo;
	
	@Column(name="pro_no")
	private Long proNo;
	
	@Column(name="state")
	private String state;
	
	@Column(name="price")
	private int price;
	
	@Column(name="count")
	private int count;
	
	@Column(name="total_price")
	private int totalPrice;
	
	@Column(name="mem_no")
	private Long memNo;
	
	@Column(name="mem_tel")
	private String memTel;
	
	@Column(name="postal_code")
	private int postalCode;
	
	@Column(name="address1")
	private String address1;
	
	@Column(name="address2")
	private String address2;
	
	@Column(name="address3")
	private String address3;
	
	@Column(name="request")
	private String request;

	@Column(name="none")
	private String none;

	@Column(name="bank_name")
	private String bankName;
	
	@Column(name="account_name")
	private String accountName;
	
	@Column(name="account_number")
	private int accountNumber;
	
	@Column(name="order_date", columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime orderDate;
	
	// @Transient DB와 매핑시키지 않음
	@Transient
	private ProjectDto projectDto; // #26 참여리스트에서 #27 참여 상세 정보를 담기 위한 객체
	
	@Transient
	private String projectMemberName; // #26 프로젝트 주최자 이름을 담기 위한 변수
	
	@Column(name="to_name")
	private String toName;
	
	@Column(name="to_tel")
	private String toTel;
}