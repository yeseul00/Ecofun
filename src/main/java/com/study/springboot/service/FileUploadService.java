package com.study.springboot.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.FilesDto;
import com.study.springboot.dto.ProRequestDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.repository.FilesRepository;

@Service
public class FileUploadService {
	// 리눅스 기준으로 파일 경로를 작성 ( 루트 경로인 /으로 시작한다. )
	// 윈도우라면 workspace의 드라이브를 파악하여 JVM이 알아서 처리해준다.
	// 따라서 workspace가 C드라이브에 있다면 C드라이브에 upload 폴더를 생성해 놓아야 한다.
	private static String SAVE_PATH = "/File_upload/"; // 디폴트는 C:/upload폴더에 생성됨.
	private static String PREFIX_URL = "/File_upload/";
	@Autowired
	private FilesRepository filesrepository;

	// Project Request 용
	public String restore(ProRequestDto proRequest, FilesDto filesDto, MultipartFile multipartFile) {
		String url = null;

		try {
			String savepath = ResourceUtils.getFile("classpath:static/File_upload/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;

			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();

			// 서버에서 저장 할 파일 이름
			String saveFileName = getSaveFileName(extName);

			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);

			writeFile(multipartFile, saveFileName);

			url = PREFIX_URL + "/" + saveFileName;

			filesDto.setFilesUrl(url);
			filesDto.setReqNo(proRequest.getReqNo());

			filesrepository.save(filesDto);
			System.out.println(filesDto.getFilesUrl());
		} catch (IOException e) {
			// 원래라면 RuntimeException을 상속받은 예외가 처리되어야 하지만, 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();
			throw new RuntimeException(e);
		}
		return url;
	}

	// Project Insert 용
	public String restore(ProjectDto projectDto, FilesDto filesDto, MultipartFile multipartFile) {
		String url = null;

		try {
			String savepath = ResourceUtils.getFile("classpath:static/File_upload/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;

			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();

			// 서버에서 저장 할 파일 이름
			String saveFileName = getSaveFileName(extName);

			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);

			writeFile(multipartFile, saveFileName);

			url = PREFIX_URL + "/" + saveFileName;

			filesDto.setFilesUrl(url);
			filesDto.setProNo(projectDto.getProNo());

			filesrepository.save(filesDto);
			System.out.println(filesDto.getFilesUrl());
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return url;
	}

	// BoardInsert Request 용
	public String restore(BoardDto boardDto, FilesDto filesDto, MultipartFile multipartFile) {
		String url = null;

		try {
			String savepath = ResourceUtils.getFile("classpath:static/File_upload/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			System.out.println("savepath2 : " + savepath);
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("savepath3 : " + savepath);
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;

			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			Long size = multipartFile.getSize();

			// 서버에서 저장 할 파일 이름
			String saveFileName = getSaveFileName(extName);

			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);

			writeFile(multipartFile, saveFileName);

			url = PREFIX_URL + "/" + saveFileName;

			filesDto.setFilesUrl(url);
			filesDto.setBNo(boardDto.getBbsNo());
			filesrepository.save(filesDto);

		} catch (IOException e) {
			// 원래라면 RuntimeException을 상속받은 예외가 처리되어야 하지만, 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();
			throw new RuntimeException(e);
		}
		return url;
	}

	// 현재 시간을 기준으로 파일 이름 생성
	private String getSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;

		return fileName;
	}

	// 파일을 실제로 write 하는 메서드
	private void writeFile(MultipartFile multipartFile, String saveFileName) throws IOException {
		System.out.println("savefile:" + SAVE_PATH + "/" + saveFileName);

		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();

		return;
	}
}

// 다중업로드
//Iterator<String> files = multipartFile.getFileNames();
//
//while(files.hasNext()) {
//	String saveFile = files.next();
//	
//	MultipartFile file=multipartFile.getFile(saveFile);
//	String originFilename = file.getOriginalFilename();
//	
//	writeFile(file, originFilename);
//	url = "/File_upload/" + originFilename;
//}