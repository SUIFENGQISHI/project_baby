package com.example.controller;
import cn.hutool.core.io.FileUtil;
import com.example.common.Result;
import com.example.exception.CustomException;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;


@RestController
@RequestMapping("/files")
public class FileController {
    private static final String fileDirPath = System.getProperty("user.dir")+"/files/";

    @PostMapping("/upload")
    public Result upload(MultipartFile file)   {
        String originalFilename = file.getOriginalFilename();
        if(!FileUtil.isDirectory(fileDirPath)){
            FileUtil.mkdir(fileDirPath);
        }
        String fileName=System.currentTimeMillis()+"_"+originalFilename;
        String filePath = fileDirPath+fileName;
        try{
            FileUtil.writeBytes(file.getBytes(),filePath);
        }
        catch (Exception e){
            throw new CustomException("500","上传失败");
        }
        String url="http://localhost:8080/files/download/"+fileName;
        return Result.success(url);
    }

    @GetMapping("/download/{fileName}")
    public void download(@PathVariable String fileName, HttpServletResponse response){
        try {
            response.addHeader("Content-Disposition","attachment;filename="+ URLEncoder.encode(fileName, StandardCharsets.UTF_8));
            OutputStream os=response.getOutputStream();
            String filePath=fileDirPath+fileName;
            byte[] bytes= FileUtil.readBytes(filePath);
            os.write(bytes);
            os.flush();
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
            throw new CustomException("500","文件下载失败");
        }


    }
}
