package com.bangkok.info.controller;

import java.util.ArrayList;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.bangkok.util.file.FileUtil;
import com.bangkok.category.service.CategoryService;
import com.bangkok.category.vo.CategoryVO;
import com.bangkok.cityPlace.service.CityPlaceService;
import com.bangkok.cityPlace.vo.CityVO;
import com.bangkok.info.service.InfoService;
import com.bangkok.info.vo.InfoImageVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/info")
public class InfoController {
    
    // InfoService와 CategoryService를 주입하기 위한 설정
    @Inject
    @Qualifier("infoServiceImpl")
    private InfoService service;

    @Autowired
    @Qualifier("categoryServiceImpl")
    private CategoryService cate_service;
    
	@Autowired
	@Qualifier("cityServiceImpl")
	private CityPlaceService cityService;

    // 파일이 저장될 경로 설정
   private String path = "/upload/info";



    // 정보 목록을 가져오는 메서드
    @GetMapping("/list.do")
    public String list(Model model, HttpServletRequest request, String cityname, String countrycode, String imageFile) throws Exception {
        // 페이지 객체 생성
        PageObject pageObject = PageObject.getInstance(request);
        // 모델에 정보 목록과 페이지 객체 추가
        model.addAttribute("list", service.list(pageObject, cityname, countrycode, imageFile));
        model.addAttribute("pageObject", pageObject);
        return "info/list"; // 목록 페이지로 이동
    }

    // 특정 정보를 조회하는 메서드
    @GetMapping("/view.do")
    public String view(Model model, Long no, @RequestParam(defaultValue = "0") Integer cate_code1, String Place, String filename) {
        // 정보 조회
        InfoVO vo = service.view(no);
        // 이미지 목록 조회
        List<InfoImageVO> imageList = service.imageList(no);

        
        log.info("Place-----------------" + Place);
        log.info("Category Name: " + vo.getCate_name());

        // 모델에 정보와 이미지 목록 추가
        model.addAttribute("vo", vo);
        model.addAttribute("imageList", imageList);
        return "info/view"; // 상세 페이지로 이동
    }

    // 정보 작성을 처리하는 메서드
    @PostMapping("/write.do")
    public String write(InfoVO vo, 
    		@RequestParam("mainFile") MultipartFile mainFile, // 대표사진
                        ArrayList<MultipartFile> sub_image, // 추가사진
                        HttpServletRequest request,
                        
                     // 페이지 번호를 받아올 수 있도록 Long 타입으로 선언.
            	        @RequestParam(name = "perPageNum", defaultValue = "10") Long perPageNum, 
            	         RedirectAttributes rttr) throws Exception {
    	
    	List<CityVO> cityList = cityService.cityList();

        log.info("write.do");
        // 대표 이미지 파일 이름 로그
        log.info("Main File: " + mainFile.getOriginalFilename());
        
        // 추가 이미지 파일 이름 로그
        for(MultipartFile file : sub_image)
            log.info(file.getOriginalFilename());

        // 대표 이미지 파일 처리.
        vo.setImageFile(FileUtil.upload(path, mainFile, request));

        log.info(vo); // VO 상태 로그
        log.info("cityList--------------------" + cityList);
        log.info("CityNum: " + vo.getCityNum());  // cityNum 값이 제대로 설정되었는지 확인
        
        
        // file upload 유효성 검사
        if (mainFile.getSize() > 5 * 1024 * 1024) { // 5MB 이상
            rttr.addFlashAttribute("msg", "파일 크기는 5MB 이하이어야 합니다.");
            return "redirect:writeForm.do";
        }

        
        
        List<InfoImageVO> imageList = null; // 이미지 목록 초기화
        // 추가 이미지 파일 처리
        if(sub_image != null && sub_image.size() > 0) { // 추가 이미지가 있는 경우
            for(MultipartFile file : sub_image) {
                if(imageList == null) imageList = new ArrayList<>(); // 이미지 목록 초기화
//                fileName = file.getOriginalFilename(); // 파일 이름 가져오기
                // 파일이 비어있지 않은 경우 처리
                if(mainFile != null && !mainFile.equals("")) {
                    InfoImageVO imageVO = new InfoImageVO(); // 이미지 VO 생성
                    imageVO.setFilename(FileUtil.upload(path, file, request)); // 추가 이미지 업로드
                    imageList.add(imageVO); // 이미지 목록에 추가
                }
            }
        }
        // DB에 정보와 이미지 목록 저장
        service.write(vo, imageList);

        
     // 처리결과에 대한 메시지 처리. 1번만 사용됨
     		log.info("write!" + vo.getNo());
     		rttr.addFlashAttribute("msg", "write!");
     		
        log.info(vo); // 최종 VO 상태 로그
        // 첨부 이미지 목록 확인
        log.info("Attached Images: " + imageList);
       
        return "redirect:list.do?perPageNum=" + perPageNum;
    }


