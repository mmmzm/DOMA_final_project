<%--
/**
    Class Name: 
    Description:
    Author: acorn
    Modification information
    
    수정일     수정자      수정내용
    -----   -----  -------------------------------------------
    2024. 7. 30        최초작성 
    
    DOMA 개발팀
    since 2020.11.23
    Copyright (C) by KandJang All right reserved.
*/
 --%>
<%@page import="com.acorn.doma.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- favicon  --%>
<link rel="shortcut icon" href="${CP}/resources/img/favicon.ico" type="image/x-icon">

<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css">

<%-- jquery --%>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<%-- common js --%>
<script src="${CP}/resources/js/common.js"></script>

<%-- google Nanum+Gothic --%>
<link rel="stylesheet"  href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">

<%-- FontAwesome for icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- simplemde -->
<link rel="stylesheet" href="${CP }/resources/css/bootstrap/simplemde.min.css">

<script src="${CP }/resources/js/bootstrap/simplemde.min.js"></script>

<style>
    .readonly-input {
        background-color: #e9ecef;
    }
</style>

<title>acorn</title>
<script>
document.addEventListener("DOMContentLoaded", function(){
    console.log("DOMContentLoaded");
//객체 생성=================================================================================================    
    //moveToList : 목록으로 이동
    const moveToListBtn = document.querySelector("#moveToList");
    
    //doDelete : 삭제
    const doDeleteBtn = document.querySelector("#doDelete");
    console.log("doDeleteBtn", doDeleteBtn);
    
    //doUpdate : 수정
    const doUpdateBtn = document.querySelector("#doUpdate");
    
    //seq
    const seqInput = document.querySelector("#seq");
    
    //div
    const divInput = document.querySelector("#div");
    
    //구이름
    const gnameInput = document.querySelector("#gname");
    
    //제목
    const titleInput = document.querySelector("#title");
    
    //이미지
    const imgLinkInput = document.querySelector("#imgLink");
    
    //내용
    const contentsTextArea = document.querySelector("#content");
    
    //구분
    const searchDivSelect = document.querySelector("#searchDiv");
    
    
    const modIdInput = document.querySelector("#modId");
    

//이벤트 처리=================================================================================================
    //moveToListBtn
    moveToListBtn.addEventListener("click",function(event){
        console.log("moveToListBtn click");
        event.stopPropagation();
        if(confirm("목록 으로 이동 하시겠습니까?") === false)return;
        moveToList();
    });
    
    //doUpdate : 수정
    doUpdateBtn.addEventListener("click",function(event){
        console.log("doUpdateBtn click");
        event.stopPropagation();
        doUpdate();
    });
    
    //doDelete : 삭제
    doDeleteBtn.addEventListener("click",function(event){
        console.log("doDeleteBtn click");
        event.stopPropagation();
        doDelete();
    });
    
//함수=================================================================================================
    //doUpdate : 수정
    function doUpdate() {
        console.log("doUpdate()");
        
        if(isEmpty(seqInput.value) == true){
            alert('seq를 확인 하세요.')
            //seqInput.focus();
            return;
        }
        
        if(isEmpty(titleInput.value) == true){
            alert('제목을 입력 하세요.')
            titleInput.focus();
            return;
        }
        
        //marker : simplemde.value()
        if(isEmpty(simplemde.value()) == true){
            alert('내용을 입력 하세요.')
            contentsTextArea.focus();
            return;
        }
        
        if(confirm("수정 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "POST";
        let url = "/doma/board/doUpdate.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
        		"seq"      : seqInput.value,
        		"div"      : divInput.value,
        		"gname"    : searchDivSelect.value,
                "title"    : titleInput.value,
                "modId"    : modIdInput.value,
                "content"  : simplemde.value()
            };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        alert(message.messageContents);
                        //window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
                         
                    }else{
                        alert(message.messageContents);
                    }
                    
                }catch(e){
                    alert("data를 확인 하세요");
                }
            }
        });
    }
    
    function moveToList() {
        window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
    }
    
    //doDelete : 삭제
    function doDelete() {
        console.log("doDelete()");
        
        if(isEmpty(seqInput.value) == true){
            alert('seq를 확인 하세요.')
            seqInput.focus();
            return;
        }
        
        if(confirm("삭제 하시겠습니까?") === false)return;
        
        //비동기 통신
        let type = "GET";
        let url = "/doma/board/doDelete.do";
        let async = "true";
        let dataType = "html";
        
        let params = {
            "seq"    : seqInput.value 
             
        };

        PClass.pAjax(url, params, dataType, type, async, function(data){
            if(data){
                try{
                    //JSON문자열을 JSON Object로 변환
                    const message = JSON.parse(data)
                    if(isEmpty(message) === false && 1 === message.messageId){
                        alert(message.messageContents);
                        //window.location.href = "/doma/board/doRetrieve.do?div=" + divInput.value;
                        moveToList();
                    }else{
                        alert(message.messageContents);
                    }
                    
                }catch(e){
                    alert("data를 확인 하세요");
                }
            }
        });
    }
});    
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
user : ${user }
seq : ${seq }
board : ${board }
<!-- container -->
<div class="container">
  <!-- 제목 -->
  <div class="page-header  mb-4">
    <h2>
        <c:choose>
           <c:when test="${ '10'== board.getDiv() }">커뮤니티</c:when>
           <c:when test="${ '20'== board.getDiv() }">공지사항</c:when>
           <c:otherwise>
                                공지사항/자유게시판
           </c:otherwise>
       </c:choose>
    </h2>
  </div> 
  <!--// 제목 end ------------------------------------------------------------->
  
  <!-- 버튼 -->
  <div class="mb-2 d-grid gap-2 d-md-flex justify-content-md-end">
      <input type="button" value="목록"  id="moveToList" class="btn btn-primary">
      <input type="button" value="수정"  id="doUpdate" class="btn btn-primary">
      <input type="button" value="삭제"  id="doDelete" class="btn btn-primary">
  </div>
  <!--// 버튼 ----------------------------------------------------------------->
  <!-- form -->
  <form action="#" class="form-horizontal"  name="regForm" id="regForm">
    <input type="hidden" name="seq"    id="seq" value="${board.seq}">
    <input type="hidden" name="div"    id="div" value="${board.getDiv()}">
    <div class="row mb-2">
        <label for="seq" class="col-sm-2 col-form-label">seq</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.seq}'/>" class="form-control readonly-input" readonly="readonly" name="seq" id="seq"  maxlength="20" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="div" class="col-sm-2 col-form-label">div</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.getDiv()}'/>" class="form-control readonly-input" readonly="readonly" name="div" id="div"  maxlength="20" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="views" class="col-sm-2 col-form-label">조회수</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.views}'/>" class="form-control readonly-input" readonly="readonly" name="views" id="views">
        </div>
    </div>
    <div class="row mb-2">
	    <label for="searchDiv" class="col-sm-2 col-form-label">구 이름</label>
	    <div class="col-sm-10">
	        <input type="text" value="<c:out value='${board.gname}'/>" class="form-control readonly-input" readonly="readonly" name="searchDiv" id="searchDiv">
	        <select name="searchDiv" class="form-select" id="selectDiv" onchange="document.getElementById('searchDiv').value=this.options[this.selectedIndex].text">
	            <option value="">구 선택</option>
	            <c:forEach var="item" items="${GNAME}">
	                <option value="${item.detCode}" <c:if test="${item.detCode == search.searchDiv }">selected</c:if>>${item.detNm}</option>
	            </c:forEach>
	        </select>
	    </div>
	</div>
    <div class="row mb-2">
        <label for="modId" class="col-sm-2 col-form-label">등록자</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.modId}'/>" class="form-control readonly-input" readonly="readonly" name="modId" id="modId"  maxlength="20" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="imgLink" class="col-sm-2 col-form-label">이미지 링크</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" name="imgLink" id="imgLink"  maxlength="75" required="required">
        </div>
    </div>
    <div class="row mb-2">
        <label for="title" class="col-sm-2 col-form-label">제목</label>
        <div class="col-sm-10">
          <input type="text" value="<c:out value='${board.title}'/>" class="form-control" name="title" id="title"  maxlength="75" required="required">
        </div>
    </div>
    <div class="row mb-2"">
        <label for="content" class="col-sm-2 col-form-label">내용</label>
        <div class="col-sm-10">
         <textarea style="height: 200px"  class="form-control" id="content" name="content"><c:out value='${board.content}'></c:out>
         </textarea>
        </div>
    </div>
  </form>
  <!--// form end -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</div>
<!--// container end ---------------------------------------------------------->
<script>
    var simplemde = new SimpleMDE({ element: document.getElementById("content")})
</script>

<%-- bootstrap js --%>
<script src="${CP}/resources/js/bootstrap/bootstrap.bundle.js"></script> 
</body>
</html>