package com.study.springboot.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;
import com.study.springboot.dto.ApplyDto;
import com.study.springboot.dto.BoardDto;
import com.study.springboot.dto.ImgDto;
import com.study.springboot.dto.ProjectDto;
import com.study.springboot.repository.ImgRepository;

@Service
public class ImgService {

	private static String SAVE_PATH = "/upload/thumbnails/";
	private static String PREFIX_URL = "/upload/thumbnails/";

	@Autowired
	private ImgRepository imgRepository;

	// Project Request 용
	public String restore(ApplyDto applyDto, ImgDto imgDto, MultipartFile multipartFile) {
		String url = null;

		try {
			String savePath = ResourceUtils.getFile("classpath:static/upload/thumbnails/").toPath().toString();
			savePath = savePath.replace("\\", "/");
			savePath = savePath.replace("/bin/main/static", "/src/main/resources/static");
			SAVE_PATH = savePath;
			PREFIX_URL = savePath;
			System.out.println("save path : " + savePath);

			String originName = multipartFile.getOriginalFilename();
			Long originSize = multipartFile.getSize();
			String extension = originName.substring(originName.lastIndexOf("."));
			String saveName = getSaveFileName(extension);
			writeFile(multipartFile, saveName);
			System.out.println("origin: " + originName + " (" + originSize + ")");
			System.out.println("save name: " + saveName);

			url = PREFIX_URL + "/" + saveName;
			imgDto.setImgUrl(url);
			imgDto.setAplNo(applyDto.getAplNo());
			imgRepository.save(imgDto);
			System.out.println("save url: " + imgDto.getImgUrl());
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return url;
	}

	// Project Insert 용
	public String save(ProjectDto projectDto, ImgDto imgDto, MultipartFile multipartFile) {
		String url = null;

		try {
			String savePath = ResourceUtils.getFile("classpath:static/upload/thumbnails/").toPath().toString();
			savePath = savePath.replace("\\", "/");
			savePath = savePath.replace("/bin/main/static", "/src/main/resources/static");
			System.out.println("save path: " + savePath);
			SAVE_PATH = savePath;
			PREFIX_URL = savePath;

			String originName = multipartFile.getOriginalFilename();
			Long originSize = multipartFile.getSize();
			String extension = originName.substring(originName.lastIndexOf("."));
			String saveName = getSaveFileName(extension);
			writeFile(multipartFile, saveName);
			System.out.println("origin: " + originName + " (" + originSize + ")");
			System.out.println("save name: " + saveName);

			url = PREFIX_URL + "/" + saveName;
			imgDto.setImgUrl(url);
			imgDto.setProNo(projectDto.getProNo());
			imgRepository.save(imgDto);
			System.out.println("save url: " + imgDto.getImgUrl());
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return url;
	}

	// Board Insert 용
	public String restore(BoardDto BoardDto, ImgDto imgDto, MultipartFile multipartFile) {
		String url = null;

		try {
			String savepath = ResourceUtils.getFile("classpath:static/upload/thumbnails/").toPath().toString();
			savepath = savepath.replace("\\", "/");
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static");
			SAVE_PATH = savepath;
			PREFIX_URL = savepath;
			System.out.println("save path: " + savepath);

			String originName = multipartFile.getOriginalFilename();
			Long originSize = multipartFile.getSize();
			String extension = originName.substring(originName.lastIndexOf("."));
			String saveName = getSaveFileName(extension);
			writeFile(multipartFile, saveName);
			System.out.println("origin: " + originName + " (" + originSize + ")");
			System.out.println("save name: " + saveName);

			url = PREFIX_URL + "/" + saveName;
			imgDto.setImgUrl(url);
			imgDto.setBNo(BoardDto.getBbsNo());
			BoardDto.setBbsThumb(imgDto.getImgUrl());
			imgRepository.save(imgDto);
			System.out.println("save url: " + imgDto.getImgUrl());
		} catch (IOException e) {
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
		System.out.println("save file: " + SAVE_PATH + "/" + saveFileName);
		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();
	}
}