    @GetMapping("/writeForm.do")
    public String writeForm(Model model) {
        // 카테고리 목록 가져오기
        List<CategoryVO> cateList = cate_service.list();
        List<CityVO> cityList = cityService.cityList();
        log.info("bigList=" + cateList); // 카테고리 목록 로그
        
        
        model.addAttribute("cateList", cateList); // 모델에 카테고리 목록 추가
        model.addAttribute("cityList", cityList); // 모델에 카테고리 목록 추가
        
        return "info/writeForm"; // 작성 폼 페이지로 이동
    }

    
  //--- category 가져오기 ------------------------------------
    @GetMapping("/getcateList.do")
    public String getCateList(Model model) {
        log.info("getcateList.do");
        // Fetch the category list from the service
        List<CategoryVO> cateList = cate_service.list();
        model.addAttribute("cateList", cateList);
        // Return the view name
        return "category/cateList";
    }

    //--- 도시 가져오기 ------------------------------------
    @GetMapping("/city.do")
    public String getCityList(Model model, @RequestParam Integer cate_code1) {
        log.info("getCityList.do with cate_code1: " + cate_code1);
        // Fetch the city list based on the category code
        List<CityVO> cityList = cityService.cityList(); // cate_code1을 매개변수로 전달
        model.addAttribute("cityList", cityList);
        // Return the view name
        return "cityPlace/cityList";
    }


  		

    // 정보 수정 폼을 보여주는 메서드
    @GetMapping("/updateForm.do")
    public String updateForm(Model model, @RequestParam Long no) {
    	
    	 List<InfoImageVO> imageList = service.imageList(no);
    	 log.info("imageList--------------" + imageList);
    	 
        model.addAttribute("vo", service.view(no)); // 수정할 정보 가져오기
        model.addAttribute("imageList", imageList);
        return "info/updateForm"; // 수정 폼 페이지로 이동
    }

    // 정보 수정 처리 메서드
    @PostMapping("/update.do")
    public String update(InfoVO vo, RedirectAttributes rttr) {
        if(service.update(vo) == 1) // 수정 성공
            rttr.addFlashAttribute("msg", "update");
        else
            rttr.addFlashAttribute("msg", "update error");
        
        return "redirect:view.do?no=" + vo.getNo(); // 수정 후 상세 페이지로 리다이렉트
    }

    // 정보 삭제 처리 메서드
    @GetMapping("/delete.do")
    public String delete(InfoVO vo, RedirectAttributes rttr) {
        if(service.delete(vo) == 1) { // 삭제 성공
            rttr.addFlashAttribute("msg", "delete");
            return "redirect:list.do"; // 목록 페이지로 리다이렉트
        } else {
            rttr.addFlashAttribute("msg", "delete error");
            return "redirect:view.do?no=" + vo.getNo(); // 상세 페이지로 리다이렉트
        }
    }
    
}
