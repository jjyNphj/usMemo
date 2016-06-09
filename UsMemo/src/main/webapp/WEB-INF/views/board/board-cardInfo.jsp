<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<!-- CardInfo Modal-->
   <div class="container">
      <div class="modal fade" id="cardInfoView" role="dialog">
         <div class="modal-dialog modal-lg">
            <div class="modal-content">
               <div class="modal-header">
                  <!-- span 안에 담기는 카드의 넘버를 cardInfoView.js로 넘겨주기 위함 -->
                  <span class="hide" id="card_num"></span>
                  <span class="hide" id="card_lnum"></span>
                  
                  <button type="button" class="close" data-dismiss="modal" onclick="clearForm(this.form)">&times;</button>
                  
                  <h4 class="modal-title" >
                     <!-- <h2 class="card-name-edit" id="card_Name" dir="auto"></h2> -->

                     <!-- 키를 누르는 순간마다 enterProcess로 값을 넘김. 엔터의 아스키코드값인 경우 사용자가 입력한 값 에이작스로 전달, heightResize:사용자 입력할떄마다 textarea 사이즈 자동조정 -->
                     <textarea class="textarea-card-name" id="card_Name" maxlength="200" onkeypress="enterSaveProcess(event,this)" onkeyup="heightResize(this)" ></textarea>
                  </h4>

                  <h6 class="modal-title" style="float:left;margin-left:25px;" >in list <span id="list_Name"></span></h6>
               </div>
               
               <div class="modal-body">
                  <p>You wrote:<br><span id="card_Date"></span></p>
                  <p>카드 상세 내용 입력하는 부분, 수정</p>

                  <!-- textarea의 내용 id변수에 저장 -->
                  <textarea class="form-control" style="resize:none;" rows="10"  id="cardDescription" placeholder="카드상세내용을 입력해주세요."></textarea>
                  <br>
                  
                  <button type="button" class="btn btn-primary" style="float:right;" onclick="addCardDescription(card_num,cardDescription)">&nbsp;Save&nbsp;</button>
                  <button type="button" class="btn btn-default" style="float:right;margin-right:5px" onclick="clearForm(this.form)">&nbsp;Clear&nbsp;</button>
                  <br>                  
               		
               		<%-- <input type="text"  value="${#card_num}"/> --%>
				  <form action="/usMemo/card/fileUploadAjax" id="formUpload" name="formUpload"  method="post" enctype="multipart/form-data">
				  <!-- <form method="post" enctype="multipart/form-data"> -->
                     <div class="form-group" >
                        <label for="exampleInputFile">파일 업로드</label> 
                        <input type="file" name="file1" id="exampleInputFile"  />
                        <input type="text" class="hide" name="cNum" id="uploadFile_card_num" /><!-- value="${card_num}" -->
                        <!-- <p class="help-block">파일 추가, 삭제, 다운</p> -->
                     </div>
                     <!-- <button type="submit" class="btn btn-default" onclick="fileUpload(card_num)">첨부하기</button> -->
                     <input type="submit" class="btn btn-default" value="첨부하기"/>
                  </form>
                  <div id="card_fileName"></div>
                  <!-- <a href="fileDown?fileName=$(#card_fileName)">$(#card_fileName) download</a> -->
               </div>
               <div class="modal-footer" style="padding:15px;">
                  <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="deleteCardInfo()">Card Delete</button>
               </div>
            </div>
         </div>
      </div>
   </div>
	<!-- /#cardInfo Modal -->