win10恢复使用照片查看器打开图片方法：

```
Windows Registry Editor Version 5.00
 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.jpg]
 @="PhotoViewer.FileAssoc.Tiff"

 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.jpeg]
 @="PhotoViewer.FileAssoc.Tiff"

 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.gif]
 @="PhotoViewer.FileAssoc.Tiff"

 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.png]
 @="PhotoViewer.FileAssoc.Tiff"

 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.bmp]
 @="PhotoViewer.FileAssoc.Tiff"

 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.tiff]
 @="PhotoViewer.FileAssoc.Tiff"

 ; Change Extension's File Type
 [HKEY_CURRENT_USER\Software\Classes\.ico]
 @="PhotoViewer.FileAssoc.Tiff"
```

保存为reg文件后导入
