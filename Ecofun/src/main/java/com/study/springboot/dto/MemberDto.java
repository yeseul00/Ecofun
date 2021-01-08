package com.study.springboot.dto;

import java.time.LocalDate;
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
@Table(name = "MEMBER")
public class MemberDto {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "member_sequencer_gen")
	@SequenceGenerator(sequenceName = "member_seq", allocationSize = 1, name = "member_sequencer_gen")
	@Column(name = "mem_no")
	private Long memNo;

	@Column(name = "mem_id", unique = true, nullable = false)
	private String memId;

	@Column(name = "mem_pw")
	private String memPw;

	@Column(name = "mem_name")
	private String memName;

	@Column(name = "mem_tel")
	private String memTel;

	@Column(name = "mem_join_date", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
	private LocalDateTime memJoinDate;

	@Transient
	private Long projectOrderCount; // 관리자 회원목록에서 프로젝트 참여 횟수를 담기 위한 변수
	
	public LocalDate getMemJoinDate() {
		return this.memJoinDate.toLocalDate();
	}
}
