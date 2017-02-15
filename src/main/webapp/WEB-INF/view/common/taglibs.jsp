<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:set var="shear_admin_url" value="http://localhost:8080" />  --%>
<c:set var="shear_admin_url" value="http://m.qiansishun.com/v1" />
<c:set var="admin_js" value="http://www.qiansishun.com:8180/admin.js" />
<c:set var="admin_css" value="http://www.qiansishun.com:8180/admin.css" />
<c:set var="admin_img" value="http://www.qiansishun.com:8180/admin.img" />
<c:set var="shop_img" value="http://www.qiansishun.com:8180/shop.img" />
<c:set var="user_img" value="http://www.qiansishun.com:8180/user.img" />
<c:set var="hairstyle_img" value="http://www.qiansishun.com:8180/hairstyle.img" />

<script type="text/javascript" src="${admin_js}/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${admin_js}/common.js"></script>
<script type="text/javascript" src="${admin_js}/fastclick.js"></script>
<script type="text/javascript">
        //移动设备快速响应点击事件
        $(document).ready(function(){
            FastClick.attach(document.body);
        });
</script>
<link type="text/css" rel="stylesheet" href="${admin_css}/common.css">
<!-- <link type="text/css" rel="stylesheet" href="${admin_css}/user_center.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/personal_set.css">-->
