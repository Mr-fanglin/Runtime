# Runtime  
runtime相关代码  

# Runtime  

## 1.消息转发  
  * 动态消息解析 （resolveInstanceMethod）  
  * 快速转发 （forwardingTargetForSelector）  
  * 慢速转发  
      * 方法签名 （methodSignatureForSelector）  
      * 消息转发 （forwardInvocation）  
  
  如果消息转发失败，会调用 doesNotRecognizeSelector 方法  
注：以上流程可以解决app的健壮性，可以防止app闪退  


## 2.Method Swizzling   
  方法交换 method_exchangeImplementations  
  例：UITableView 中 dataSource 为空时显示默认背景图片  
  关键代码：  
    `
     Method originMethod = class_getInstanceMethod(self, @selector(reloadData));    
     Method currentMethod = class_getInstanceMethod(self, @selector(fl_reloadData));    
     method_exchangeImplementations(originMethod, currentMethod); 
     `
  
