package com.study.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.springboot.dto.FilesDto;

@Repository
public interface FilesRepository extends JpaRepository<FilesDto, Long> {

}
